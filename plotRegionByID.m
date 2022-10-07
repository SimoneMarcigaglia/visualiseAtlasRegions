function [pBrain, pRegion, fRegion, vRegion] = plotRegionByID(av, st, targetId, optionalArgs)
%% PLOTREGIONBYID Creates 3-dimensional surface based on annotated volume 
% of Allen Atlas. 
% Usage:
%	plotRegionByID(av, st, targetId, regionColour, plotBrain)
%	[pBrain, pRegion] = plotRegionByID(av, st, targetId, regionColour, plotBrain)
%	[pBrain, pRegion, fRagion, vRegion] = plotRegionByID(av, st, targetId, regionColour, plotBrain)
% 
% INPUTS:
% av --> annotated volume [Allen Atlas]
% st --> label list [Allen Atlas]
% targetID --> ID of the brain region to be plotted
% regionColor --> Colour of the brain region to be plotted (RGB triplet or
%				matlab convention ('r' - default)
% plotBrain --> logical value - with 0 brain is NOT plotted, 1 brain is
%				plotted (1 - default)
% brainColor --> Colour of the brain volume ('k' - default)
% facesBrain --> if the brain surface faces have already been calculated
%				from the atlas, they can be fed directly to the function to save
%				computational time
% verticesBrain --> same as facesBrain
% 
% OUTPUTS:
% pBrain --> handle to the patch of the brain (if plotBrain==1)
% pRegion --> handle to the patch of the brain region
% fRegion --> calculated faces of the region
% vRegion --> calculated vertices of the region
% 
% See also isosurface, patch, view, camlight, lighting

%% CHECK INPUT VARIABLES
arguments
	av uint16
	st
	targetId
	optionalArgs.brainColor = 'k'
	optionalArgs.regionColor = 'r'
	optionalArgs.plotBrain logical = 'true'
	optionalArgs.facesBrain
	optionalArgs.verticesBrain	
end


%% CREATE BRAIN SURFACE AND PLOT
if (optionalArgs.plotBrain)
	if (~isfield(optionalArgs, 'facesBrain') || ~isfield(optionalArgs, 'verticesBrain'))
		[fBrain,vBrain] = isosurface(av,1,'verbose');
	else
		fBrain = optionalArgs.facesBrain;
		vBrain = optionalArgs.verticesBrain;
	end
	
	pBrain = patch('Faces', fBrain, 'Vertices', vBrain);       % draw the outside of the volume
	pBrain.FaceColor = optionalArgs.brainColor;
	pBrain.FaceAlpha = 0.1;
	pBrain.EdgeColor = 'none';
	
else
	pBrain = [];	
end


%% REARRANGE ID TREE

tree = matriciseTree([st.structure_id_path]);

if ~hasChildren(targetId,tree)
	indices = targetId;
else
	%Remove rows that do not have the index from tree 
	indices = [];
	mask = logical(sum(tree==targetId,2));
	
	filteredTree = tree(mask,:);
	for row=1:size(filteredTree,1)
		for col=1:size(filteredTree,2)
			if filteredTree(row,col)==0
				indexToCheck = filteredTree(row,col-1);
				if ~ismember(indexToCheck,indices)
					indices = [indices; indexToCheck];
					break
				end
			end
		end
	end
	
end

regvol = av.*0;
regvol = logical(regvol);

for i=1:length(indices)
	regvol = regvol + (av==indices(i));
end


%% CREATE SURFACE OF TARGET REGION AND PLOT
[fRegion,vRegion] = isosurface(double(regvol),0.5,'noshare','verbose');

pRegion = patch('Faces', fRegion, 'Vertices', vRegion);       % draw the outside of the volume
pRegion.FaceColor = optionalArgs.regionColor;
pRegion.FaceAlpha = 0.5;
pRegion.EdgeColor = 'none';


