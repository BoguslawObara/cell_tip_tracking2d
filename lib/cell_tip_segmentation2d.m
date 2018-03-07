function [imtht,r] = cell_tip_segmentation2d(imth,imthto,x,y,d,r)
%% cell_tip_segmentation2d - 2d cell tip segmentation
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

if isempty(imthto)
    imn = zeros(size(imth))==1;
    imn(x,y) = 1;
    imm = imn;
else
    imn = zeros(size(imth))==1;
    imn(x,y) = 1;
    se = strel('disk',double(round(r)));
    imd = imdilate(imn,se);
    ima = imth & imd;
    imlabel = bwlabel(ima);
    s  = regionprops(imlabel, 'centroid');
    c = cat(1, s.Centroid);
    c = round(c);
    imn = zeros(size(imth))==1;
    imn(c(2),c(1)) = 1;
    imm = imn;    
end
imthr = imreconstruct(imm,imth);
imd = bwdist(imn);
imdm = immultiply(imd,imthr);

m = 3;
while m>1
    imtht = imdm>0 & imdm<d; 
    imtht = imfill(imtht,'holes');
    if isempty(imthto)
        imm = imn;
    else
        imm = imtht & imm;
    end    
    imtht = imreconstruct(imm,imtht);
    immask = immultiply(imthr,~imtht);
    imlabel = bwlabel(immask);
    m = max(imlabel(:));
    d = d + 1;
end   

%% image contour and selected region contour
imd = bwdist(~imtht);
r = mean(imd(imtht));
imsk = bwmorph(imth,'skel',Inf);
imsk = imsk & imtht;
r = median(imd(imsk));

end
