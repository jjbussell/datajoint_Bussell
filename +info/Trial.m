 %{
 # trial raw behavior data
 -> info.SessionData
 trial_num : int
 ---
 trial_type : tinyint
 outcome : tinyint
 trial_start_timestamp : double
 trial_end_timestamp : double

 %}

classdef Trial < dj.Imported

    methods(Access=protected)
        function makeTuples(self,key)

            data_path = fetch1(info.Session & key,'session_pathname');

            %use key struct to determine the data file path
            data_file = fullfile(data_path,key.session_filename);

            % load the data
            load(data_file);

            % get data
            trialTypes = SessionData.TrialTypes;
            outcomes = SessionData.TrialTypes;
            trialStarts = SessionData.TrialStartTimestamp;
            trialEnds = SessionData.TrialEndTimestamp;
            
            numTrials = fetch1(info.SessionData & key, 'trial_count');
            
            for i = 1:numTrials
                key.trial_num = i;
                entity = key;
                key.trial_type = trialTypes(i);
                key.outcome = outcomes(i);
                key.trial_start_timestamp = trialStarts(i);
                key.trial_end_timestamp = trialEnds(i);

                % insert the key into self
                self.insert(key)
                
                makeTuples(info.TrialTest, entity)
            end
        end
    end
end