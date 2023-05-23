% 2+8+7+8+2+1+7=35
% 35 mod 3 + 1 =3
% Therefore, my method is Secant.
% i = 7 mod 3 + 1 = 3
% My function is V(t)=2t^2+sin(3t)*exp(-t/8).
format long
clc

r1 = 2;
l1 = 3;
l2 = 3;
r2 = 4;
N = 100;
tol = 10^(-4);

v1 = (4/3)*pi*r1^3;
v2 = (1/3)*pi*r2^2*l1;
v3 = pi*r2^2*l2;
v4 = (1/2)*(4/3)*pi*r2^3;

simulate(r1,l1, l2, r2, N, tol);

syms t;
f = 2*t^2+sin(3*t)*exp(-t/8);
f1 = f - v1;
f2 = f1 - v2;
f3 = f2 - v3;
f4 = f3 - v4;

TA = solver(f1, 0, 2, tol);
TB = solver(f2, 0, 2, tol);
TC = solver(f3, 0, 2, tol);
TD = solver(f4, 0, 2, tol);

disp(TA)
disp(TB)
disp(TC)
disp(TD)


function [root] = solver(func, t0, t1, tole)
syms t
  t2 = t1 + 3;
  while abs(t2 - t1) >= tole
      t1 = t2;
      f_0 = vpa(subs(func, t, t0));
      f_1 = vpa(subs(func, t, t1));
      t2 = t1-f_1*((t1 - t0)/(f_1 - f_0));
      t0 = t1;
  end
  root = t2;
end


function simulate(r_1,l_1, l_2, r_2, N, tol)
syms t
f = 2*t^2+sin(3*t)*exp(-t/8);
v1 = (4/3)*pi*r_1^3;
v2 = (1/3)*pi*r_2^2*l_1;
v3 = pi*r_2^2*l_2;
v4 = (1/2)*(4/3)*pi*r_2^3;

H = 2*r_1 + l_1 +l_2 +r_2;
H_int = H/N;
H_list = zeros(1, N + 1);
for i = 1:N + 1
    H_list(i) = (i-1) * H_int;
end

T_list = zeros(1, N + 1);

  for i= 1:N+1
      H_list(i) = i*H_int;

      if H_list(i) <= 2*r_1
          v = (pi/3)*(3*r_1*H_list(i)^2 - H_list(i)^3);
          T_list(i) = solver(f - v, 0, 2, tol);

      elseif (H_list(i) <= 2*r_1 + l_1) && (H_list(i) > 2*r_1)
          H_cur = H_list(i) - 2*r_1;
          v = 1/3*pi*(H_cur*r_2/l_1)^2 * H_cur + v1;
          T_list(i) = solver(f - v, 0, 2, tol);

      elseif (H_list(i) <= 2*r_1 + l_1 + l_2) && (H_list(i) > 2*r_1 + l_1)
          H_cur = H_list(i)-2*r_1 - l_1;
          v = pi*r_2^2*H_cur + v1 + v2;
          %v_total = pi*r_2^2*(H_list(i)-2*r_1-l_1) + v1 + v2;
          T_list(i) = solver(f - v, 0, 2, tol);

      elseif H_list(i) == 2*r_1 + l_1 + l_2 + r_2
          v = v1 + v2 + v3 + v4;
          T_list(i) = solver(f - v, 0, 2, tol);
      else 
          H_cur = H_list(i) - 2*r_1 - l_2 - l_1;
          v = pi/3*(3*r_2^2*H_cur-H_cur^3)+v1 + v2 + v3;
          T_list(i) = solver(f - v, 0, 2, tol);
      end
  end
    plot(T_list, H_list)
  title('Plot for Time VS Height')
  xlabel('Time')
  ylabel('Height')

end


























