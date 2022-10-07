%EXAMPLE PLOT - 2 brain regions in different colours
atlasFolder = '.\ccf2017';
atlasResolution = 100; %available resolutions are 10,25,50 and 100 microns


st = readtable(fullfile(atlasFolder,'structure_tree_safe_2017.csv'));
ann = loadAlignedAtlas(atlasFolder,25);

figure
[pBrain,pAON] = plotRegionByID(ann,st,159,'RegionColor', 'm');
hold on
[~,pPIR] = plotRegionByID(ann, st, 961, 'RegionColor', 'y', 'plotBrain', 0);
[~,pENT] = plotRegionByID(ann, st, 909, 'RegionColor', 'b', 'plotBrain', 0);
[~,pCA1] = plotRegionByID(ann, st, 382, 'RegionColor', 'r', 'plotBrain', 0);
[~,pCA2] = plotRegionByID(ann, st, 423, 'RegionColor', 'g', 'plotBrain', 0);
hold off

%Add two light sources and adjust the lighting
camlight(40,40)
camlight(-20,-10)
lighting gouraud



%If you want to change patch properties e.g.
% pRegion.FaceColor = [1 0 0]; %Colour of faces
% pRegion.FaceAlpha = 0.5;		%Transparency of face
% pRegion.EdgeColor = 'none';	%Colour of edges

legend([pAON, pPIR, pENT, pCA1, pCA2], ...
	'AON',...
	'Piriform area',...
	'Entorhinal',...
	'CA1',...
	'CA2', ...
	'Location', 'northwest');

view(45,30)
axis equal                             % set the axes aspect ratio
axis off
colormap(gray(100))
box on

%Change axes and background colours
axisColor = ones(3,1)*0.5;
set(gca, 'XColor', axisColor);
set(gca, 'YColor', axisColor);
set(gca, 'ZColor', axisColor);
set(gca, 'Color', 'w');
set(gcf, 'Color', 'w');

fig = gcf;
figName = '3D plot.png';
saveas(fig,figName);



%% MAKE GIF

gifName = 'animation.gif';
fps = 30;					%Gif frames per second
delayTime = 1/fps;


% Extract figure as a frame and tranform it to image
f = getframe(fig);
im = frame2im(f);
[imInd,cMap] = rgb2ind(im,256);


% Write image as first frame of the gif
imwrite(imInd,cMap,gifName,'gif'	, ...
	'LoopCount', inf				, ...
	'DelayTime', delayTime			);

for i=1:0.5:360
	view(i,30)
	drawnow
	
	f = getframe(fig);
	im = frame2im(f);
	
	[imInd,cMap] = rgb2ind(im,256);
	
	imwrite(imInd,cMap,gifName,'gif', ...
		'WriteMode', 'append'		, ...
		'DelayTime', delayTime		);
end








