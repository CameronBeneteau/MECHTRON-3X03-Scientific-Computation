#Tutorial 10
 
using LinearAlgebra
using Plots
 
# Define function for Forward Euler
function forEuler(f,t_in,t_end,y_in,h)
   
    # Define time array
    t = range(t_in,t_end,step=h);
   
    # Define output array
    y = [y_in];
   
    # Loop over all time instants
    for i = 2:length(t)
        y_new = y[end]+h*f(t[i-1],y[end]);
        append!(y,y_new)
    end
   
    # Return time and output
    return (t,y)
end
 
# Define function
y_acc(t) = @. exp(-t^2);
y(t, y) = @. -2*t * y;
 
# Define time limit and initial condition
t_in = 0.0;
t_end = 10.0;
h1 = 0.01;
h2 = 0.3;
y_in = 1.0;
 
# Apply Forward Euler's method
(t,y_for) = forEuler(y,t_in,t_end,y_in,h1);
(t2,y_for2) = forEuler(y,t_in,t_end,y_in,h2);
 
globalError = zeros(length(t));
for i in 1:length(t)
    globalError[i] = abs.(y_for[i] - y_acc(t[i]));
end
 
#Question 1:
p1 = Plots.plot(t,globalError,label="global error",xlabel="t",ylabel="y")
 
#Question 2:
#we see in the plot that the solution is not stable when h=0.3
#therefore we see how the actual solution (y_acc in red) decreases,
#whereas y_for2 (in blue) diverges from the true solution, showing its instability
p2 = Plots.plot(t2,abs.(y_for2),label="y_for2",xlabel="t",ylabel="y", yaxis=:log, ylimits=(10^-5,10^5))
Plots.plot!(t2,y_acc, label="y_acc")
Plots.plot!([t_in],[y_in],label="Initial Condition",markershape=:circle)
 
#Question 3:
#Forward Eulers method is stable if |1+h*lambda|<= 1
#y'(t) = A(t) * y(t), where A(t) = -2(t)
#Since h=0.3, |1-0.6t|<= 1 will be stable
#Solving the inequality, we get 0 <= t <= 10/3
#We can see with t_end = 10/3, it converges to zeros
#Whereas when t_end = 11/3 (i.e. just a bit higher), the global error begins to diverge
#Thus 10.3 is the maximum value of t_end that makes the numerical solution stable with h=0.3
(t7,y_for2_7) = forEuler(y,t_in,(10/3),y_in,h2);
(t6,y_for2_6) = forEuler(y,t_in,(11/3),y_in,h2);
 
globalError7 = zeros(length(t7));
for i in 1:length(t7)
    globalError7[i] = abs.(y_for2_7[i] - y_acc(t7[i]));
end
 
globalError6 = zeros(length(t6));
for i in 1:length(t6)
    globalError6[i] = abs.(y_for2_6[i] - y_acc(t6[i]));
end
 
p3 = Plots.plot(t7,globalError7,label="t_end = 10/3",xlabel="t",ylabel="y")
Plots.plot!(t6,globalError6, label="t_end = 11/3")
 
Plots.plot(p1,p2,p3, layout=(3,1))