hrf = spm_hrf(1/1000);
hrf = hrf./sum(hrf);

tr = 2;
unshufIsi = [repmat((1:5)',7,1);3];
unshufTypes = [nan(4,1);(0:35)'];

trialDur = 1+3+3+3+1+6;
nTrials = 36;
nullDur = 8;
nNulls = 4;
T = trialDur*nTrials + nullDur*nNulls;

nI = 1;
for iI = 1:nI
    cIsi = unshufIsi(randperm(numel(unshufIsi)));
    cTypes = unshufTypes(randperm(numel(unshufTypes)));
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
end