#=
Function che costruisce e ritorna la griglia csi di valutazione,
il vettore pos relativo agli indici dei punti di Grid aggiunti a csi,
XX, YY, ZZ matrici multidimensionali che compongono Grid.
=#
function Surrounding_Volume(Cloud,hmax,lv,beta)
	lx = ly = lz = lv;
	Grid, XX, YY, ZZ = BoundingBox(Cloud,hmax,lx,ly,lz);
	h = hmax*beta;
	csi = []; pos = [];
	ss = size(Grid,1);
	for i = 1:ss
		temp = reshape(Grid[i,:],1,:);
		if HausDist(temp,Cloud) < h #Se il punto di Grid è nell'intorno di un punto di Cloud, lo si inserisce in csi
			push!(csi,Grid[i,:]);
			push!(pos,i);
		end
	end
	if !isempty(csi)
		csi = mapreduce(permutedims, vcat, csi);
	end
return csi, pos, XX, YY, ZZ
end

function Surrounding_Volume_PAR(Cloud,hmax,lv,beta)
	lx = ly = lz = lv;
	Grid, XX, YY, ZZ = BoundingBox(Cloud,hmax,lx,ly,lz);
	h = hmax*beta;
	csi = []; pos = [];
	ss = size(Grid,1);
	u = Threads.SpinLock(); #Si utilizza un Lock al fine di evitare RC
	Threads.@threads :dynamic for i = 1:ss #Ogni riga di Grid è associata ad un solo Thread
        temp = reshape(Grid[i,:],1,:);
        if HausDist(temp,Cloud) < h
            Threads.lock(u)
            push!(csi,Grid[i,:]); # Operazioni soggette a RC
            push!(pos,i); # Operazioni soggette a RC
			Threads.unlock(u)
        end
    end
	if !isempty(csi)
		csi = mapreduce(permutedims, vcat, csi); #Conversiona da Vector di Vector a Matrice
	end
return csi, pos, XX, YY, ZZ
end