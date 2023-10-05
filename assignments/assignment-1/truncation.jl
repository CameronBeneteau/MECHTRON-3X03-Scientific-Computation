# Question 7c

using Plots

x = π / 4
h = 10 .^ (-16:0.1:0.1)
M = 5.724

f(x) = sin.(x) .* exp.(cos.(x))
fp_accurate = exp.(cos.(x)) * cos.(x) - exp.(cos.(x)) * sin.(x) .^ 2
fp = (f(x .+ h) .- f(x .- h)) ./ (2 .* h)

error = abs.(fp_accurate .- fp)
truncation(h) = M .* h .^ 2 ./ 6
roundoff(h) = eps() ./ h
err_bound(h) = truncation(h) + roundoff(h)
error_bound = err_bound(h);

t = scatter(h, error, color=:red, label="Error", xaxis=:log, yaxis=:log, markersize=2.5, legend=:bottomright)
plot!(h, error_bound, color=:blue, label="Error Bound", xaxis=:log, yaxis=:log)
plot!(h, truncation(h), color=:green, label="Trunc. Error Bound", xaxis=:log, yaxis=:log)
plot!(h, roundoff(h), color=:purple, label="Roundoff Error Bound", xaxis=:log, yaxis=:log)
xaxis!("Step Size (h)")
yaxis!("Abs. Value of Error")
title!("Empirical Error vs. Theoretical Bound for \$\\sin(x) \\cdot e^{\\cos(x)}\$")
vline!([cbrt(3 * eps() / M)], label="Theoretical Err. Minimum")
savefig(t, "./assignments/assignment-1/truncation.png")