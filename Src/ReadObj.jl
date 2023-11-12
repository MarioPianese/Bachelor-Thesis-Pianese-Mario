#=
Fuction che estrae i vertici (v), le normali (vn), le texture (vt) e le faces (f) da un file .obj e li ritorna in 4 matrici.
=#
function ReadObj(filename::String)
	#filename = "FileOBJ/" * filename;
	fid = open(filename) #Apro il file 
	vertices = []; normals = []; textures = []; faces = [];
	for line in eachline(fid) #Leggo il file riga per riga
		tokens = split(strip(line)) #Splitto la linea letta in tokens
		comment = findfirst(t->t[1] == '#', tokens)
		if comment != nothing #Se la linea letta è un commento, passo alla prossima linea
		  tokens = tokens[1:comment-1]
		end
		isempty(tokens) && continue
		if tokens[1] == "v" #La riga fa riferimento ad un vertice
			vertex = [];
			for i = 2:size(tokens,1)
				v = parse(Float64,tokens[i])
				push!(vertex,v)
			end
			push!(vertices,vertex)
		elseif tokens[1] == "vn" #La riga fa riferimento ad una normale
			normal = [];
			for i = 2:size(tokens,1)
				vn = parse(Float64,tokens[i])
				push!(normal,vn)
			end
			push!(normals,normal)
		elseif tokens[1] == "vt" #La riga fa riferimento ad una texture
			texture = [];
			for i = 2:size(tokens,1)
				vt = parse(Float64,tokens[i])
				push!(texture,vt)
			end
			push!(textures,texture)
		elseif tokens[1] == "f" #La riga fa riferimento ad una face
			face = []; temp = [];
			for i = 2:size(tokens,1)
				push!(temp,(split(tokens[i],'/',keepempty=false))) #Splitto ulteriormente il token i-esimo
			end
			for i = 1:size(temp,1), j = 1:size(temp[i],1)
				f = parse(Float64,temp[i][j])
				push!(face,f)
			end
			push!(faces,face)
		end
	end
	close(fid) #Chiusura del file
	#Conversione dei vector di vector in matrici
	if !isempty(vertices)
		vertices = mapreduce(permutedims, vcat, vertices);
	end
	if !isempty(normals)
		normals = mapreduce(permutedims, vcat, normals);
	end
	if !isempty(textures)	
		textures = mapreduce(permutedims, vcat, textures);
	end
	if !isempty(faces)	
		faces = mapreduce(permutedims, vcat, faces);
	end
	return vertices, normals, textures, faces
end