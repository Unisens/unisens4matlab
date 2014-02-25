function unisens_install()
% UNISENS_INSTALL installs Unisens toolbox permanently
% 
%   Example:
%
%   unisens_install

%   Copyright 2010      FZI Forschungszentrum Informatik Karlsruhe,
%                       Embedded Systems and Sensors Engineering
%                       Malte Kirst (kirst@fzi.de)
%                       Joerg Ottenbacher (joerg.ottenbacher@kit.edu)

%   Change Log         
%   2010-04-23  file established 
%   2010-04-28  toolboxdir-bug fixed
%   2010-05-21  better handling of classpath.txt


TOOLBOX = 'ANT_TOOLBOX';
URL = 'ANT_URL';

disp(' ');
disp('***********************************************************************');
disp(' ');
disp('This is the Unisens installation tool for Matlab. This tool will');
disp(['download the file ', TOOLBOX, ' from']);
disp([URL, ' and install it permanently.']);
disp(' ');
disp('When you have already installed the Unisens toolbox, it will be replaced');
disp('without request.');
disp(' ');

a = input('Do you want to continue? (y/n)\n', 's');
disp(' ');

if (~strcmpi(a, 'y'))
    disp('Installation aborted');
    disp(' ');
    return;
end


%  Check Java version
disp('Checking Java version...');
javaVersion = version('-java');
if (~length(strfind(javaVersion, 'Java 1.6')))
    error([javaVersion, ' is installed. Unisens needs Java version 1.6.']);
else
    disp([javaVersion, ' is installed.']);
    disp(' ');
end


% Check installed Unisens version
disp('Checking previous installed Unisens toolbox...');
try
    % If the toolbox is installed, remove toolbox directory.
    rmdir(toolboxdir('unisens'), 's');
catch
    % The toolbox is not installed. Check older unisens installations.
    try
        tmp = which('unisens_version');
        tmp = strrep(tmp, 'unisens_version.m', '');
        error(['Unisens is already installed (version ', unisensVersion, '). Remove this version before continue. Remove ', tmp, ' from PATH before continue.']);
    catch
    end
end
disp(' ');


% Check permissions
disp('Checking file permissions...');
s = mkdir([matlabroot, filesep, 'toolbox', filesep, 'unisens']);
if (~s)
    error('Cannot write to toolbox folder.');
end
disp(' ');
    

% Download toolbox and extract to Matlab toolbox folder.
disp('Downloading data...');
unzip([URL, TOOLBOX], [matlabroot, filesep, 'toolbox', filesep]);
disp(' ');


% Check classpath for unisens library
disp('Editing Java classpath...');
clear java;
classPathList = javaclasspath('-static');
nClassPathList = length(classPathList);
unisensPath = [matlabroot, filesep, 'toolbox', filesep, 'unisens', filesep, 'lib', filesep];


% Remove eventually existing Unisens jar files from classpath list
newClassPathList = {};
for (i = 1:nClassPathList)
    if (isempty(strfind(classPathList{i}, 'org.unisens.jar')) && ...
            isempty(strfind(classPathList{i}, 'org.unisens.ri.jar')))
        newClassPathList = [newClassPathList; classPathList(i)];
    end
end


% Add new Unisens jar files to classpath list
newClassPathList = [newClassPathList; [unisensPath, 'org.unisens.jar']];
newClassPathList = [newClassPathList; [unisensPath, 'org.unisens.ri.jar']];


% Edit classpath.txt and add library to static path
classPathFile = which('classpath.txt');
copyfile(classPathFile, [classPathFile '.bak.unisens']);
try
    h = fopen(classPathFile, 'w');
    fprintf(h, '%s\n', newClassPathList{:});
    fclose(h);
catch
    fprintf(['\nInstaller cannot edit classpath.txt. You have to edit classpath.txt \n'...
          'manually. Type "edit classpath.txt" in your Matlab command window and\n'...
          'insert the following lines at the end of the file:\n\n'...
          unisensPath, 'org.unisens.jar', '\n', unisensPath, 'org.unisens.ri.jar', '\n\n']);
end


% Add library to dynamic path (optional).
javaaddpath([unisensPath, 'org.unisens.jar']);
javaaddpath([unisensPath, 'org.unisens.ri.jar']);
disp(' ');


% Add toolbox to Matlab path and save this
disp('Editing Matlab path...');
addpath([matlabroot, filesep, 'toolbox', filesep, 'unisens']);
if (savepath())
    error('Matlab path cannot be saved permanently.');
end
disp(' ');


disp('Installation successful. More information on http://unisens.org');
disp(' ');
disp('***********************************************************************');
disp(' ');
% disp('You have to configure the toolbox manually. Please click the Matlab START');
% disp('button -> DESKTOP TOOLS -> VIEW START BUTTON CONFIGURATION FILES. Press the');
% disp('REFRESH START BUTTON and close the window. Now you can find the toolbox in');
% disp('in the toolbox menu.');
disp('You have to restart Matlab now!');
disp(' ');
