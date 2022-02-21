clear all;
clc;

pkg load io

C = 100000000;
B = 400000000;
P = 500000000;
N = 120;
 
R1 = 3942251;
R2 = 4934048;

X1 = R1/P;
X2 = R2/P;

A1 =  (X1*(P-((1+X1)^N)*C))/((1+X1)^N-1);
A2 =  (X2*(P-((1+X2)^N)*C))/((1+X2)^N-1);

for i = 1:N
  fprintf("BULAN KE-%d\n",i)
  disp("---------------------------------------------------------")
  if i <= 60
    R = R1;
    X = X1;
    A = A1;
  else
    R = R2;
    X = X2;
    A = A2;
  endif
  E = C * X;
  C = A + E + C;
  B = P - C;
  F = R - E;
  D = C/P;
  M = R + A;
  
  if B <= 0
    B = 0;
    C = P;
  endif
  
  fprintf("Harga Sewa\t\t\t: %f\n",R);
  fprintf("Angsuran Tambahan Perbulan\t: %f\n",A);
  fprintf("Total Angsuran Perbulan\t\t: %f\n",M);
  fprintf("Rasio Nasabah\t\t\t: %f\n",D);
  fprintf("Bagi Sewa Nasabah\t\t: %f\n",E);
  fprintf("Bagi Sewa Bank\t\t\t: %f\n",F);
  fprintf("Modal Nasabah\t\t\t: %f\n",C);
  fprintf("Modal Bank\t\t\t: %f\n\n",B);
  
  if B == 0
    break
  endif
endfor