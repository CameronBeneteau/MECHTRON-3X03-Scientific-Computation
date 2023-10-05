# Question 6b (spacing.jl)

a = 1
b = 10
n = 10000

function x_tilde(a, b, n)
    h = (b - a) / n
    x_tilde_list = []
    x_tilde_i = a
    push!(x_tilde_list, x_tilde_i)

    for i in 1:n
        x_tilde_i = x_tilde_i + h
        push!(x_tilde_list, x_tilde_i)
    end

    return x_tilde_list
end

function x_hat(a, b, n)
    h = (b - a) / n
    return [a + i * h for i in 0:n]
end

function x_acc(a, b, n)
    h = BigFloat((b - a) / n)
    return [BigFloat(a + i * h) for i in 0:n]
end

using Plots

x_tilde_err = abs.(x_acc(a, b, n) .- x_tilde(a, b, n))
x_hat_err = abs.(x_acc(a, b, n) .- x_hat(a, b, n))

# Unable to use log scale (some errors are 0)
s = plot([0:n], x_tilde_err, label="x_tilde error", color=:blue)
plot!([0:n], x_hat_err, label="x_hat error", color=:red)
xaxis!("\$x_i\$")
yaxis!("Abs. Value of Error")
savefig(s, "./assignments/assignment-1/spacing.png")