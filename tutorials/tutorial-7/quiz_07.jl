function comp_trap(f, a, b, n)
    h = (b - a) / (n - 1)
    res = h / 2 * (f(a) + f(b))

    for i in 1:n-2
        res += h * f(a + h * i)
    end

    return res
end

function comp_simp(f, a, b, n)
    h = (b - a) / (n - 1)
    res = (f(a) + f(b))

    for i in 1:(div(n - 1, 2)-1)
        res += 2 * f(a + h * (2 * i))
    end

    for i in 1:(div(n - 1, 2))
        res += 4 * f(a + h * (2 * i - 1))
    end

    return res * h / 3
end

a = 0
b = 6
n = 101

f(x) = @. sin(x)^2
i(x) = @. 0.5 * (x - sin(x) * cos(x))

trapElapsedTime = 0
simpElapsedTime = 0

runs = 10
for _ in 1:runs
    global trapElapsedTime += @elapsed comp_trap(f, a, b, n)
    global simpElapsedTime += @elapsed comp_simp(f, a, b, n)
end

trapResult = comp_trap(f, a, b, n)
simpResult = comp_simp(f, a, b, n)

println("Trap Result:\t\t", trapResult)
println("Trap Error:\t\t", abs(i(b) - i(a) - trapResult))
println("Average Trap Time:\t", trapElapsedTime / runs)
println("Simp Result:\t\t", simpResult)
println("Simp Error:\t\t", abs(i(b) - i(a) - simpResult))
println("Average Simp Time:\t", simpElapsedTime / runs)