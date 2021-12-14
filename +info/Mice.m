%{
# mice
mouse_id: char(5)                  # unique mouse id
---
dob: date                      # mouse date of birth
sex: enum('M', 'F', 'U')       # sex of mouse - Male, Female, or Unknown/Unclassified
%}

classdef Mice < dj.Manual
end