function [r,k,cc] = curvature_estimation2d(c,dc)

%% curvature
r = ones(size(c,1),1)*inf;
cc = ones(size(c,1),2)*inf; 
k = zeros(size(c,1),1); 

cs = length(c);
for i=dc+1:cs-dc
    cm = i;
    cl = cm - dc;
    cr = cm + dc;
    %if cl<1;  cl = cs - abs(cl); end
    %if cr>cs; cr = cr - cs;      end
    pi_kb = c(cl,:);
    pi_kf = c(cr,:);
    pi_k  = c(cm,:);
    [a1,b1,c1] = points_bisect_line_imp_2d(pi_k,pi_kb);
    [a2,b2,c2] = points_bisect_line_imp_2d(pi_k,pi_kf);
    [ival,center] = lines_imp_int_2d(a1,b1,c1,a2,b2,c2);
    if ival==1
        vector = pi_k-center; 
        radius = norm(vector);
        r(i) = radius;
        k(i) = 1/radius;       
        cc(i,:) = center;
    end
end

end