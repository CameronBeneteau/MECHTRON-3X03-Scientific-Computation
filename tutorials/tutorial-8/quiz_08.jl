# Solve Equation Using Secant Method

f(x) = @. -x^4 + 3 * x^2 - x + 2

function secant_method(f, x0, x1, max_iter, tol)

    iter = 0
    x_old = x0
    x_new = x1
    x_hist = [x_old; x_new]

    while iter <= max_iter && abs(x_new - x_old) >= tol
        x_tmp = x_new
        x_new = x_new - f(x_new) * (x_new - x_old) / (f(x_new) - f(x_old))
        x_old = x_tmp
        iter += 1
        push!(x_hist, x_new)
    end

    return x_hist
end

sec_x_hist = secant_method(f, -2.5, -2.2, 100, 1e-6)

# Find Theoretical Limit

m1 = 3.5
M2 = 69

c = 0.5 * M2 / m1

# Solve Equation Using Newton's Method

function newtonConv(f, df, x0, max_iter, toll)
    iter = 1
    x_old = x0
    x_new = x_old - f(x_old) / df(x_old)
    x_hist = [x0; x_new]
    while iter <= max_iter && abs(x_new - x_old) >= toll
        x_old = x_new
        x_new = x_old - f(x_old) / df(x_old)
        iter += 1
        push!(x_hist, x_new)
    end
    return x_hist
end

df(x) = @. -4 * x^3 + 6 * x - 1

new_x_hist = newtonConv(f, df, -2.5, 100, 1e-6)

# Plot Numerical Errors

using Plots

x_star = -2

sec_n = 1:length(sec_x_hist)
sec_err = abs.(sec_x_hist .- x_star)
sec_err_lim = c * (sec_err[1:end-1]) .^ ((sqrt(5) + 1) / 2)

new_n = 1:length(new_x_hist)
new_err = abs.(new_x_hist .- x_star)
new_err_lim = c * (new_err[1:end-1]) .^ 2

Plots.plot(sec_n, sec_err, yscale=:log10, xlabel="Iteration", ylabel="Absolute Error", label="Secant Error")
Plots.plot!(sec_n[2:end], sec_err_lim, linestyle=:dash, label="Secant Limit")
Plots.plot!(new_n, new_err, yscale=:log10, label="Newton Error")
Plots.plot!(new_n[2:end], new_err_lim, linestyle=:dash, label="Newton Limit")