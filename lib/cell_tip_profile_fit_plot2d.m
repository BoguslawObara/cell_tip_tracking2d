function cell_tip_profile_fit_plot2d(x,y,yfit,a1,a2,a3,a4)
reset(gca);
plot(x,y,'r*'); hold on; 
plot(x,yfit,'b-');
xi = zeros(length(x),1);
yi = (min(y) : (max(y) - min(y))/length(xi) : max(y)-(max(y) - min(y))/length(xi))';
plot(xi,yi,'g-.');

%% print parameters
param(1) = {[num2str(a1,'%6.2f') ', ' num2str(a2,'%6.2f') ', ' ...
             num2str(a3,'%6.2f') ', ' num2str(a4,'%6.2f')]};
param(2) = {'[a1,    a2,    a3,    a4]'};
param(3) = {'a1 - amplitude'};
param(4) = {'a2 - peak position'};
param(5) = {'a3 - spread'};
param(6) = {'a4 - background'};
xl = get(gca,'xlim'); yl = get(gca,'ylim');
text(xl(2)-abs(0.6*xl(1)),yl(2)-abs(0.2*yl(2)),param,'FontSize',10);

end