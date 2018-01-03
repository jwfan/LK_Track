function [dp_x,dp_y] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [dp_x,dp_y] in the x- and y-directions.

dp_x=0;
dp_y=0;
x1=rect(1);
y1=rect(2);
x2=rect(3);
y2=rect(4);
It=double(It);
It1=double(It1);
Irec=double(It(y1:y2,x1:x2));
W=zeros(size(bases(:,:,1),1)*size(bases(:,:,1),2),size(bases(:,:,1),3));
for i = size(bases,3) % Get the weights
    base = reshape(bases(:,:,i), [size(bases(:,:,i),1)*size(bases(:,:,i),2), 1]);
    W(:,i) = base;
end
B=W*W';
B=eye(size(bases(:,:,1),1)*size(bases(:,:,1),2))-B;
deltap=[Inf Inf];
threshold=0.0001;
while(norm(deltap)>threshold)
    [X,Y]=meshgrid(x1+dp_x:x2+dp_x,y1+dp_y:y2+dp_y);
    InterpI=double(interp2(It1,X,Y));
    [dIx,dIy]=gradient(double(InterpI));
    dI=[reshape(dIx,[],1),reshape(dIy,[],1)];
    dI=B*dI;
    H=dI'*dI;
    Difference=B*reshape(Irec-InterpI,[],1);
    deltap=H\(dI'*Difference);
    dp_x=dp_x+deltap(1);
    dp_y=dp_y+deltap(2);
end

end
