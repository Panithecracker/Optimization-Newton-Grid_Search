format long
clc
clear
clf
%% PROJECT  DETAILS:
%% Made by Alejandro Fernández-Paniagua
%% PROJECT DETAILED EXPLANATION AND OBSERVATIONS:
fprintf(['Supported with the graph evidence, we have found that the minima of the ' ...
    '\n function z = f(x,y) inside the set S (square) is attained at (0,0) with ' ...
    '\n f(0,0) = 0. To arrive to this conclusion, we began by aiming to discover ' ...
    '\n the zeros of the Gradient of F, which can be calculated through the ' ...
    '\n Newton Method as we have seen. Besides this numerical approach to find the ' ...
    '\n zeros of the Grad function, one can also say that the grad is zero iff its ' ...
    '\n length is 0. And this is something that we can look for by graphing the ' ...
    '\n function Z = ||Grad_of_f(x,y)||. The zeros of that function (visible in ' ...
    '\n its plot) will be the points where the length of the gradient at (x,y) is 0.' ...
    '\n This happens when the gradient is zero itself, being then a minimum for f. ' ...
    '\n The plot reveals that the origin is one of them (note: logarithm is applied ' ...
    '\n to the length). However, if one zooms in around the blank (0,0) spot, ' ...
    '\n another 4 blank suspicious regions appear, providing 4 intervals where one can ' ...
    '\n find zeros as well. To get these 4 zeros remaining, after the graphical ' ...
    '\n data received, using pen and paper it is deduced that to be a zero of the ' ...
    '\n gradient, the first entry must be as well a zero of a polynomial of 4th degree. ' ...
    '\n Here, fortunately it is straight forward to compute the x entry since it ' ...
    '\n is a matter of solving a bicuadratic equation. However, maybe in other cases ' ...
    '\n the Roots of the polynomial gotten is not as easy to compute as in this ' ...
    '\n case (which is not the usual for polynomials) and one could also ' ...
    '\n use the following approach based on the regions gotten from the plot before. ' ...
    '\n Basically, thanks to the regions in the plot, the presence of the ' ...
    '\n Roots can be bracketed with small intervals using the plot,verifying Bolzano. ' ...
    '\n Thus, one could then apply any root method using a guess initially ' ...
    '\n in the bracket (maybe for some guesses doesnt converge but this is a ' ...
    '\n matter of using a good initial guess which could in the worst case be ' ...
    '\n found after brute force with computers or hand; the important thing is ' ...
    '\n that we have a unique root tracked inside a relatively small interval!).\n'])

fprintf(['This covers the root finding part. In regards to the colored plot, now' ...
    '\n that we found the roots numerically, we store them inside a Matrix and' ...
    '\n workout the Newton Method for a set of equispaced points (0.25 units apart) ' ...
    '\n inside the square S and covering its sorroundings within the bigger ' ...
    '\n square [-6*6]. There are 2401 different points to evaluate in here ' ...
    '\n already! It should be precise enough to let us draw right conclusions ' ...
    '\n about the convergence overall. For the seek of clarity, we inform the ' ...
    '\n reader to know that the points are colored in 4 different ways based on ' ...
    '\n the number of iterations/convergence behaviour: Green (converges in <=4 iters), ' ...
    '\n Blue(converges in >4 and <=7 iters), Yellow(converges in >7 and <=9 iters) ' ...
    '\n and Red(diverges since it doesnt converge in <=9 iters). ' ...
    '\n Note that we consider that a point converges when the distance from the point ' ...
    '\n to a root is less than 10^-6. Finally, we support this evidence with the ' ...
    '\n graph of the condition number of the Jacobian matrix , which is only ' ...
    '\n dependent on the x component of the points from where we iterate.\n'])
 
