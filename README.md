# Bachelor-Thesis-Pianese-Mario
This repository contains the source code relating to my Thesis in Computer Science at the University of Naples 'Parthenope'. The title of the thesis is "A Multi-Thread Algorithm for RBF Interpolation in Julia Environment".

The source code is commented, but in Italian.
Different datasets were used to test the software.

**Julia version**: 1.9.3

### Guide to run

To run the software, launch the shell and navigate to the source code folder.
Then start Julia as follows:
```
julia
```
or
```
julia -t [number of threads] #you can also use the 'auto' macro as number of threads
```
At this point, to start running the software, type in the Julia REPL:
```
julia> include("Main.jl") #to run sequentially
```
or
```
julia> include("Parallelized.jl") #to run in parallel
```

**IMPORTANT**: 

You need to add six Julia Packages (IterativeSolvers, LinearAlgebra, Random, Statistics, KissSmoothing, PlotlyJS) to run the software. To add these Packages, digit in Julia REPL `]` to access to the Julia Pkg mode, and then digit:
```
add IterativeSolvers, LinearAlgebra, Random, Statistics, KissSmoothing, PlotlyJS
```
to add the six Packages.

