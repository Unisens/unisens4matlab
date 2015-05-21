# unisens4matlab

unisens4matlab is a Matlab toolbox for the Unisens data format. It makes use of the [unisens4java library](https://github.com/Unisens/unisens4java).

Unisens is a **universal data format for multi sensor data**. It was developed at the [FZI Research Center for Information Technology](http://www.fzi.de/en/about-us/organisation/research-divisions/ess-embedded-systems-and-sensors-engineering/) and the [Institute for Information Processing Technology (ITIV)](http://www.itiv.kit.edu) at the University of Karlsruhe. The motivation for specifying a new data format was the need for a universal, generic and sustainable format for storing and archiving sensor data from various recording systems. Other main requirements were a human readable header and the use of future-proof standards.

For more information please check the [Unisens website](http://www.unisens.org).

## Simple example
```matlab
path = 'C:\data\2014-06-20 14.01.19'; % Sample data path, where the unisens.xml file is located
jUnisensFactory = org.unisens.UnisensFactoryBuilder.createFactory();
jUnisens = jUnisensFactory.createUnisens(path);

% Read a binary file
accEntry = jUnisens.getEntry('acc.bin');
accData = accEntry.readScaled(accEntry.getCount()); % In accData will be the values of acc.bin

% Read a values list
hrvEntry = jUnisens.getEntry('HrvRmssd.csv');
hrvValueList = hrvEntry.readValuesList(hrvEntry.getCount());
hrvTimeStamps = hrvValueList.getSamplestamps();
hrvData = hrvValueList.getData();

jUnisens.closeAll();
```

If Unisens meets your requirements, feel free to try it. unisens4matlab is licenced under
the <acronym title="GNU Lesser General Public Licence">LGPL</acronym> and it may be downloaded [in the download section](http://www.unisens.org/downloads.php).
