clear;
clc;
close all;
%-----------------

pathname='F:\PZ\Polarization_fusion\T1110';
cd(pathname);
[filename1,pathname1]=uigetfile({'*.tiff;*.jpg','All Image Files'},'0бу');

[filename2,pathname2]=uigetfile({'*.tiff;*.jpg','All Image Files'},'45бу');
[filename3,pathname3]=uigetfile({'*.tiff;*.jpg','All Image Files'},'90бу');
[filename4,pathname4]=uigetfile({'*.tiff;*.jpg','All Image Files'},'135бу');

i0=double(imread(strcat(pathname1,filename1)));
i45=double(imread(strcat(pathname2,filename2)));
i90=double(imread(strcat(pathname3,filename3)));
i135=double(imread(strcat(pathname4,filename4)));

Q = i0-i90;
U= i45-i135;
I= i0+i45+i90+i135;      
P =( sqrt(Q.^2 +  U.^2))./I ;
%---A
A = U;
L = ((Q > 0)&(U>=0));
A(L) = atan(U(L)./Q(L))./2;

L = ((Q > 0)&(U<0));
A(L) = atan(U(L)./Q(L))./2+3.1415926;

L = ((Q == 0)&(U>=0));
A(L) =3.1415926/4;

L = ((Q == 0)&(U<0));
A(L) =3*3.1415926/4;

L = (Q< 0);
A(L) =( atan(U(L)./Q(L))+3.1415926)./2;

B=sqrt(abs(I.*P-Q));
C=sqrt(abs(I.*P+Q));
D=C-B;
E=B./D;
F=abs(Q./I);
Imax=(1+P).*I./2;
Imin=(1-P).*I./2;
PDI=Imax-Imin;

figure(1);
imshow(mat2gray(I));
title('I_image');
 
figure(2);
imshow(mat2gray(A));
title('DOLP_image');

figure(3);
imshow(mat2gray(P));
title('AOP_image');


figure(4);
imshow(mat2gray(U));
title('U');

% 
figure(5);
imshow(mat2gray(Q));
title('Q');

% 
% 
figure(6);
imshow((mat2gray(B)));
title('imgB');

% 
figure(7);
imshow(mat2gray(C));
title('imgC');

% 
figure(8);
imshow(mat2gray(D));
title('imgD');


figure(9);
imshow(mat2gray(F));
title('imgF');

figure(10);
imshow(mat2gray(PDI));
title('Imax-Imin');


imwrite(mat2gray(I),strcat(pathname1,'I_image.bmp'));
imwrite(mat2gray(P),strcat(pathname1,'DOLP_image.bmp'));%
imwrite(mat2gray(A),strcat(pathname1,'AOP_image.bmp'));
imwrite(mat2gray(Q),strcat(pathname1,'Q_image.bmp'));
imwrite(mat2gray(U),strcat(pathname1,'U_image.bmp'));
imwrite(mat2gray(B),strcat(pathname1,'Ey_image.bmp'));
imwrite(mat2gray(C),strcat(pathname1,'Ex_image.bmp'));
imwrite(mat2gray(D),strcat(pathname1,'Ey-Ex_image.bmp'));
imwrite(mat2gray(E),strcat(pathname1,'Azimuth_image.bmp'));
imwrite(mat2gray(F),strcat(pathname1,'imgF_image.bmp'));
imwrite(mat2gray(PDI),strcat(pathname1,'Imax-Imin_image.bmp'));




