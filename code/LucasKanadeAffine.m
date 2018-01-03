function M = LucasKanadeAffine(It, It1)
% input - image at time t, image at t+1 
% output - M affine transformation matrix
p = zeros(6,1);
threshlod = 0.0001;
It =double(It>127);
It1 =double(It1>127);
Irec=double(reshape(It1,[],1));
[w,h] = size(It);
[X,Y] = meshgrid(1:h,1:w);
X=reshape(X,[],1);
Y=reshape(Y,[],1);
deltap=Inf;
while(norm(deltap) > threshlod)
    M = [1+p(1),p(2),p(3); p(4),1+p(5),p(6); 0,0,1];
    InterpI=warpH(It, M, [size(It1,1), size(It1,2)]);
    [dIx,dIy]=gradient(double(InterpI));
    dIx = reshape(dIx,[],1);
    dIy = reshape(dIy,[],1);
    InterpI=reshape(InterpI,[],1);
    Difference=Irec-InterpI; 
    dI=[X.*dIx Y.*dIx dIx X.*dIy Y.*dIy dIy];
    H=dI'*dI;
    deltap=-H\(dI'*Difference);
    p = p + deltap; 
end
end

