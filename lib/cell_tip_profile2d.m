function [cr,cl,nr,nl,xce,yce,imthe] = cell_tip_profile2d(imth,imtht,c,cm,d,s)
%% erode
se = strel('disk',s);
imthe = imerode(imth,se);
imthte = imerode(imtht,se);
imlabel = bwlabel(imthte);
for i=1:max(imlabel(:))
    a(i) = sum(sum(imlabel==i));
end
imthte = imlabel==find(a==max(a));
imthe = imreconstruct(imthte,imthe);

%% shortest distance
imt = zeros(size(imtht))==1;
imt(c(cm,1),c(cm,2)) = 1;
imdist = bwdist(imt);

[x,y] = find(imthe,1);
ce = bwtraceboundary(imthe,[x,y],'N',8);
idxI = sub2ind(size(imth),ce(:,1),ce(:,2));
dt = imdist(idxI);
idxd = find(dt==min(dt),1);
[xce,yce] = ind2sub(size(imth),idxI(idxd));
[cr,nr] = cell_tip_trace_profile2d(imthe,xce,yce,d,1);
[cl,nl] = cell_tip_trace_profile2d(imthe,xce,yce,d,0);

imthe = imreconstruct(imthe,imth);

end