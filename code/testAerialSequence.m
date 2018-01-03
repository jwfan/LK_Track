% your code here
load("../data/aerialseq.mat");
index=[30,60,90,120];

[h,w,i]=size(frames);
aerialseqrects=zeros(h,w,i-1);
xx=1;
for j=1:i-1
    It=frames(:,:,j);
    It1=frames(:,:,j+1);
    mask=SubtractDominantMotion(It,It1);
    aerialseqrects(:,:,j)=mask(:,:);
    color=zeros(h,w,3);
    color(:,:,2)=0.5;
    img=imfuse(It,color,'blend','Scaling', 'joint');
    color=zeros(h,w,3);
    color(:,:,1)=mask(:,:)*255;
    img=imfuse(img,color,'blend','Scaling', 'joint');
    imshow(img);
    if any(j==index)
        s=sprintf('../results/aerialseqrects%d.jpg',index(xx));
        xx=xx+1;
        saveas(gcf,s);
    end
end
close all;
save("../results/aerialseqrects.mat",'aerialseqrects');