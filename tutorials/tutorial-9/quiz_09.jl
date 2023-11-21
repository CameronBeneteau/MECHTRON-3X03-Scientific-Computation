# Calculate the SVD of A and A inverse

using LinearAlgebra

A = [1 1 0; 0 1 1; -1 1 -1]

U, Σ, Vt = svd(A)
display(U * diagm(Σ) * Vt')

invU, invΣ, invVt = svd(inv(A))
display(invU * diagm(invΣ) * invVt')

"""
The singular values of Σ inverse are the reciprocals of the singular values of Σ

The formal proof for this is as follows
The inverse of A can be written as A^-1 = (U * Σ * V')^-1
Expand to A^-1 = V'^-1 * Σ^-1 * U^-1  
U and Vt are orthogonal matricies so their inverses are equal to their transpose (i.e. U^-1 = U')
We can re-write the equation as A^-1 = V * Σ^-1 * U'
The singular values of A are the diagonal elements of Σ
The singular values of A inverse are the diagonal elements of Σ inverse
The diagonal (singular) elements of Σ inverse are the reciprocals of the diagonal (singular) elements of Σ
"""

# Calculate the determinant of A using Julia's built-in function and the determinant formula

det_a_func = det(A)
println("|det(A)| using built-in function: ", abs(det_a_func))

det_a_form = A[1, 1] * (A[2, 2] * A[3, 3] - A[2, 3] * A[3, 2]) - A[1, 2] * (A[2, 1] * A[3, 3] - A[3, 1] * A[2, 3]) + A[1, 3] * (A[2, 1] * A[3, 2] - A[2, 2] * A[3, 1])
println("|det(A)| using determinate formula: ", abs(det_a_form))

"""
The determinant of A can be calculated by finding the product of the values in the Σ vector

The formal proof for this is as follows
det(A) = det(U) * det(Σ) * det(Vt)
U and Vt are orthogonal matricies so their determinants are ±1This gives det(A) = ±1 * det(Σ) * ±1
Smiplify to det(A) = det(Σ)
Since Σ is a diagonal matrix, by definition, its determinant is the product of the diagonal values
Now we can write det(A) = ∏ Σi where Σi are the diagonal (or singular) elements of Σ
"""

det_a_svd = prod(Σ);
println("|det(A)| using product of singular values: ", abs(det_a_svd))

println("Singular values of A: ", Σ)
println("Singular values of A^-1: ", invΣ)

"""
The value of det_a_func and det_a_form are both 3
The calculation of det_a_svd = prod(Σ) must be correct since it is 3.000000000000001
"""

"""
Lets say r3 = sqrt(3)
The singular values of A are [r3 r3 1]
The singular values of A inverse are [1 1/r3 1/r3]
They are related by reversing the order and taking the inverse
The reciprocal of the reversed singular values of A should equal the singular values for A inverse
If the above statement is true, the difference between these values should be 0
"""

revΣ = reverse(Σ);
revΣInv = 1 ./ revΣ

println("Reversed singular values: ", revΣ)
println("Inverse of reversed values: ", revΣInv)

println("Difference: ", abs.(revΣInv - invΣ))

# As shown, the difference between the reversed singular values of A and singular values for A inverse is 0