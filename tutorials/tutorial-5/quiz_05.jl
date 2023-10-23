using Plots

h = -1:0.1:3

xx = [-1, 0, 1, 2.31326, 3]
yy = [1, 0.5, -1, 4, 5]

l0 = (x) -> @. ((x - xx[2]) * (x - xx[3]) * (x - xx[4]) * (x - xx[5])) / ((xx[1] - xx[2]) * (xx[1] - xx[3]) * (xx[1] - xx[4]) * (xx[1] - xx[5]))
l1 = (x) -> @. ((x - xx[1]) * (x - xx[3]) * (x - xx[4]) * (x - xx[5])) / ((xx[2] - xx[1]) * (xx[2] - xx[3]) * (xx[2] - xx[4]) * (xx[2] - xx[5]))
l2 = (x) -> @. ((x - xx[1]) * (x - xx[2]) * (x - xx[4]) * (x - xx[5])) / ((xx[3] - xx[1]) * (xx[3] - xx[2]) * (xx[3] - xx[4]) * (xx[3] - xx[5]))
l3 = (x) -> @. ((x - xx[1]) * (x - xx[2]) * (x - xx[3]) * (x - xx[5])) / ((xx[4] - xx[1]) * (xx[4] - xx[2]) * (xx[4] - xx[3]) * (xx[4] - xx[5]))
l4 = (x) -> @. ((x - xx[1]) * (x - xx[2]) * (x - xx[3]) * (x - xx[4])) / ((xx[5] - xx[1]) * (xx[5] - xx[2]) * (xx[5] - xx[3]) * (xx[5] - xx[4]))

p = (x) -> @. yy[1] * l0(x) + yy[2] * l1(x) + yy[3] * l2(x) + yy[4] * l3(x) + yy[5] * l4(x)

f(x) = -0.5 * x^4 + 2 * x^3 - 3 * x + 0.5
error = abs.(f.(h) .- p.(h))

println("Max error x: ", h[argmax(error)])
println("Max error  : ", maximum(error))

plot(h, p(h))
scatter!(xx, yy)