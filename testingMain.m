%Testing main
% Here I test objects and calls
clc; clear all; close all;
inputPathFileXML='/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/square_annotations1/BD04_inf_201724_004_01_RGB.xml';
%inputPathFileXML='/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/square_annotations1/20170916calibracion.xml';


IRGB=imread('/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/images/BD04_inf_201724_004_01_RGBhr.jpg');
load('/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/images/BD04_inf_201724_004_01_DS.mat');
INIR=NIR_DEPTH_res_crop;

[X Y]=XMLObjectsHelper.readXMLFromFIle(inputPathFileXML);
% X(1,:)