function [center,radius,c,cm,cr,cl,center2] = cell_tip_search2d(imth,imtht,x,y,dc,on)

%% contour ends
c = contour_end2d(imth,imtht,x,y);

%% Curvature
[r,~,cc] = curvature_estimation2d(c,dc);

%%
if on==1
    
    imd = bwdist(~imtht);
    rmax = max(imd(:));
    idx1 = r<(rmax+0.2*rmax);
    p = find(idx1==1);
    p = sum(p)/length(p);
    
    % only centers inside object are considered
    [x,y] = find(imtht);
    idx2 = ismember(round(cc),[x,y],'rows');
    ci = find(idx2==1);
    
    % tip main centre
    p1 = find(idx2,1,'first');
    p2 = find(idx2,1,'last');
    center2 = (c(p1,:)+c(p2,:))./2;
    
    % min dist
    d = abs(ci-p);
    di = find(d==min(d),1,'first');
    idx = ci(di);
    radius = r(idx);
    center = cc(idx,:);
    
    %
    cs = length(c);
    cm = idx;
    cl = cm - dc;
    cr = cm + dc;
    if cl<1;  cl = cs - abs(cl); end
    if cr>cs; cr = cr - cs;      end

else
    
    % only centers inside object are considered
    [x,y] = find(imtht);
    idxIn = ismember(round(cc),[x,y],'rows');
    idx = find(r==min(r(idxIn)),1);
    radius = r(idx);
    center = cc(idx,:);

    %
    cs = length(c);
    cm = idx;
    cl = cm - dc;
    cr = cm + dc;
    if cl<1;  cl = cs - abs(cl); end
    if cr>cs; cr = cr - cs;      end

end

end