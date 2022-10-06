function matrixTree = matriciseTree(paths)

isEnd = false;
slashes = count(paths,'/');
stringTree = string(paths);

for i=1:length(stringTree)
	for k=1:(12-slashes(i))
		stringTree(i) = stringTree(i) + '0/';
	end
end

matrixTree = split(stringTree,'/');
matrixTree = str2double(matrixTree(:,2:12));
matrixTree = uint32(matrixTree);


