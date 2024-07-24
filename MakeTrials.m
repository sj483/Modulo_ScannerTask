function [TaskIO] = MakeTaskIO()

% Select the task sets
TaskSets05 = [...
    00;
    02;
    03;
    05;
    06;
    08;
    09;
    10;
    12;
    14;
    15;
    18;
    19;
    20;
    21;
    23];

NullSet = [-1,-1,-1,-1,-1]
%NbackSet = [-2,-2,-2,-2,-2]

% Preallocate the TaskIO structure with repmat
numTrials = 25;  % Assuming (5^2) trials
TaskIO = repmat(struct('TrialType', '', ...
    'PairId', '', 'a', '', 'b', '', ...
    'sprkAimg', '',...
    'sprkBimg', '', 'symbImg', '',...
    'isiLength', '',...
    'CorrectResponse', '',...
    'ActualResponse', '',...
    'PTBtimeStart', '',...
    'PTBresponseLog', '',...
    'ScanTimeStart', '',...
    'ScanTimeResponse', ''), numTrials, 1);

%% Make the TaskSet for the set of 5
nSup = numel(TaskSets05);
nUns = (5^2) - nSup;
for PairId = 0:((5^2) - 1)
    TrialObj = struct;
    TrialObj.FieldSize = 5;
    TrialObj.PairId = PairId;
    TrialObj.OppId = 0;
    
    % Calculate a, b and c
    a = mod(PairId, 5);
    b = mod(floor(PairId / 5), 5);
    c = mod(a + b, 5);
    TrialObj.FieldIdx_A = a;
    TrialObj.FieldIdx_B = b;
    TrialObj.FieldIdx_C = c;
    
    % Check whether this pair is supervised
    Sup = ismember(PairId, TaskSets05);
    
    % Label the trial types and add Ptarget
    if Sup
        TrialObj.TrialType = 'Sup';
        TrialObj.Ptarget = 3 / ((nSup * 3) + nUns);
    else
        TrialObj.TrialType = 'Uns';
        TrialObj.Ptarget = 1 / ((nSup * 3) + nUns);
    end
    
    % Construct an array of trial objects
    if PairId == 0
        Trials = TrialObj;
    else
        Trials(PairId + 1, 1) = TrialObj;
    end
end   


% Populate TaskIO structure for each trial
for iR = 1:numel(Trials)
    TaskIO(iR).TrialType = Trials(iR).TrialType;
    TaskIO(iR).PairId = Trials(iR).PairId;
    TaskIO(iR).a = Trials(iR).FieldIdx_A;
    TaskIO(iR).b = Trials(iR).FieldIdx_B;
    TaskIO(iR).CorrectResponse = Trials(iR).FieldIdx_C;
    disp(TaskIO(iR));
    disp(TaskIO)
end

% double the number of trials
TaskIO = repmat(TaskIO,2,1)

%make a new struct with the same fields as TaskIO which we're going to use
%to add onto the bottom of TaskIO
temp_struct = TaskIO(1:5)

%loop through fields of temp struct empty them
% Retrieve the field names of the structure
fields = fieldnames(temp_struct);

% Loop through each field and set it to an empty array
for i = 1:numel(fields)
        [temp_struct.(fields{i})] = deal([]); 
end

TaskIO = vertcat(TaskIO, temp_struct);

for i = 51:55  % Assumed 50 trials, this is hard coded and probably needs changing 
    TaskIO(i).TrialType = 'Null'
end

TaskIO;

