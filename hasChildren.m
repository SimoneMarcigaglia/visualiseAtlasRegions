function hasChildren = hasChildren(id,tree)

repetitions = sum(sum(tree==id));

if repetitions==1
	hasChildren = false;
elseif repetitions > 1
	hasChildren = true;
else
	error("Invalid index!")
	return
end