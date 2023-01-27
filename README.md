# Optimization-Newton-Grid_Search Project
This project is covered by the Mit License
# Problem Description:
We are going to work on minimizing a function f over a set S, where:
$$f(x, y) = 2x^2 − 1.05x^4 +0.16x^6+ xy + y^2 $$ and S = {(x,y)| -5 <= x,y <= 5}
**Any minima of this function, since it is a polynomial, must be at zeros of the gradient and thus,
we can use the Newton-Raphson method to search for those zeros, so in some sense we know
the minima already a priori, but what we want to understand is from which points will we have
faster convergence to the minimum?**.**From some points there may be no convergence at all or
it may take more or less iterations to reach a reasonable accuracy around the minimum. Let’s fix
this accuracy at points that are less than 10−6 distance from the correct minimum**. We will **also
pay attention at the conditioning of the problem at each step, expressed in the condition number
of the Jacobian**.
Task:
*Write a program that implements the Newton-Raphson method in order to find
zeros of the gradient of the function f above from a given starting point x ∈ S.
Plot the function together with a visual explanation of the regions from where there will be
convergence to the minimum, or any other situation. For this you may do a grid search, that is,
apply the method from many equispaced points in the defined region, and see where each point
goes.
Also paint each point in the grid with a different colour (this may be in a separate plot) according
to how many iterations does it take to arrive to the desired accuracy.
Draw a 3rd plot with the condition number of the Jacobian matrix used to iterate from each
point. From your observations about these, is the process well-conditioned as a whole?
Think also about the following questions: (1) what happens if the point’s orbit does, at some
step, leave the square S? (2) what criteria did you choose for stopping apart from arriving to the
correct spot?
Notice the condition number of a matrix is implemented in Matlab in the command cond.*

**Solution -> Check the [code](https://link-url-here.org) inside this repo to see how I solved it and the full [written conclusion](https://link-url-here.org)**
 # Solution :
 **Note: The grid search plot is coloured according to the number of iterations taken from the respecitve point to get to the desired accuracy.**

 ![rsz_2023-01-27_2](https://user-images.githubusercontent.com/97905110/215085865-3376a333-1b72-4bb3-ac17-67d002b88b4d.png)  ![rsz_2023-01-27_3](https://user-images.githubusercontent.com/97905110/215086113-bdaaf431-3a67-4787-9bc6-d3e43c1176d0.png)
![2023-01-27 (1) (1)](https://user-images.githubusercontent.com/97905110/215087998-73fcc38d-ece3-4479-a77d-db0c474e0406.png)
![chart (1)](https://user-images.githubusercontent.com/97905110/215091322-5fc4fc03-b721-4858-903d-fda2ce5d62fc.png)
