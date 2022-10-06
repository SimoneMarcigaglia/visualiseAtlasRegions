# visualiseAtlasRegions

Create Surface plot of brain region annotated in Allen mouse brain atlas by ID.

## Setup

 - Download the original Allen mouse brain annotation files from this [link](http://download.alleninstitute.org/informatics-archive/current-release/mouse_ccf/annotation/ccf_2017/).
 - Download the structure tree of the annotated regions *structure_tree_safe.csv* (courtesy of CortexLab) from this [link](http://data.cortexlab.net/allenCCF/).
 - Download an nrrd file reader such as this [one](https://nl.mathworks.com/matlabcentral/fileexchange/34653-nrrd-format-file-reader).
 
 
## Usage

Check out *exampleUsage.m* for an example of how to create a plot or an animation. The creation 
of each surface with *isosurface* can take some time and be quite computationally expensive (on RAM usage especially).
This higly depends on the version of the atlas used, where the high-resolution(10um) version will take the most time 
but will be the best looking.

The spreadsheet *Annotated regions list.xlsx* can be used to quickly look up the id of the region(s) to be displayed.

## Example

![example animation](animation.gif)