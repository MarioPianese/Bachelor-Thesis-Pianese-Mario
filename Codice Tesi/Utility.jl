#PACKAGE/MODULI UTILI
using IterativeSolvers
using LinearAlgebra
using Random
using Statistics
using KissSmoothing
using PlotlyJS

#FUNCTION UTILI
include("SetGlobal.jl")
include("ReadObj.jl")
include("DistanceMatrix.jl")
include("Cloud_Dist.jl")
include("ElimPoints.jl")
include("AddPoints.jl")
include("CreateCloud.jl")
include("MinMaxCoordinates.jl")
include("CalcLV.jl")
include("HausDist.jl")
include("BoundingBox.jl")
include("Surrounding_Volume.jl")
include("RBF_functions.jl")
include("CalcInterpolant.jl")
include("Smooth.jl")

#VARIABILI UTILI
#M = 5; k = 0.1; beta = 0.5; tol = 0.01; alpha = 0.33;

#=
VALORI CONSIGLIATI GAUSS E SFERA
M = 5; k = 0.1; beta = 0.5; tol = 0.01; alpha = 0.33; #sfera1
M = 6; k = 0.1; beta = 0.6; tol = 0.01; alpha = 0.33; #sfera2
M = 4; k = 0.1; beta = 0.6; tol = 0.01; alpha = 0.33; #sfera4 beta = 0.5 pure
M = 4; k = 0.1; beta = 0.6; tol = 0.01; alpha = 0.33; #sfera5 M = 4 e 5, beta = 0.5, 0.6


VALORI CONSIGLIATI GAUSS E CONIGLIO
M = 5; k = 0.3; beta = 1; tol = 0.01; alpha = 0.33;
M = 2; k = 0.3; beta = 0.7; tol = 0.01; alpha = 0.33;
M = 2; k = 0.3; beta = 0.9; tol = 0.01; alpha = 0.33;
M = 4; k = 0.5; beta = 0.9; tol = 0.01; alpha = 0.33;
M = 4; k = 0.3; beta = 0.9; tol = 0.01; alpha = 0.33;
=#


