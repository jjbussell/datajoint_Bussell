%{
    # Bpod behavior experiment session settings
    protocol : varchar(144)
    ---
    params_list      : longblob
    param_names : longblob
%}
    
classdef ProtocolSettings < dj.Lookup
end
