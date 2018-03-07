function imth = cell_segmentation2d(im,n,c,s)
%% cell_segmentation2d - 2d cell segmentation
%   
%   REFERENCE:
%       A. Lichius, A. B. Goryachev, M. D. Fricker, B. Obara, 
%       E. Castro-Longoria, N. D. Read, CDC-42 and RAC-1 regulate opposite 
%       chemotropisms in Neurospora crassa, 
%       Journal of Cell Science, 127, 9, 1953-1965, 2014
%
%   INPUT:
%
%   OUTPUT:
%
%   AUTHOR:
%       Boguslaw Obara

%% local threshold
imth = mean_threshold2d(im,n,c);

%% filter
se = strel('disk',s);
imthc = imopen(imth,se);
imthr = imreconstruct(imthc,imth);
imth = imfill(imthr,'holes');

end