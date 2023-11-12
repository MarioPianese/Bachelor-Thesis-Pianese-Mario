include("Utility.jl")

#println("Inserire nome del file da leggere (compresa l'estensione):")
#filename = readline()
filename = "sfera.obj";
#filename = "sfera2.obj";
#filename = "sfera3.obj"; #SFERA A STRISCE
#filename = "sfera4.obj";
#filename = "sfera5.obj";
#filename = "bunny2.obj";

#SET DELLE VARIABILI GLOBALI
M, k, beta, tol, alpha = SetGlobal(filename);

#LETTURA DEL FILE .OBJ
#filename = "FileOBJ/" * filename;
Cloud, Normals, Textures, Faces = ReadObj("FileOBJ/" * filename);

#CREAZIONE DEL CLOUD
distCloud, minDists = Cloud_Dist(Cloud);
hmax = maximum(minDists);
Cloud4, Cloud3, Cloud2, Ind_Elim1, Ind_Elim3 = CreateCloud(Cloud,Normals,tol,alpha);

#CREAZIONE VETTORE B
S2 = size(Cloud2,1);
b = [zeros(S2,1);ones(S2,1);-ones(S2,1)];
b = b[setdiff(1:end,Ind_Elim3),:];

#CREAZIONE DELLA GRIGLIA CSI
lv = CalcLV(Cloud4,M,hmax,beta);
csi, pos, XX, YY, ZZ = Surrounding_Volume(Cloud2,hmax,lv,beta);

#CALCOLO DELL'INTERPOLANTE
sigma = hmax*k;
Pf = CalcInterpolant(Cloud4,csi,b,sigma);

#VISUALIZZAZIONE DEI RISULTATI
Surface = 2*ones(Int(lv^3),1);
Surface[pos] = Pf;
Surface = reshape(Surface,Int(lv),Int(lv),Int(lv));

Smooth_Surf = SmoothingSurface(Surface,filename);
meanS = mean(Surface);
iso = isosurface(
        x=XX[:],
        y=YY[:],
        z=ZZ[:],
        value=Smooth_Surf[:],
        isomin=0,
        isomax=meanS,
		opacity=1,
		surface=attr(fill=1,count=1),
        caps=attr(x_fill=true, y_fill=true, z_fill=true, x_show=false, y_show=false),
		slices=attr(x_fill=true, y_fill=true, z_fill=true, x_show=false, y_show=false)
    );
scat = scatter(
           x=Cloud2[:,1],
           y=Cloud2[:,2],
           z=Cloud2[:,3],
           mode="markers",
		   marker=attr(
               size=5,
               color=Cloud2[:,3],
               colorscale="Viridis",
               opacity=1
           ),
           type="scatter3d",
		   surfacecolor=5
       );
plot([iso,scat])