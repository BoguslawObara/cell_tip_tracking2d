function imthf = cell_segmentation_filtering2d(imth,s1,s2)

%% filter
se = strel('disk',s1);
%imthf = imtophat(imth,se);
imthf = imopen(imth,se);
imthf = imreconstruct(imthf,imth);
imthf = imfill(imthf,'holes');    

se = strel('disk',s2);
imthf = imclose(imthf,se);
imthf = imopen(imthf,se);

end