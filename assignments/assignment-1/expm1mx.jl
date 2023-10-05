# Queston 8b

using Plots

function expm1mx(x)

    approx = 0.5
    term = approx

    # 18 terms, anything more is negligible 
    for n in 3:20
        term *= x / n
        approx += term
    end

    return approx
end

# Define our function and domain
f(x) = (exp(x) - 1 - x) / x^2
N = -16:1:0
x = 10.0 .^ N

# Compute accurate values in higher precision
accurate = f.(BigFloat.(x))

# Relative error in f(x)
error_f = abs.((f.(x) - accurate) ./ accurate)

# Relative error in expm1mx(x)
error_app = abs.((expm1mx.(x) - accurate) ./ accurate)

# Plot and save the output
p = plot(x, error_f, xaxis=:log, yaxis=:log, label="Rel. Error in f(x)", color=:blue)
plot!(x, error_app, xaxis=:log, yaxis=:log, label="Rel. Error in expm1mx(x)", color=:red)
xaxis!("x")
yaxis!("Relative Error")
savefig(p, "./assignments/assignment-1/relative_error.png")
