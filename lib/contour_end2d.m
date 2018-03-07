function c = contour_end2d(imth,imtht,x,y)

%% reconstruction
imr = zeros(size(imth))==1;
imr(x,y) = 1;
imr = imreconstruct(imr,imth);

%% contour
[xb,yb] = find(imr,1);
c1 = bwtraceboundary(imr,[xb,yb],'N');
[xb,yb] = find(imtht,1);
c2 = bwtraceboundary(imtht,[xb,yb],'N');
idx1 = ismember(c1(:,1:2),c2(:,1:2),'rows');
d = diff([idx1(length(idx1));idx1]);
idx2 = find(d);
ds = d(idx2);

%% contour ends
c = [];
if length(ds)~=2
    disp('ERROR: more than 2 points!'); 
    c = c1;
    %return;
else
    if ds(1)>ds(2)
        c = c1(idx2(1):idx2(2),:);
    else
        c = c1(idx2(2):size(c1,1),:);
        c = [c; c1(1:idx2(1),:)];
    end
end

end