function cell_tip_profile_plot2d(im,pr,pl)

imagesc(im); colormap gray; axis equal; axis tight; axis off; hold on;
plot(yce,xce,'g*');
plot(pr(:,2),pr(:,1),'b.');
plot(pl(:,2),pl(:,1),'y.');

end
