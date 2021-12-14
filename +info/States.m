 %{
 # state transition data
 -> info.Trial
 state_num : int
 ---
 state_name : varchar(144)
 state_time : double
 %}

classdef States < dj.Imported

    methods(Access=protected)
        function makeTuples(self,key)

            data_path = fetch1(info.Session & key,'session_pathname');

            %use key struct to determine the data file path
            data_file = fullfile(data_path,key.session_filename);

            % load the data
            load(data_file);

            % get data            
            numTrials = fetch1(info.SessionData & key, 'trial_count');
            
            for i = 1:numTrials
                stateNames = SessionData.RawData.OriginalStateNamesByNumber{1,i};
                stateNums = SessionData.RawData.OriginalStateData{1,i};
                stateTimes = SessionData.RawData.OriginalStateTimestamps{1,i};
                for j = 1:numel(stateNums)
                   key.state_num = j;
                   key.state_name =  stateNames{stateNums(j)};
                   key.state_time =  stateTimes(j);
                   % insert the key into self
%                    self.insert(key)
                end
            end
        end
    end
end