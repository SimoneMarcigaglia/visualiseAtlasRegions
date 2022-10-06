function av_perm = loadAlignedAtlas(folderPath,atlasResolution)
%% LOADALIGNEDATLAS Loads ccf2017 Allen atlas and tranforms it for plotting purposes
%  Usage:
% av = loadAlignedAtlas(folderPath,atlasResolution);
% 
% Specify the folder in which the atlas files are stored and the resolution
% of the atlas you would like to use (10, 25, 50 or 100 um).
% 
% Requires <a href="matlab:web('https://nl.mathworks.com/matlabcentral/fileexchange/34653-nrrd-format-file-reader')">NRRD Format File Reader</a>.


filename = fullfile(folderPath, sprintf('annotation_%u.nrrd',atlasResolution));

av = nrrdread(filename);

av_perm = permute(av, [2 3 1]);

[depth, width, height] = size(av_perm);

% flip up/down
for i=1:width
	av_perm(:,i,:) = reshape(fliplr(squeeze(av_perm(:,i,:))),depth,1,height);
end

