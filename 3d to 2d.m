[rt,diff]=mat()
function [rt,diff]=mat()
rows=input('Enter no. of rows')
columns=input('column')
for i=1:rows
for j=1:columns
a(i,j)=input('Enter elements:')
end
end
a=reshape(a,rows,columns)
    function rotationMatrix=myrotz_cc()
        ang=0.785398; %angle in radian
        r=[cos(ang),sin(ang),0;-sin(ang),cos(ang),0;0,0,1];
        rotationMatrix=r
        rt=a*r;
        b1=rt(:,[3]);
        c1=((rt./b1));
        cam1=c1(:,[1,2]);
        d1=mean(rt(:,[3]));
        w1=rt./d1;
        w2=w1(:,[1,2]);
        xc1=cam1(:,1);
        yc1=cam1(:,2);
        k=w2(:,1);
        j=w2(:,2);
        figure
        plot(xc1,yc1,'-ro',k, j,'-*b','Markersize',10) %Task 3
        hleg1=legend('Cordinate Perspective Camera Projection','Weak Perspective Camera Projection');%Task 3
        xlabel('X');%Task 3
        ylabel('Y');%Task 3
        title('3D Point to 2D POint on Respect to Cordinate and weak camera projection');%Task 3
        diff=sum(sum(abs(c1-w1)))
    end
myrotz_cc()
end