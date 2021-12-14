 %{
 # experiment session raw behavior data
 ->info.Mice
 ->info.ProtocolSettings
 session_filename: varchar(144) # Bpod filename
 session_day: date            # session date
 
 ---
session_time : time # session start time
 session_pathname : varchar(144) # Path to Bpod file
 %}

 classdef Session < dj.Manual
 end