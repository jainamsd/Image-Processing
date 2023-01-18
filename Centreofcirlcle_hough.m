clear all,close all,clc;
input_image = imread("C:\Users\doshij\Desktop\image2.jpeg");
original=imread("C:\Users\doshij\Desktop\image2.jpeg");
figure
imshow(input_image);
gray_scale=rgb2gray(input_image);
% convert to grayscale:
% generate the edge image
BW= edge (gray_scale, 'canny');% binary output
figure
imshow(BW);
% Parameterization
theta_sample_frequency= 0.01; % Quantization step size
theta=(0:theta_sample_frequency:2*pi);% gradient angle in radians
num_thetas=numel (theta);
[x, y] = size (BW);% input image dimension
x0 = (1:x);
y0 = (1:y);
acc = zeros(x,y);% accumulator 1.e. hough space
r=30;
% Hough transform
for xi=1:x
for yj=1:y
if BW(xi,yj)==1 % this is edge point
for theta_id= 1:num_thetas
th=theta(theta_id);
a=round(xi-r*cos(th));
b=round(yj-r*sin(th));
if(a>0&&a<=x&&b>0&&b<=y)
acc(a,b) = acc(a,b)+1;
end
end
end
end
end
% Extract the parameters
[M, input_image]= max(acc (:)); %#ok<ASGLU> % detecting the maxima
[a, b] = ind2sub (size (acc), input_image); % Its courdinate in HT space
C=[y0(b), x0(a)]; % Centre of the circle
figure
subplot(1,2,1);
imagesc(original);
colormap(gray);
hold on;
viscircles(C,r,'color','y')
subplot(1,2,2);
imagesc(gray_scale);
colormap(gray);
hold on;
viscircles( C, r, 'color', 'y')