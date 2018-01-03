% your code here
load("../data/sylvseq.mat");
load("../data/sylvbases.mat");
rec=[102,62,156,108]';
rec_basis=[102,62,156,108]';
index=[1,100,200,300,400];
[h,w,i]=size(frames);
sylvseqrects=zeros(i-1,4);

width=abs(rec(1)-rec(3));
height=abs(rec(2)-rec(4));
xx=1;

for j=1:i-1
    It=frames(:,:,j);
    It1=frames(:,:,j+1);
    imshow(It);
    hold on;
    rectangle('Position',[rec(1),rec(2),width,height], 'LineWidth',3, 'EdgeColor', 'g');
    rectangle('Position',[rec_basis(1),rec_basis(2),width,height], 'LineWidth',2, 'EdgeColor', 'y');
    hold off;
    pause(0.01);
    if any(j==index)
        s=sprintf('../results/sylvseqrects%d.jpg',index(xx));
        xx=xx+1;
        saveas(gcf,s);
    end
    [dp_x,dp_y] = LucasKanade(It, It1, rec);
    if (rec(1)+dp_x)>=1 && (rec(1)+dp_x)<=w && (rec(3)+dp_x)>=1 && (rec(3)+dp_x)<=w && ...
            (rec(2)+dp_y)>=1 && (rec(2)+dp_y)<=h && (rec(4)+dp_y)>=1 && (rec(4)+dp_y)<=h
       rec=[rec(1)+dp_x rec(2)+dp_y rec(3)+dp_x rec(4)+dp_y];
       rec=round(rec);
    end
     [dp_x,dp_y] = LucasKanadeBasis(It, It1, rec,bases);
    if (rec_basis(1)+dp_x)>=1 && (rec_basis(1)+dp_x)<=w && (rec_basis(3)+dp_x)>=1 && (rec_basis(3)+dp_x)<=w && ...
            (rec_basis(2)+dp_y)>=1 && (rec_basis(2)+dp_y)<=h && (rec_basis(4)+dp_y)>=1 && (rec_basis(4)+dp_y)<=h
       rec_basis=[rec_basis(1)+dp_x rec_basis(2)+dp_y rec_basis(3)+dp_x rec_basis(4)+dp_y];
       rec_basis=round(rec_basis);
       sylvseqrects(j,:)=rec;
    end
end
save("../results/sylvseqrects.mat",'sylvseqrects');
close all;
