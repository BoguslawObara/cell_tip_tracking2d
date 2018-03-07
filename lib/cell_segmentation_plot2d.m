function imrgb = cell_segmentation_plot2d(im,imth,cmap)

imr = im; img = im; imb = im;
imr(bwperim(imth)) = cmap(1);
img(bwperim(imth)) = cmap(2);
imb(bwperim(imth)) = cmap(3);
imrgb(:,:,1) = imr; 
imrgb(:,:,2) = img; 
imrgb(:,:,3) = imb;  
imagesc(imrgb); axis image; axis tight; axis image; axis off; 

end