fprintf(['Final Observations: ' ...
    '\n The condition number shows a pretty unstable behaviour inside the regions ' ...
    '\n bounded by the vertical lines x=-2 and x= 2, fluctuating often and ' ...
    '\n reaching a local maximum at x = +-1.5 where not coinditentially, the ' ...
    '\n points are red (divergence). However the rest of the points here coonverge ' ...
    '\n to the roots, being the best options to start with (lots of green), having ' ...
    '\n a condition number that stays below 1 on average, with the exception of ' ...
    '\n the points at x=+-0.5 where it raises to 1.7 causing the color to be blue ' ...
    '\n instead of green as the rest. Now, leaving this fluctuating region apart, the ' ...
    '\n rest of the points show an increasing condition number as one keeps on ' ...
    '\n moving to the right from x=2 and decreasing from left to x=-2. Thus, all ' ...
    '\n of them share the same behaviour progressively, being divergent(red) the ' ...
    '\n ones at the leftmost part (including outside of S) and the ones at the ' ...
    '\n rightmost part (including outside of S) and progressively changing from ' ...
    '\n red-yellow-blue seing it from the left of the square and blue-yellow-red ' ...
    '\n from the right, respectively. Hence, we could say that overall, the ' ...
    '\n condition number is higher than 1, being not very well conditioned in ' ...
    '\n general ie: unstable generally. With respect to orbitting outside of the ' ...
    '\n square, then those points will suffer from a bad end, diverging all . With ' ...
    '\n respect to the criteria used to stop iterating, apart from whenever the ' ...
    '\n number of iterations done is greater than 9 or being close enough to any ' ...
    '\n of the roots (10^-6 specifically), there are places where the InverseJacobian ' ...
    '\n is undefined due to division by 0. Those points are the roots of a one variable ' ...
    '\n function which is the following : ' ...
    '\n y = 2g(x) -1 where g(x) = 5x^4-12.6x^2 +4. which are approx at x= +-0.6 ' ...
    '\n and +-1.5. Therefore, the stopping criteria added is to make sure we are ' ...
    '\n not going to divide by zero, so that when this is the case, we simply ' ...
    '\n stop. Additionally, this conflictive points may also gives us some hints ' ...
    '\n and intuition behind the reasons why the points in their neighbourhoods ' ...
    '\n (which are lines close to x=+-roots of 2g(x)-1) might behave on the way ' ...
    '\n they do when using them as initial guesses. It is certain that at them, ' ...
    '\n we are almost dividing by zero the columns of the InverseJacobian, which ' ...
    '\n is like scaling the pair of columns almost to infinity. This will firstly ' ...
    '\n make one think that they will diverge without doubt and in fact for the ' ...
    '\n neighbours of x=+-1.5 this is true (red). However, for the other ones, ' ...
    '\n ie: the neighbours of x=+-0.5, they converge (actually almost instantly; blue). ' ...
    '\n The exact reason is yet unkown but we wonder if the size of the subtraend ' ...
    '\n (the linear combination of columns of JacobianInverse with the Gradient entries)' ...
    '\n might have something to do with it. At the neighbours of the ones where ' ...
    '\n it diverges, it is pretty small, while at the ones where it converges it is huge in comparison.\n']) 

%% STEP 1: PLOTTING TO HELP US FIND THE MINIMA OF F INSIDE THE SET S
%Graph of f and ||Grad_of_f|| %note: the second pne has log applied to it
x = -6:0.25:6;
y = -6:0.25:6;
[X,Y] = meshgrid(x,y);
for i =1:length(x)
    for j=1:length(y)
        Z(i,j) = log(NormGrad(X(i,j),Y(i,j)));
    end
end
figure
grid on
surf(X,Y,Z)
title("z =||Gradient(x,y)||(to target the zeros)")
xlabel("X values")
ylabel("Y values")
zlabel("Lentgh of the gradient")
shading interp
figure
for i =1:length(x)
    for j=1:length(y)
        Z(i,j) = ScalarFunc(X(i,j),Y(i,j));
    end
end
surf(X,Y,Z)
title("z=f(x,y)")
xlabel("X values")
ylabel("Y values")
zlabel("Z values")
shading interp

%% STEP 2 : USING NEWTON METHOD AND INFO ABOUT THE MINIMUM TO DETERMINE CONVERGENCE OF EQUISPACED SET OF POINTS
%% things to have in mind are :
%After the work described, we have found the exact Roots to the gradient
%%Roots Sorage : %each row has a root (first column for the first entry and second for the second one)

