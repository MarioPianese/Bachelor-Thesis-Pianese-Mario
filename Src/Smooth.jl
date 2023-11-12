#=
Function utile per effettuare smoothing sulla Superficie data in input con la funzione denoise() definita nel modulo 
=#
function SmoothingSurface(Surface,Surf_Name)
	if Surf_Name == "bunny2.obj"
		smoothed = denoise(Surface, dims=2);
		smoothed = denoise(smoothed[1], dims=1);
	elseif Surf_Name == "sfera.obj" || Surf_Name == "sfera3.obj" || Surf_Name == "sfera4.obj"
		smoothed = denoise(Surface, dims=3);
		smoothed = denoise(smoothed[1], dims=2);
		smoothed = denoise(smoothed[1], dims=1);
	elseif Surf_Name == "sfera2.obj" 
		smoothed = denoise(Surface, dims=2);
		smoothed = denoise(smoothed[1], dims=3);
		smoothed = denoise(smoothed[1], dims=1);
		smoothed = denoise(smoothed[1], dims=2);
	elseif Surf_Name == "sfera5.obj"
		smoothed = denoise(Surface, dims=2);
		smoothed = denoise(smoothed[1], dims=1);
		smoothed = denoise(smoothed[1], dims=3);
	end
	return smoothed[1]
end