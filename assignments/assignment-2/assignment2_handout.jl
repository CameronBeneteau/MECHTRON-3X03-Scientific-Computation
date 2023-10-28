using LinearAlgebra

# Test Cases
x1 = [1, 2, 3]
y1 = [1, 2, 3]

x2 = [1, 2, 4]
y2 = [1, 3, 3]

x3 = [0, 1, 2, 3, 4, 5, 6, 7]
y3 = [15, 3, 89, 5, 78, 4, 1, 0]

x4 = [0, 0.9, π / 2]
y4 = [1, 0.622, 0]

""" 
Computes the coefficients of Newton's interpolating polynomial. 
    Inputs 
        x: vector with distinct elements x[i] 
        y: vector of the same size as x 
    Output 
        c: vector with the coefficients of the polynomial
"""
function newton_int(x, y)

    n = length(x)
    m = zeros(n, n)

    m[:, 1] .= y # Fill first column with y values

    # For each col, fill in values from i to n
    for i in 2:n # Col
        for j in i:n # Row
            m[j, i] = (m[j, i-1] - m[j-1, i-1]) / (x[j] - x[j-i+1])
        end
    end

    return diag(m)

end

# println("Newton Test 1    : ", newton_int(x1, y1))
# println("Newton Test 1 New: ", newton_int_new(x1, y1))
# println("Newton Test 2    : ", newton_int(x2, y2))
# println("Newton Test 2 New: ", newton_int_new(x2, y2))
# println("Newton Test 3    : ", newton_int(x3, y3))
# println("Newton Test 4 New: ", newton_int_new(x3, y3))
# println("Newton Test 4    : ", newton_int(x4, y4))
# println("Newton Test 4 New: ", newton_int_new(x4, y4))

"""
Evaluates a polynomial with Newton coefficients c 
defined over nodes x using Horner's rule on the points in X.
Inputs 
    c: vector with n coefficients 
    x: vector of n distinct points used to compute c in newton_int 
    X: vector of m points 
Output 
    p: vector of m points
"""
function horner(c, x, X)

    n, m = length(x), length(X)
    p = zeros(m)

    for i in 1:m

        p[i] = c[n]

        for j in n-1:-1:1
            p[i] = c[j] + (X[i] - x[j]) * p[i]
        end
    end

    return p
end

# c1 = newton_int(x1, y1)

# X1 = [1, 2, 3]

# println("Horner Test 1: ", horner(c1, x1, X1))
# println()
# p_true = fit(x1, y1)
# vals_true = p_true.(X1)
# println(vals_true)

"""
Computes the number of equally spaced points to use for 
interpolating cos(ω*x) on interval [a, b] for an absolute
error tolerance of tol.

Inputs
    a: lower boundary of the interpolation interval
    b: upper boundary of the interpolation interval
    ω: frequency of cos(ω*x)
    tol: maximum absolute error 
Output
    n: number of equally spaced points to use 	 
"""
function subdivide(a, b, ω, tol)

    # Analytical soltuion
    # n = 1

    # while n < 1000000

    #     h = (b - a) / n

    #     curr = ω^(n + 1) * h^(n + 1) / (4 * (n + 1))

    #     if curr < tol
    #         println("Subdivide Nodes: ", n)
    #         n = 10
    #         return n
    #     end
    #     n += 1
    # end

    # return 0


    # Trial and srror solution
    n = 2

    while true

        x_vals = range(a, stop=b, length=n)
        y_vals = cos.(ω .* x_vals)
        c = newton_int(x_vals, y_vals) # Are we allowed to use fit?

        x_test_vals = range(a, stop=b, length=1000) # Higher precision?
        abs_error = abs.(cos.(ω .* x_test_vals) - horner(c, x_vals, x_test_vals))

        if maximum(abs_error) < tol
            println("Subdivide Nodes: ", n)
            return n
        end

        n += 1
    end
end

a = 0
b = 3 * pi
ω = 1
tol = 1e-6

# println("Subdivide: ", subdivide(a, b, ω, tol))

"""
Computes Chebyshev nodes in the interval [a, b] for the function
cos(ω*x) for a maximum absolute error of tol.

Inputs
    a: lower boundary of the interpolation interval
    b: upper boundary of the interpolation interval
    ω: frequency of cos(ω*x)
    tol: maximum absolute error
Output
    x: distinct Chebyshev nodes	 
"""
function chebyshev_nodes(a, b, ω, tol)

    for i in 2:1000 # Can we just use subdivide? Too much computation power?
        x_vals = zeros(i)

        for j in 1:i
            x_vals[j] = 0.5 * (a + b) + 0.5 * (b - a) * cos(π * (2 * j + 1) / (2 * i + 2))
        end

        y_vals = cos.(ω .* x_vals)
        c = newton_int(x_vals, y_vals) # Are we allowed to use fit?

        x_test_vals = range(a, stop=b, length=1000) # Higher precision?
        abs_error = abs.(cos.(ω .* x_test_vals) - horner(c, x_vals, x_test_vals))

        if maximum(abs_error) < tol
            println("Chebychev Nodes: ", i)
            return x_vals
        end
    end

    # while n < 1000000

    #     h = (b - a) / n

    #     curr = ω^(n + 1) / 2^n / factorial(n + 1)

    #     if curr < tol
    #         break
    #     end
    #     n += 1
    # end

    # n = 17

    # x = zeros(n)

    # for i in 1:n
    #     x[i] = 0.5 * (a + b) + 0.5 * (b - a) * cos(π * (2 * i + 1) / (2 * n + 2))
    # end

    # println("Chebyshev Nodes: ", n)
    # return x
end

# println("Chebyshev: ", chebyshev_nodes(a, b, ω, tol))