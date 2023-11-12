#=
Function che costruisce la griglia fitta Grid e la ritorna insieme alle matrici multidimensionali X, Y, Z che la compongono.
=#
function BoundingBox(Cloud,hmax,lx,ly,lz)
	#Recupero delle coordinate massime e minime
	maxCoor, minCoor = MinMaxCoordinates(Cloud);
	#Costruzione dei tre vettori x, y, z 
	x = collect(LinRange(minCoor[1]-hmax,maxCoor[1]+hmax,Int(lx)));
	y = collect(LinRange(minCoor[2]-hmax,maxCoor[2]+hmax,Int(ly)));
	z = collect(LinRange(minCoor[3]-hmax,maxCoor[3]+hmax,Int(lz)));
	#Costruzione delle matrici multidimensionali
	X = ones(size(y,1),size(x,1),size(z,1)).*x'; #x viene copiato lungo ogni riga di X
	Y = ones(size(y,1),size(x,1),size(z,1)).*y; #y viene copiato lungo ogni colonna di Y
	Z = ones(size(y,1),size(x,1),size(z,1)); #z viene copiato lungo ogni matrice di Z
	for i = 1:size(Z,3)
		Z[:,:,i] *= z[i];
	end
	Grid = [X[:] Y[:] Z[:]]; #Grid composta dalle matrici X, Y, Z
	return Grid, X, Y, Z
end