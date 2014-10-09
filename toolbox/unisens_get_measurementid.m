function id = unisens_get_measurementid(unisensPath)
%UNISENS_GET_MEASUREMENTID Measrument ID of this measurement.
%   ID = UNISENS_GET_MEASUREMENTID()
%   ID = UNISENS_GET_TIMESTAMPSTART(PATH) returns the measurement ID of
%   this data set.

%   Copyright 2007-2011 FZI Forschungszentrum Informatik Karlsruhe,
%                       Embedded Systems and Sensors Engineering
%                       Malte Kirst (kirst@fzi.de)

%   Change Log         
%   2011-02-25  file established for Unisens 2.0, rev721
%   2014-03-26  cast result from Java string object to char


if (nargin >= 1)
    unisensPath = unisens_utility_path(unisensPath);
else
    unisensPath = unisens_utility_path();
end

j_unisensFactory = org.unisens.UnisensFactoryBuilder.createFactory();
j_unisens = j_unisensFactory.createUnisens(unisensPath);

id = char(j_unisens.getMeasurementId());

if (nargout == 0)
    disp(['Measurement ID: ', char(id)]);
end

j_unisens.closeAll();
