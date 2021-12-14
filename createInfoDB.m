%% Set environment variables

setenv('DJ_HOST', '127.0.0.1')
setenv('DJ_USER', 'root')
setenv('DJ_PASS', 'simple')

%% dj.createSchema

% dj.createSchema % create +info folder in parent folder on path, creates
% schema file for "info" database in that folder

%% Connected

dj.conn()

%% Mice

mouseList = [
  {'JB411', '2021-01-19', 'F'},
  {'JB412', '2021-03-03', 'M'},
  {'JB413', '2021-03-03', 'F'}
  {'JB414', '2021-03-03', 'M'}
];

info.Mice;

insert(info.Mice,mouseList);

%% Get session data from a folder

pathname=uigetdir;
files=dir([pathname,'/*.mat']);
numFiles = size(files,1);
%%
for ff = 1:numFiles
   filename = files(ff).name;
   filesToAdd(ff).session_filename = filename;
   filesToAdd(ff).mouse_id = filename(1:breaks(1)-1);    
   breaks = strfind(filename,'_');
   filesToAdd(ff).protocol = filename(breaks(1)+1:breaks(2)-1);
   filesToAdd(ff).session_day = filename(breaks(2)+1:breaks(3)-1);
   filesToAdd(ff).session_time = filename(breaks(3)+1:end-4);
   filesToAdd(ff).session_pathname = pathname;
end

%% insert files into Session

insert(info.Session,filesToAdd);


%% Setup ProtocolSettings lookup table

default_settings = {
'SessionTrials',
'TrialTypes',
'InfoSide',
'InfoOdor',
'RandOdor',
'ChoiceOdor',
'OdorA',
'OdorB',
'OdorC',
'OdorD',
'CenterDelay',
'CenterOdorTime',
'StartDelay',
'OdorDelay',
'OdorTime',
'RewardDelay',
'InfoBigDrops',
'InfoSmallDrops',
'RandBigDrops',
'RandSmallDrops',
'InfoRewardProb',
'RandRewardProb',
'GracePeriod',
'Interval',
'OptoFlag',
'OptoType',
'ImageFlag',
'ImageType',
'LicksRequired',
'DrinkingDelay',
'DoorsOn'};

default_setting_names = {
'session_trials',
'trial_types',
'infoside',
'info_odor',
'rand_odor',
'choice_odor',
'odor_a',
'odor_b',
'odor_c',
'odor_d',
'center_delay',
'center_odor_time',
'start_delay',
'odor_delay',
'odor_time',
'reward_delay',
'info_big_drops',
'info_small_drops',
'rand_big_drops',
'rand_small_drops',
'info_reward_prob',
'rand_reward_prob',
'grace_period',
'interval',
'optoflag',
'optotype',
'imageflag',
'imagetype',
'licks_required',
'drinking_delay',
'doors_on'};

settings = struct('protocol','InfoseekDoorBox','params_list',{default_settings},'param_names',{default_setting_names});
insert(info.ProtocolSettings,settings);
info.ProtocolSettings

%%

% infoside=fetchn(info.SessionSettings&'session_setting="infoside"','session_setting_value');

%% To view DB structure

erd info