function SetGlobal(filename)
	if filename == "sfera.obj" || filename == "sfera3.obj"
		return 5, 0.1, 0.5, 0.01, 0.33
	elseif filename == "sfera2.obj"
		return 6, 0.1, 0.6, 0.01, 0.33
	elseif filename == "sfera4.obj" || filename == "sfera5.obj"
		return 4, 0.1, 0.6, 0.01, 0.33
	elseif filename  == "bunny2.obj"
		return 4, 0.3, 0.9, 0.01, 0.33
	end
end