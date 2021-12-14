%{
    # Bpod behavior experiment session settings
    ->info.SessionData
    session_setting: varchar(144)
    ---
    session_setting_value  = NULL : double
%}
    
classdef SessionSettings < dj.Imported
%     properties(SetAccess=protected)
%         master = info.SessionData
%     end
    methods(Access=protected)
        function makeTuples(self, key)

            data_path = fetch1(info.Session & key,'session_pathname');

            %use key struct to determine the data file path
            data_file = fullfile(data_path,key.session_filename);
            % load the data
            load(data_file);                        
            settings = SessionData.SettingsFile.GUI;
            
            [setting_list, setting_names]=fetchn(info.ProtocolSettings & key,'params_list','param_names');

            for i = 1:length(setting_list{1})
                
                   key.session_setting = setting_names{1}{i};
                   if isfield(settings,(setting_list{1}{i}))
                   key.session_setting_value = settings.(setting_list{1}{i});
                   
                   end
                self.insert(key);
            end
 
        end
    end
end
