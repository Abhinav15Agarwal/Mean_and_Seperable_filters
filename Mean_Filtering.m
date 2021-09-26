close all;
clear all;
clc
Img = imread('P2_lake.png');
%i = im2double(Img);
Img_grey = .299*Img(:,:,1) + .587*Img(:,:,2) + .114*Img(:,:,3);
figure(1);
imshow(Img_grey);
title('Original Image');
N = 7;
%F = ones(N)/(N.^2);
F = [1/7;1/7;1/7;1/7;1/7;1/7;1/7];
%F = [1/7 1/7 1/7 1/7 1/7 1/7 1/7];
output_final = floor(convolve(Img_grey, F));
figure(2);
imshow(output_final, []);
title('[7x7] Smooth Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%GIm=imread('tire.tif');


numofpixels=size(output_final,1)*size(output_final,2);


%figure,imshow(GIm);

%title('Original Image');
HIm=uint8(zeros(size(output_final,1),size(output_final,2)));

freq=zeros(256,1);

probf=zeros(256,1);

probc=zeros(256,1);

cum=zeros(256,1);

output=zeros(256,1);


%freq counts the occurrence of each pixel value.

%The probability of each occurrence is calculated by probf.


for i=1:size(output_final,1)

    for j=1:size(output_final,2)

        value=output_final(i,j);

        freq(value+1)=freq(value+1)+1;

        probf(value+1)=freq(value+1)/numofpixels;

    end

end


sum=0;

no_bins=255;


%The cumulative distribution probability is calculated. 

for i=1:size(probf)

   sum=sum+freq(i);

   cum(i)=sum;

   probc(i)=cum(i)/numofpixels;

   output(i)=round(probc(i)*no_bins);

end
figure,stem(output)

title('Histogram Equilization');

