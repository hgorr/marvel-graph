% Plot 3D graph and rotate and create .gif

% Create graph
g = graph(charData.Character,charData.Movie);
figure('units','normalized','outerposition',[0 0 1 1])
colormap hsv
p = plot(g,'Layout','force3','UseGravity','on',...
    'MarkerSize',degree(g));
p.NodeCData = degree(g);

axis off
clear frame
% Rotate and save as .gif
outfile = 'marvel_graph_mainchar.gif';
for theta = -180:5:90
    view(theta,0)
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    
    % On the first loop, create the file. In subsequent loops, append.
    if theta==-180
        imwrite(imind,cm,outfile,'gif','DelayTime',.1,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',.1,'writemode','append');
    end
end
