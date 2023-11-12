#=
Function che estende il Cloud in input aggiungendogli gli insiemi dei punti interni ed esterni.
=#
function AddPoints(Cloud,minDists,Normals,alpha)
	dim = size(Cloud);
	#METODO 1: Utilizzo delle distanze minime e di alpha per scalare le Normali
	delta = (alpha*minDists);
	delta = repeat(delta,1,dim[2]);
	external_points = Cloud + Normals[1:dim[1],:].*delta; #Insieme dei punti esterni
	internal_points = Cloud - Normals[1:dim[1],:].*delta; #Insieme dei punti interni
	#=
	METODO 2: Utilizzo della distanza massima tra le minime e di alpha per scalare le Normali
	hmax = maximum(minDists);
	delta = hmax*alpha;
	external_points = Cloud + Normals*delta;
	internal_points = Cloud - Normals*delta;
	=#
	newCloud = Cloud;
	newCloud = [newCloud; external_points; internal_points];
	return newCloud
end