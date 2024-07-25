hrf = spm_hrf(1/1000);
hrf = hrf./sum(hrf);

tr = 2;
unshufTypes = [nan(4,1);(0:35)'];
unshufIsi = [repmat((1:5)',7,1);3];

trialDur = 1+3+3+3+1+6;
nTrials = 36;
nullDur = 8;
nNulls = 4;
T = trialDur*nTrials + nullDur*nNulls;

filterPeriod = 128; % Seconds
nScans = round(T/tr);
k = fix((2*nScans*tr/filterPeriod)+1); % Order of high-pass filter
CosBasis = spm_dctmtx(nScans,k);
CosBasis = flip(CosBasis,2);
CosBasis = CosBasis./CosBasis(1,:); % Scale them so that are actual cosines

H{1,1} = eye(12);
H{1,1} = [H{1,1}, zeros(12, size(CosBasis,2))];
H{2,1} = [eye(6),eye(6)]./2;
H{2,1} = [H{2,1},zeros(6, size(CosBasis,2))];

nI = 100;
SearchStruct = struct('TypePerm',[],'ISI',[],'eH1',NaN,'eH2',NaN);
SearchStruct = repmat(SearchStruct,nI,1);
fh = waitbar(0,"Running...");
for iI = 1:nI
    cTypes = unshufTypes(randperm(numel(unshufTypes)));
    cIsi = unshufIsi(randperm(numel(unshufIsi)));
    SearchStruct(iI).TypePerm = cTypes;
    SearchStruct(iI).ISI = cIsi;

    X = zeros(T*1000,12);
    t = 0;
    iNonNull = 0;
    for icType = 1:numel(cTypes)
        if isnan(cTypes(icType))
            t = t + nullDur*1000;
        else
            iNonNull = iNonNull + 1;

            a = mod(cTypes(icType),6);
            b = floor(cTypes(icType)/6);
            ia = a+1;
            ib = 6+ b+1;

            % Fix cross
            t = t + 1000;

            % a
            X((t+1):(t+3001),ia) = 1;
            t = t + 3000;

            % isi
            t = t + cIsi(iNonNull)*1000;

            % b
            X((t+1):(t+3001),ib) = 1;
            t = t + 3000;

            % other stuff
            t = t + 7000;
        end
    end

    %% Conv X
    for iX = 1:size(X,2)
        v = X(:,iX);
        cv = conv(v,hrf);
        X(:,iX) = cv(1:(T*1000));
    end

    %% Downsample
    X = X((tr/2*1000):(1000*tr):end ,:);

    %% Add the cosine basis set
    Xx = [X,CosBasis];
    clear X;
    X = Xx;
    clear Xx;

    %% Compute efficincy
    icX = inv(X'*X);
    for iH = 1:numel(H)
        cH = H{iH};
        SearchStruct(iI).(sprintf('eH%i',iH)) = ...
            1/trace(cH*icX*cH'); %#ok<MINV>
    end

    %% Waitbar
    if mod(iI,109)==108
        waitbar(iI/nI,fh);
    end

end
close(fh);