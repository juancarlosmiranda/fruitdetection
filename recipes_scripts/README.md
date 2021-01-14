-----------
#README
-----------
Fruit detector based in machine learning techniques.
From a dataset xxxxx, segment fruits by K-means and with an SVM filter by color.

script_Calculation_NDI_index.m
This script contains the NDI calculation implemented in Matlab to subtract red colors and green colors. Use the binary mask technique to obtain the desired object. This technique is widely used in computer vision systems applied to agriculture.

scriptNIR.m -->
Script to get images cropped, cut images with a rectagle coordinates. Shows a general images and one fruit cropped.

scriptNIRCopy.m -->
Given an image and its NIR data, this scripts cuts each fruit and put the result in a final image to show only the fruits cropped. It produces a heatmap to show NIR data.

scriptOverlapRatio.m -->
Comparaing IoU calculated by MATLAB Computer Vision Toolbox and a function with matemathical operations.

scriptSegmentationNIR.m -->
Given an image and its NIR data, filter by threshold NIR data in channel 1 to get a first approximation of fruits in a rgb IMAGE.


