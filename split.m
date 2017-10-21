originMatrix=load('C:\Users\SCU\Documents\MATLAB\zero-one-data.txt');

cNo=size(originMatrix,1);  % How many rows 
rNo=size(originMatrix,2);  % How many columns
squareSize = min([rNo cNo]);    %Set the size of target matix - should be square
p = nextpow2(squareSize);
sizeA=2.^p;
targetMatrix=originMatrix(1:sizeA, 1:sizeA); %Ready for splitting

subA0=targetMatrix(1:sizeA/2,1:sizeA/2);
subA1=targetMatrix(1:sizeA/2,sizeA/2+1:sizeA);
subA2=targetMatrix(sizeA/2+1:sizeA,1:sizeA/2);
subA3=targetMatrix(sizeA/2+1:sizeA,sizeA/2+1:sizeA);

%% Shown
subplot(2,3,1)
imshow(targetMatrix);
title('Ready for splitting')

subplot(2,3,2)
imshow(subA0);
title('subA0')

subplot(2,3,3)
imshow(subA1);
title('subA1')

subplot(2,3,4)
imshow(subA2);
title('subA2')

subplot(2,3,5)
imshow(subA3);
title('subA3')


%% Comparision
cmp=isequal(subA0,subA1,subA2,subA3);
if cmp = 1:
    

