using LinearAlgebra
using Random
using Plots

Random.seed!(412)

matricies = [Symmetric(randn((3, 3))) for _ in 0:49]

eigenValues = []

for matrix in matricies
    for eigenValue in eigen!(matrix).values
        push!(eigenValues, eigenValue)
    end
end

histogram(eigenValues, label="Eigenvalues")