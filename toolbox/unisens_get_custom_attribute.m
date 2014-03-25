function rs = unisens_get_custom_attribute(unisensPath, key)
%UNISENS_GET_CUSTOM_ATTRIBUTE get custom attribute value
%   VALUE = UNISENS_GET_CUSTOM_ATTRIBUTE(PATH) returns all custom 
%   attributes in unisens.xml in PATH as a cell array.
%   VALUE = UNISENS_GET_CUSTOM_ATTRIBUTE(PATH, KEY) returns only the value 
%   of the custom attribute with the key KEY.
%
%   When using without left-hand argument
%   UNISENS_GET_CUSTOM_ATTRIBUTE(...) does only show the results and
%   returns nothing.
%
%   This function will return an empty array if no matchin key is found.

%   Copyright 2014      Karlsruhe Institute of Technology
%                       Malte Kirst (malte.kirst@kit.edu)

% Open the unisens data set and read the custom attributes
unisensPath = unisens_utility_path(unisensPath);
j_unisensFactory = org.unisens.UnisensFactoryBuilder.createFactory();
j_unisens = j_unisensFactory.createUnisens(unisensPath);
j_customAttributes = j_unisens.getCustomAttributes();

% List the custom attributes or select just the one with the key KEY.
if (nargin == 1)
    j_keys = j_customAttributes.keySet().toArray();
    j_values = j_customAttributes.values().toArray();
    value = cell(1, j_keys.length);
    
    for (i = 1:j_keys.length)
        disp([j_keys(i) ': ' j_values(i)]);
        value{i} = [j_keys(i) ': ' j_values(i)];
    end
    
    if (nargout ~= 0)
        rs = value;
    end
else
    value = j_customAttributes.get(key);
    if (nargout == 0)
        disp([key ': ' value]);
    else
        rs = value;
    end
end

% Don't forget to close the data set.
j_unisens.closeAll();
