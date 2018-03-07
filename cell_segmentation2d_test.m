%% clear
clc; clear all; close all;

%% path
addpath('./lib');
addpath('../local_threshold2d/lib');
addpath('../local_threshold3d/lib');

%% load image
im = imread3d('./im/cell.tif');

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:)));

%% segmentation
n = 20; c = -1; s = 5;
imth = false(size(im));
for i=1:size(im,3)
    imth(:,:,i) = cell_segmentation2d(im(:,:,i),n,c,s);
end

%% plot
cmap = [0 1 0];
for i=1:size(im,3)
    % figure; 
    imrgb = cell_segmentation_plot2d(im(:,:,i),imth(:,:,i),cmap);
    pause(0.1);
end