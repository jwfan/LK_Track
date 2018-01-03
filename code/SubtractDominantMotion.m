function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size
M=LucasKanadeAffine(image1,image2);
i1=warpH(image1, M, [size(image1,1), size(image1,2)]);
diff=image2-i1;
mask=double(diff > 25 & diff < 256);
se = strel('disk', 6);
mask = imdilate(mask, se);
se = strel('disk', 2);
mask = imerode(mask, se);
%[r,c]=find(mask);
mask=bwareaopen(mask,200);
%mask=bwselect(mask,r,c,26);

end