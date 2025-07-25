# MAG Data Visualization Toolbox

[![Imperial College Space Magnetometer Laboratory](https://img.shields.io/badge/Author-Space%20Magnetometer%20Laboratory-ff69b4.svg)][sml]
[![MATLAB Tests](https://github.com/ImperialCollegeLondon/MAG-Data-Visualization-Toolbox/actions/workflows/test.yml/badge.svg)](https://github.com/ImperialCollegeLondon/MAG-Data-Visualization-Toolbox/actions/workflows/test.yml)
[![MATLAB Toolbox](https://github.com/ImperialCollegeLondon/MAG-Data-Visualization-Toolbox/actions/workflows/package.yml/badge.svg)](https://github.com/ImperialCollegeLondon/MAG-Data-Visualization-Toolbox/actions/workflows/package.yml)
[![View MAG Data Visualization Toolbox on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/169568)

This repository contains utilities for processing and visualizing MAG science and HK data. The supported MATLAB releases are MATLAB R2024a and later.

The following MATLAB toolboxes are required to use the toolbox:

* MATLAB
* Signal Processing Toolbox
* Statistics and Machine Learning Toolbox
* Text Analytics Toolbox

The following external MATLAB libraries are required:

* MATLAB SPICE (MICE): <https://naif.jpl.nasa.gov/naif/toolkit_MATLAB.html>
* MATLAB SPDF CDF: <https://cdf.gsfc.nasa.gov/html/sw_and_docs.html>

## Getting Started

The toolbox adds to the path many functions and classes that can be used for data processing and visualization. These can be found under the `mag` namespace; you can use tab-completion to see what is available:

``` matlab
mag.<TAB>
```

In the sections below you can find more information about some of the functionalities.

## User Manual

See [internal documentation](https://imperialcollege.atlassian.net/wiki/spaces/PMLSD/pages/453279745/Data+Visualization) on Confluence.

## Development

To get started, clone this repository and install the package for development:

``` matlab
mpminstall(pwd(), Authoring = true);
```

When developing new features or fixing issues, create a new branch. After finishing development, make sure to write tests to cover any new changes.

To change the version of the toolbox, modify the package definition file in `resources/mpackage.json`. This will automatically update the toolbox version and create a new toolbox with the correct version.
Also, update the contents of the `resources/release-notes.md` file by detailing what has changed in the new version.

## License

MAG Data Visualization Toolbox is released under the [MIT license][license].

[license]: LICENSE.md
[sml]: http://www.imperial.ac.uk/space-and-atmospheric-physics/research/areas/space-magnetometer-laboratory/
