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

%% filter
s1 = 5; s2 = 1;
imthf = false(size(imth));
for i=1:size(imth,3)
    imthf(:,:,i) = cell_segmentation_filtering2d(imth(:,:,i),s1,s2);
end

%% tip segmentation and tracking
% [y,x] = ginput(1);
% x = round(x); y = round(y);

x = 60; y = 284; d = 40; r = [];
s = 3; 

imthti = [];
tip = struct([]);
imtht = false(size(imth));
for i=1:size(im,3)
    
    [imthti,r] = cell_tip_segmentation2d(imthf(:,:,i),imthti,x,y,d,r);
    imtht(:,:,i) = imthti;
    
    dc = 2*round(r);
    [center,radius,c,cm,cr,cl,center2] = cell_tip_search2d(imthf(:,:,i),imthti,x,y,dc,1);
    x = center(1); y = center(2);
    x = round(x); y = round(y);

    tip(i).center = center;
    tip(i).radius = radius;
    tip(i).c = c;
    tip(i).cm = cm;
    tip(i).cr = cr;
    tip(i).cl = cl;
    tip(i).center2 = center2;

    p = 2*round(r);
    [pr,pl,nr,nl,xce,yce,imthe] = cell_tip_profile2d(imth(:,:,i),imtht(:,:,i),c,cm,p,s);
    
    % dist
    imthm = imthf(:,:,i);
    imthm(imthe) = 0;
    imd = bwdist(imthm);
    
    % plot
    % cell_tip_profile_plot2d(im,pr,pl);
    
    % filter
    h = fspecial('gaussian',3*s,s);
    imf = imfilter(im(:,:,i),h);
    
    % fitting Gaussian
    xp = (-nl+1:nr-1)';
    %xp = xp/gui.res;
    yp = zeros(nl+nr-1,1);
    ypd = zeros(nl+nr-1,1);
    c = zeros(nl+nr-1,2);
    for j=1:nl
        yp(j) = imf(pl(nl-j+1,1),pl(nl-j+1,2));
        ypd(j) = imd(pl(nl-j+1,1),pl(nl-j+1,2));
        c(j,1) = pl(nl-j+1,1);
        c(j,2) = pl(nl-j+1,2);
    end
    for j=2:nr
        yp(j+nl-1) = imf(pr(j,1),pr(j,2));
        ypd(j+nl-1) = imd(pr(j,1),pr(j,2));
        c(j+nl-1,1) = pr(j,1);
        c(j+nl-1,2) = pr(j,2);
    end
    
    % interpolate to keep the same length of profile
    res = (max(xp)-min(xp))/(2*p);
    xp2 = (min(xp):res:max(xp))';
    yp2 = interp1(xp,yp,xp2);
    ypd2 = interp1(xp,ypd,xp2);
    xp = xp2; yp = yp2; ypd = ypd2;     
    
    cp = [];
    ci = 1:(size(c,1)-1)/(size(xp,1)-1):size(c,1);
    cp(:,1) = interp1(1:size(c,1),c(:,1),ci);
    cp(:,2) = interp1(1:size(c,1),c(:,2),ci);
    
    % calculate profile line parameters
    [a1,a2,a3,a4,cfun,er] = profile_parameters2d(double(xp),double(yp));
    
    % calculate estimated profile coordinaties
    ypfit = feval(cfun,xp);
    
    % plot
    cell_tip_profile_fit_plot2d(xp,yp,ypfit,a1,a2,a3,a4);  
    
end