%matlab still doesnt recognise the correct value of the Gradient vector
%corresponding to the roots stored(it carries some rounding error when
%computing gradient(x,y)
Roots(1,1) = 0;
Roots(1,2) = 0;
Roots(2,1) = sqrt((4.2+sqrt(3.64))/2);
Roots(2,2) = -0.5*Roots(2,1);
Roots(3,1) = -1*sqrt((4.2+sqrt(3.64))/2);
Roots(3,2) = -0.5*Roots(3,1);
Roots(4,1) =  sqrt((4.2-sqrt(3.64))/2);
Roots(4,2) = -0.5*Roots(4,1);
Roots(5,1) = -1*sqrt((4.2-sqrt(3.64))/2);
Roots(5,2) = -0.5*Roots(5,1);

%% NEWTON METHOD ALGORITHM TO EQUISPACED POINTS + PLOT OF COLORED POINTS
xequispaced = [-6:0.25:6];
yequispaced = [-6:0.25:6];
figure
title("CONVERGENCE ON EQUISPACED POINTS")
xlabel("x values");
ylabel("y values");
hold on
count = 0;
for i=1:length(xequispaced)
    xo(1) = xequispaced(i);
    for j=1:length(yequispaced)
        xo(2) = yequispaced(j);
        info = NewtonRaphson(xo,Roots);
        count = count+1;
        %paint it with determined color in the plane
        if(info(1) == 1) %the current guess converges 
            if info(2) <=4 %fast convergence
               %green
                plot(xo(1),xo(2),".-",'Color',[0 1 0])
            end
            if (info(2) >=5 && info(2)<=7)
                %light blue
                plot(xo(1),xo(2),".-",'Color',[0 1 1])
            end
            if(info(2)>=8)
                %yellow
                plot(xo(1),xo(2),".-",'Color',[1 1 0])
            end
        else %diverges
            plot(xo(1),xo(2),".-",'Color',[1 0 0])
        end
    end
end
%% CONDITION NUMBER OF THE JACOBIAN MATRIX USED TO ITERATE FROM EACH POINT TO THE NEXT ONE
index = 0;
for i=1:length(xequispaced)
    xo(1) = xequispaced(i);
    for j=1:length(yequispaced)
        index = index+1;
        xo(2) = yequispaced(j);
        XO1(index) = xo(1);
        %now to get x1 from xo we will use the inverse of the Jaco at xo
        C(index) = log(cond(Jacobian(xo(1)))); %it doesnt depend on the second entry of xo though, this can be seen in the 3d plot below
    end
end
figure
plot(XO1,C);
title("Guesses and respective condition number(2D) ");
xlabel("Guess x entry");
ylabel("Condition number");

%%Extra: Visualize the size of the subtraend , InverseJ(x)*Grad(x,y) at
%%neighbourhoods of vertical lines where the InverseJacobian rockets
%%(almost /0)
xequispaced = 0.4:0.025:0.728;
yequispaced = -5:1:5;
[X, Y] = meshgrid(xequispaced,yequispaced);
for i=1:size(X,1)
    for j=1:size(X,2)
        L(i,j) = NormCombination(X(i,j),Y(i,j));
    end
end
figure
surf(X,Y,L);
shading interp
hold on
xequispaced = 1.268:0.025:1.7;
yequispaced = -5:1:5;
[X, Y] = meshgrid(xequispaced,yequispaced);
for i=1:size(X,1)
    for j=1:size(X,2)
        L(i,j) = NormCombination(X(i,j),Y(i,j));
    end
end
surf(X,Y,L);
shading interp
title("SUBTRAEND SIZE AT CONFLICTIVE REGIONS")
xlabel("x entry")
ylabel("y entry")
zlabel("∥InverseJ(x)×∇f(x,y)∥")


%% USED FUNCTIONS CREATED BY US
function y = polynomial(x)
y = (x^5)-(1.2*x^3)+(3.5*x);
end
function z = ScalarFunc(x,y)
 %det.ailed problem function given,to minimize over S
 z = (2*x^2)-(1.05*x^4)+(x^6/6)+(x*y)+(y^2);
end
function vect = Grad(x,y)
%gradient of scalar function f(x,y) which has been derived with paper
vect = zeros(1,2);
vect(1) = (x^5)-(4.2*x^3)+(4*x)+(y);
vect(2) = (x)+(2*y);
end        
function z = NormGrad(x,y)
%computes the length of the gradient of the function f(x,y) at the point (x,y)
Gradient  = Grad(x,y);
fx = Gradient(1); %partial of f with respect to x
fy = Gradient(2); %partial of f with respect to y
z = sqrt((fx^2)+(fy^2));
end
function z = Distance(vector)
  %computes the distance between (0,0) and vector
  z = sqrt((vector(1)^2)+(vector(2)^2));
end
function y = g(x)
  %function used in the Jacobians computation
  y = 4-(12.6*x^2)+(5*x^4);
end
function J = Jacobian(x)
 %this function returns the Jacobian of the gradient of f(x,y) at the point
 %(x,y) arrived to all of this through pen and paper
 J = zeros(2,2);
 J(1,1) = g(x);
 J(1,2) = 1;
 J(2,1) = 1;
 J(2,2) = 2;
end
function JInv = JacobianInverse(x)
  %inverse of the Jacobian matrix , arrived with pen and paper
  JInv = zeros(2,2);
  JInv(1,1) = 2;
  JInv(1,2) = -1;
  JInv(2,1) = -1;
  JInv(2,2) = g(x);
  JInv = JInv/(2*g(x)-1);
end
function answer = Accurate(Roots,guess)
 %this function returns a 1 whenever the guess is accurate ie : the
 %distance from guess and any root inside matrix Roots is <10^-6
 answer = 0; %initial value (not accurate)
 for i=1:5
     root = [Roots(i,1) Roots(i,2)]; %root vector to use 
     diff = root-guess;
     if Distance(diff)<10^-6
         answer = 1;
     end
 end
end
function info = NewtonRaphson(guess,Roots)
 %this function performs the Newton Raphson Method starting from x = x0
 %% Stopping criteria:
 % Note: Max iterations is 25(fixed).Assuming we have iterations left : 
 % - Stop if converges <-> dist(x,some root) <10^-6
 % - Stop if division by 0 can appear (0 on denominator of InverseJacobian,
 % when 2g(x)-1 = 0)
 %Input : initial guess x0 (vector in R2)
 %Output : vector containing 1/0 and number of iterations done
 % first entry -> if it converges to accuracy (1 or 0) 
 % second entry-> number of iterations to get there (note : -1 if diverges)
 stop = 0; %this allows the computer to keep iterating
 max = 9; %iterations limit(fixed)
 iterations = 0;
 converges = 0; %initial value says that it doesnt
 if Accurate(Roots,guess) == 1
     converges = 1;
     stop = 1;
 end
 while stop == 0
     %apply NRM 
     iterations = iterations+1; %increment the counter of iterations...
     %check that division by 0 doesnt happen 
     if ((2*g(guess(1))-1) ~=0) %then we can proceed to get the next guess
     guess = guess - (Grad(guess(1),guess(2))*JacobianInverse(guess(1)));
     end
     %check accuracy
     if Accurate(Roots,guess) == 1
         converges = 1;
         stop = 1;
     end
     %check amount of iterations
     if iterations >= max
        stop = 1;
     end
 end
 %store information about the method inside the output vector info...
 info(1) = converges;
 info(2) = iterations;
end
function z = NormCombination(x,y)
%this function is intended to be used for a plot which may gives us better
%answers to why there is convergence to the roots for neighbourhs of the
%conflictive points at approx x= +-0.564 while there is divergence for the
%same type of points when these are the points with x = +-1.784 approx
%It computes z = ||JacobianInverse(x)*Grad(x,y)|| (the smaller z, the
%smaller the difference from current guess to next one)
subtrahend = JacobianInverse(x)*Grad(x,y)';
z = sqrt(subtrahend(1)^2+subtrahend(2)^2);
end
