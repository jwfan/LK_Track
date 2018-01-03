% your code here
load("../data/carseq.mat");
rec=[60,117,146,152]';
index=[30,60,90,120];
[h,w,i]=size(frames);
carseqrects=zeros(i,4);
carseqrects(1,:)=rec;
width=abs(rec(1)-rec(3));
height=abs(rec(2)-rec(4));
x1=rec(1);
y1=rec(2);
x2=rec(3);
y2=rec(4);
T=frames(:,:,1);
T=double(T(y1:y2,x1:x2));
for j=2:i
    It1=frames(:,:,j);
    [dp_x,dp_y] = LucasKanadeWithTemplateCorrection(T, It1, carseqrects(j-1,:));
    if (rec(1)+dp_x)>=1 && (rec(1)+dp_x)<=w && (rec(3)+dp_x)>=1 && (rec(3)+dp_x)<=w && ...
            (rec(2)+dp_y)>=1 && (rec(2)+dp_y)<=h && (rec(4)+dp_y)>=1 && (rec(4)+dp_y)<=h
       rec=[rec(1)+dp_x rec(2)+dp_y rec(3)+dp_x rec(4)+dp_y];
       rec=round(rec);
       carseqrects(j,:)=rec;
    end
end
save("../results/carseqrects-wcrt.mat",'carseqrects');

for j=1:length(index)
    img=frames(:,:,index(j));
    coor=carseqrects(index(j),:);
    fig=figure();
    imshow(img);
    hold on;
    rectangle('Position',[coor(1),coor(2),width,height],'LineWidth',3,'EdgeColor','y');
    hold off;
    s=sprintf('../results/Carseqrectswithtemplatecorrection%d.jpg',index(j));
    saveas(gcf,s);
end
close all;