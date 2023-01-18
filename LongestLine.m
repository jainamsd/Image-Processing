i=imread('C:\Users\doshij\Desktop\line.jpg');
rotI=rgb2gray(i);
bw=edge(rotI,'canny');
theta_sample_frequency=0.01;
[x,y]=size(bw);
rho_limit=norm([x,y]);
theta=(0:theta_sample_frequency:pi);
rho=(-rho_limit:1:rho_limit);
num_thetas=numel(theta);
num_rhos=numel(rho);
acc=zeros(num_rhos,num_thetas);
for xi=1:x
    for yj=1:y
        if bw(xi,yj)==1;
            for theta_id=1:num_thetas
                th = theta (theta_id);
                r=xi*cos(th)+yj*sin(th);
                rho_id = round(r+num_rhos/2);
                acc(rho_id,theta_id)=acc(rho_id, theta_id)+1;
            end
        end
    end
end
figure
imagesc(theta,rho,acc);
title('Hough Transform')
xlabel('Theta (radians)');
ylabel('Rho (pixels)');
colormap('gray'); hold on
%%extract the parameters
[M,I]=max(acc(:));
[rho_id,theta_id]=ind2sub(size(acc),I);
plot(theta(theta_id),rho(rho_id),'o','LineWidth',3);
hold off;
%%compute the line coordinate
m=-(cos(0.46)/sin(0.46)); %slope
b=(511)/sin(0.46); % the intercept
x=1:x; % x coordinates
y=m*x+b; % y coordiantes
%-Note: remember the variation between Matlab image and plot coordinate
%system
figure;
plot(x,m*x+b);%it will be roated one
%% plot the detected line superimposed on original
figure;
subplot(1,2,1);
imagesc(bw);
colormap(gray);
hold on ;
plot(y,x,'g', 'LineWidth', 2);
subplot(1,2,2);
imagesc(i);
colormap(gray);
hold on;
plot(y,x,'g','LineWidth',2);