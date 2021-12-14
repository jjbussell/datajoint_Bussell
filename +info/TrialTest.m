 %{
 # state transition data
 -> info.Trial
 state_num : varchar(10)
 ---
 %}

classdef TrialTest < dj.Part
    properties(SetAccess=protected)
        master = info.Trial;
    end    

    methods
        function makeTuples(self,key)

            data_path = fetch1(info.Session & key,'session_pathname');

            %use key struct to determine the data file path
            data_file = fullfile(data_path,key.session_filename);

            % load the data
            load(data_file);

            % get data            
%             numTrials = fetch1(info.SessionData & key, 'trial_count');
            
            trial_num = key.trial_num;
            stateNums = SessionData.RawData.OriginalStateData{1,trial_num};
                       
%             for i = 1:numTrials
%                 stateNames = SessionData.RawData.OriginalStateNamesByNumber{1,i};
%                 stateNums = SessionData.RawData.OriginalStateData{1,i};
%                 stateTimes = SessionData.RawData.OriginalStateTimestamps{1,i};
                for j = 1:numel(stateNums)
                   entity = key;
                   entity.state_num = ['s' num2str(j)];
                   % insert the key into self
                   self.insert(entity)
                end
%             end
        end
    end
end