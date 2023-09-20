using LinearAlgebra

# Q1: Create function
elementWiseLog2Detrminant(x) = det(log2.(x))

# Q2: Test with matrix
X = [2 3 4; 0.3 1.6 1; 5 2.3 1.1]
println("Output of test matrix X: ", elementWiseLog2Detrminant(X))

# Q3: Comparison between Float32 and Float64, and machine eplison
threeTwoOut = elementWiseLog2Detrminant(Float32.(X))
sixFourOut = elementWiseLog2Detrminant(Float64.(X))

println("Output when X is type Float32: ", threeTwoOut)
println("Output when X is type Float64: ", sixFourOut)

println("Absolute difference in types: ", abs(sixFourOut - threeTwoOut))
println("Machine epsilon: ", eps())
println("Machine epsilon of Float32: ", eps(threeTwoOut))
println("Machine epsilon of Float64: ", eps(sixFourOut))
