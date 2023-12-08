function dx= fun(t,x)
A = [0 1; 32 -2.2];
B = [0;1];
K = [178.6424   16.8296];

dx=A*x+B*(-K*x);
end

