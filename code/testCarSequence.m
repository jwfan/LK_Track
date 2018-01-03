% your code here
load("../data/carseq.mat");
rec=[60,117,146,152]';
index=[1,100,200,300,400];
[h,w,i]=size(frames);
carseqrects=zeros(i-1,4);

for j=1:i-1
    It=frames(:,:,j);
    It1=frames(:,:,j+1);
    [dp_x,dp_y] = LucasKanade(It, It1, rec);
    if (rec(1)+dp_x)>=1 && (rec(1)+dp_x)<=w && (rec(3)+dp_x)>=1 && (rec(3)+dp_x)<=w && ...
            (rec(2)+dp_y)>=1 && (rec(2)+dp_y)<=h && (rec(4)+dp_y)>=1 && (rec(4)+dp_y)<=h
       rec=[rec(1)+dp_x rec(2)+dp_y rec(3)+dp_x rec(4)+dp_y];
       rec=round(rec);
       carseqrects(j,:)=rec;
    end
end
save("../results/carseqrects.mat",'carseqrects');

width=abs(rec(1)-rec(3));
height=abs(rec(2)-rec(4));
for j=1:length(index)
    img=frames(:,:,index(j));
    coor=carseqrects(index(j),:);
    fig=figure();
    imshow(img);
    hold on;
    rectangle('Position',[coor(1),coor(2),width,height],'LineWidth',3,'EdgeColor','y');
    hold off;
    s=sprintf('../results/Carseqrects%d.jpg',index(j));
    saveas(gcf,s);
end
close all;