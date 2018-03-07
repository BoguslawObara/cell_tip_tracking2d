function cell_tip_segmentation_plot2d(im,center,radius,c,cm,cr,cl,center2)

imagesc(im); colormap gray; axis equal; axis tight; axis off; hold on;

%%
theta = linspace(0,2*pi,1000);
rho = ones(1,1000)*radius;
[xr,yr] = pol2cart(theta,rho);
xr = xr + center(2);
yr = yr + center(1);

%%
plot(center(2),center(1),'r.');
plot(center2(2),center2(1),'k.');
plot(xr,yr,'r-');
plot(c(cl,2),c(cl,1),'g*');
plot(c(cm,2),c(cm,1),'m*');
plot(c(cr,2),c(cr,1),'b*'); 

end
