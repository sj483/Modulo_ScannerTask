function [TaskIO] = setTaskIO(SubjectId,RunId)

randomSeed = hex2dec(SubjectId) + RunId*100;
rng(randomSeed,"twister");

%% Set the index of the Sup paris
supIdx = [
    0;
    1;
    2;
    4;
    5;
    7;
    9;
    11;
    12;
    14;
    15;
    16;
    18;
    19;
    20;
    22;
    24;
    25;
    27;
    29;
    30;
    33;
    35];

nonComIdx = [
    8;
    13;
    17;
    21;
    28;
    32];


%% Select 4 different columns of the addition table (NbackCol)
supCol = floor(supIdx./6);
supColPmf = histcounts(supCol,6)'./numel(supIdx);
supColCdf = cumsum(supColPmf);

nBackCol = nan(4,1);
for ii = 1:4
    selCol = find(rand(1)<supColCdf,1);
    selPmf = supColPmf(selCol);
    supColPmf(selCol) = 0;
    stillIn = supColPmf>0;
    supColPmf = supColPmf + double(stillIn).*(selPmf/sum(stillIn));
    supColCdf = cumsum(supColPmf);

    nBackCol(ii) = selCol-1;
end

%% Select the Nback pairs (nBackIdx)
nBackIdx = nan(size(nBackCol));
for ii = 1:numel(nBackIdx)
    nBackIdx(ii) = randsample(supIdx(supCol==nBackCol(ii)), 1);
end

%% Set the order of OneBack and TwoBack
nBackType = [1;1;2;2];
nBackType = nBackType(randperm(numel(nBackType)));

%% Get the OptSeq
optSeq = load("OptSeq.mat");
optSeq = optSeq.OptSeq;
optSeqNoNan = optSeq(~isnan(optSeq));
optSeqSquare = reshape(optSeqNoNan,6,6);
gridPerm = randperm(6);
optSeqSquare = optSeqSquare(gridPerm,gridPerm);
optSeqNoNan = optSeqSquare(:);
optSeq(~isnan(optSeq)) = optSeqNoNan;

%% Preallocate the TaskIO structure
numTrials = 6^2 + 4;
TaskIO = repmat(struct( ...
    'TrialType', '', ...
    'PairId', NaN, ...
    'isiLength', NaN, ...
    'arrayPerm', [], ...
    'startPos', NaN, ...
    'a', NaN,...
    'b', NaN,...
    'r', NaN,...
    'tShowA', NaN,...
    'tShowB', NaN,...
    'tArray', NaN,...
    'tRespo', NaN), ...
    numTrials,1);

%%
for iTrial = 1:numTrials
    cPairId = optSeq(iTrial);
    TaskIO(iTrial).PairId = cPairId;

    if isnan(cPairId)
        TaskIO(iTrial).TrialType = 'Null';

    else
        TaskIO(iTrial).isiLength = getISI();
        TaskIO(iTrial).arrayPerm = randperm(6);
        TaskIO(iTrial).startPos = randi(6);
        a = mod(cPairId, 6);
        b = mod(floor(cPairId / 6), 6);
        TaskIO(iTrial).a = a;
        TaskIO(iTrial).b = b;

        if ismember(cPairId, nBackIdx)
            inbackIdx = find(cPairId == nBackIdx, 1);
            n = nBackType(inbackIdx);
            TaskIO(iTrial).TrialType = append(num2str(n), 'Back');

        elseif ismember(cPairId, (0:5)) || (mod(cPairId,6)==0)
            TaskIO(iTrial).TrialType = 'ZeroPlus';

        elseif ismember(cPairId, supIdx)
            TaskIO(iTrial).TrialType = 'Sup';

        elseif ismember(cPairId, nonComIdx)
            TaskIO(iTrial).TrialType = 'NonCom';

        else
            TaskIO(iTrial).TrialType = 'Com';
        end
    end

end
return