clear all;
clc;

listrate = [0.0326 0.0247 0.0208 0.012 0.0105];

N = input('Input Banyak Tahun: ');

for i = 1:N
  fprintf('Input Harga Kendaraan Tahun ke-%d: ',i)
  harga = input('');
  
  if harga <= 125000000
    rate = listrate(1);
  elseif harga > 125000000 & harga <= 200000000
    rate = listrate(2);
  elseif harga > 200000000 & harga <= 400000000
    rate = listrate(3);
  elseif harga > 400000000 & harga <= 800000000
    rate = listrate(4);
  else
    rate = listrate(5);
  endif
  
  P = harga*rate;
  T = 0.6*P;
  U = 0.4*P;
  I = T;
  HI = 0.1*I;
  KP = 0.7*HI;
  KT = 0.3*HI;
  TL = T+KT;
  BK = 0.7*TL;
  ST = TL-BK;
  STp = 0.3*ST;
  STs = 0.675*ST;
  STc = 0.025*ST;
  
  data(i,:) = [P T U I HI KP KT TL BK ST STp STs STc];

endfor

for i = 1:N
  disp('')
  fprintf('TAHUN KE- %d\n',i)
  disp('-----------------------------')
  fprintf('Premi\t\t: %f\n',data(i,1))
  fprintf('Tabarru\t\t: %f\n',data(i,2))
  fprintf('Ujrah\t\t: %f\n',data(i,3))
  fprintf('Investasi\t: %f\n',data(i,4))
  fprintf('Hasil Investasi\t: %f\n',data(i,5))
  fprintf('HI Perusahaan\t: %f\n',data(i,6))
  fprintf('HI Tabarru\t: %f\n',data(i,7))
  fprintf('Tabarru Total\t: %f\n',data(i,8))
  fprintf('Biaya Asuransi\t: %f\n',data(i,9))
  fprintf('Surplus Tabarru\t: %f\n',data(i,10))
  fprintf('ST Nasabah\t: %f\n',data(i,10))
  fprintf('ST Perusahaan\t: %f\n',data(i,11))
  fprintf('ST Cad.Tabarru\t: %f\n',data(i,12))
endfor
