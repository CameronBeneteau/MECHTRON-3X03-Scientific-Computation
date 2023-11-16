
"""
Compute the integral ∫f(x)dx over [a, b] with the composite trapezoidal
rule using r subintervals.

Inputs:
    
    f: function to integrate
    a: lower bound of the definite integral
    b: upper bound of the definite integral
    r: number of subintervals
"""
function composite_trapezoidal_rule(f, a, b, r)
    h = (b - a) / r
    sum = 0

    for i in 1:r-1
        sum += f(a + i * h)
    end

    res = 0.5 * h * (f(a) + f(b)) + h * sum

    println(res)
    return res
end

"""
Compute the integral ∫f(x)dx over [a, b] with the composite midpoint 
rule using r subintervals.

Inputs:
    
    f: function to integrate
    a: lower bound of the definite integral
    b: upper bound of the definite integral
    r: number of subintervals
"""
function composite_midpoint_rule(f, a, b, r)
    h = (b - a) / r
    res = 0

    for i in 1:r
        l = a + (i - 1) * h
        r = a + i * h
        res += (r - l) * f((l + r) / 2)
    end

    println(res)
    return res
end

"""
Compute the integral ∫f(x)dx over [a, b] with the composite Simpson's 
rule using r subintervals. Note that r must be even because each 
application of Simpson's rule uses a subinterval of length 2*(b-a)/r.
In other words, the midpoints used by the basic Simpson's rule are 
included in the r+1 points on which we evaluate f(x).

Inputs:
    
    f: function to integrate
    a: lower bound of the definite integral
    b: upper bound of the definite integral
    r: even number of subintervals
"""
function composite_simpsons_rule(f, a, b, r)
    h = (b - a) / r
    res = 0

    for i in 1:r
        l = a + (i - 1) * h
        r = a + i * h

        res += 1 / 6 * (r - l) * (f(l) + 4 * f((l + r) / 2) + f(r))
    end

    println(res)
    return res
end

"""
Compute the integral ∫f(x)dx over [a, b] with the adaptive Simpson's 
rule. Return the approximate integral along with the nodes (points) x 
used to compute it.  

Inputs:
    
    f: function to integrate
    a: lower bound of the definite integral
    b: upper bound of the definite integral
    tol: maximum error we can approximately tolerate (i.e., |If - Q| <≈ tol)
    max_depth: maximum number of times this function should be recursively called

Returns:
    approximate_integral: the value of the integral ∫f(x)dx over [a, b]
    x: vector containing the nodes which the algorithm used to compute approximate_integral
"""
function adaptive_simpsons_rule(f, a, b, tol, max_depth)
    return 0, 0
    return approximate_integral, x
end


"""
Use Newton's method to solve the nonlinear system of equations described in Problem 5.
This should work for Euclidean distance measurements in any dimension n.

Inputs:
    x0: initial guess for the position of the receiver in R^n
    P: nxn matrix with known locations of transmitting beacons as columns
    d: vector in R^n where d[i] contains the distance from beacon P[:, i] to x
    tol: Euclidean error tolerance (stop when norm(F(x)) <= tol)
    max_iters: maximum iterations of Newton's method to try

Returns:
    x_trace: Vector{Vector{Float64}} containing each Newton iterate x_k in R^n. 

"""
function newton(x0, P, d, tol, max_iters)
    return 0
    return x_trace
end

"""
Use Newton's method to solve the nonlinear optimization problem described in Problem 7.
This should work for Euclidean distance measurements in any dimension n, and any number 
    of noisy measurements m.

Inputs:
    x0: initial guess for the position of the receiver in R^n
    P: nxm matrix with known locations of transmitting beacons as columns
    d: vector in R^m where d[i] contains the noisy distance from beacon P[:, i] to x
    tol: Euclidean error tolerance (stop when norm(∇f(x)) <= tol)
    max_iters: maximum iterations of Newton's method to try

Returns:
    x_trace: Vector{Vector{Float64}} containing each Newton iterate x_k in R^n. 

"""
function newton_optimizer(x0, P, d, tol, max_iters)
    return 0
    return x_trace
end