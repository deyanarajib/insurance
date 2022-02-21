clear all;
clc;

pkg load io;

[data,mystr] = xlsread('data.xlsx','B2:E101');
printf('\n\n')

kpe  = mystr(:,1);
nama = mystr(:,2);
gol  = mystr(:,3);

%SESUAIKAN DENGAN DATA
dp = 4/100;      % iuran ditanggung perusahaan = 4%
dg = 1/100;      % iuran ditanggung gaji = 1%
r  = 5/100;      % r = 5%
pk = 55-25;      % periode kerja = 30 tahun
tk = 21/100;     % tingkat konstribusi = 21%
hh = 75;         % usia harapan hidup = 75 tahun
up = 55;         % usia pensiun = 55 tahun

disp('PERHITUNGAN DANA PENSIUN')
disp('----------------------------------------------------')
setgol = unique(gol);
for i = 1:size(setgol,1)
  printf('>> BERPENGHASILAN %s\n',setgol{i});
  
  # besaran gaji pokok untuk golongan i
  gb = unique(data(strcmp (gol, setgol{i})));
  
  for j = 1:size(gb,1)
    printf('   Gaji Pokok = %d\n',gb(j))
    
    gt = gb(j)*12;        % gaji tahunan
    C  = tk*gt;           % konstribusi total
    P  = ((1+r)^pk-1)/r;  % rumus AF tahun 30?
    AF = round(C*P);      % akumulasi dana tahun ke-N
    
    GT(i,j) = gt;
    GB(i,j) = gb(j);
    
    printf('   AF%d       = %s\n\n',pk,num2str(AF))
  endfor
  disp('')
endfor

disp('AKUMULASI DANA PENSIUN')
disp('----------------------------------------------------')

for i = 1:size(GB,1)
  printf('>> BERPENGHASILAN %s\n',setgol{i});
  for j = 1:size(GB,2)
    if GB(i,j) == 0
      continue
    endif
    printf('   <> Untuk Gaji Pokok: %d\n',GB(i,j))
    
    SRS = 0;
    for tahun = 1:hh-up
      printf('      Tahun ke-%d\n',tahun)
      
      dpa = round(GT(i,j)/(1+r)^tahun); % diskon pembayaran anuitas
      SRS = round(SRS + dpa);           % total SRS
      
      printf('      - Pembayaran Anuitas: %d\n',GT(i,j))
      printf('      - Diskon Pem Anuitas: %s\n',num2str(dpa))
      printf('      - Total SRS         : %s\n\n',num2str(SRS))
      
    endfor
  endfor
endfor

disp('MANFAAT KESEHATAN')
disp('----------------------------------------------------')
for i = 1:size(GB,1)
  printf('>> BERPENGHASILAN %s\n',setgol{i});
  for j = 1:size(GB,2)
    if GB(i,j) == 0
      continue
    endif
    printf('   <> Untuk Gaji Pokok: %d\n',GB(i,j))
    
    idp = dp*GB(i,j);   % nilai iuran BPJS ditanggung perusahaan
    idg = dg*GB(i,j);   % nilai iuran BPJS dipotong dari gaji
    ti  = idp+idg;      % total iuran BPJS
    
    printf('      - Ditanggung Perusahaan: %s\n',num2str(idp))
    printf('      - Dipotong dari Gaji   : %s\n',num2str(idg))
    printf('      - Total Iuran BPJS     : %s\n\n',num2str(ti))
    
  endfor
endfor