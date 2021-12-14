 %{
 # experiment session raw behavior data
 -> info.Session
 ---
 trial_count: int  # session number of completed trials

 %}

classdef SessionData < dj.Imported

    methods(Access=protected)
        function makeTuples(self,key)

            data_path = fetch1(info.Session & key,'session_pathname');

            %use key struct to determine the data file path
            data_file = fullfile(data_path,key.session_filename);

            % load the data
            load(data_file);

            % add the loaded data as the "activity" column
            key.trial_count = SessionData.nTrials;
            
            % get list of settings
%             filesettings = fetch1(info.SessionSettings & key,'params_list');
%             key.filesettings(1) =

            % insert the key into self
            self.insert(key)
            
        end
    end
end