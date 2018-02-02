%function intraPdc(img)

%intraPdc            Read the image and do further work
%img                 image for processing
%Author              Cihan
%Date                2017.9.21
%Version             V1.0


% Have user browse for a file, from a specified "starting folder."
% For convenience in browsing, set a starting folder from which to browse.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%startingFolder = ('C:\Users\math\Desktop\Lena Test1');
%if ~exist(startingFolder, 'dir')
	% If that folder doesn't exist, just start in the current folder.
%	startingFolder = pwd;
%end
%% Get the name of the file that the user wants to use.
%defaultFileName = fullfile(startingFolder, '*.png');
%[baseFileName, folder] = uigetfile(defaultFileName,'Select the target image file');
%if baseFileName == 0
%	% User clicked the Cancel button.
%    disp('User selected Cancel')
%    return;
%else
%   disp(['User selected ', fullfile(folder, baseFileName)])
%end
%img = fullfile(folder, baseFileName)


%data = imread(img);

%%
data= imread('C:\Users\math\Desktop\Lena Test1\lena.png');
csvwrite('origindata.txt',data)
subplot(321)
imshow(data);
title('Original Image');
gdata = rgb2gray(data);
csvwrite('greydata.txt',gdata)
subplot(322)
imshow(gdata)
title('Luma Image');
ndata = double(gdata)/255;
csvwrite('normaldata.txt',ndata)
subplot(323)
imshow(ndata)
title('Normalized');

zdata=roundn(ndata,0);
csvwrite('zero-one-data.txt',zdata)
subplot(324)
imshow(zdata)
title('0-1 format Matrix')

%sqtdata = qtdecomp(zdata,0);
%disp(full(sqtdata));
%csvwrite('sqt.txt',sqtdata)

rdata = ndata-zdata;
csvwrite('residualdata.txt',rdata)
subplot (325)
imshow(rdata)
title('Residual Matrix')

dctr=dct(rdata);
csvwrite('DCT.txt',dctr)
subplot (326)
hb=bar3(dctr);
shading interp
for j=1:length(hb)
    zdata=get(hb(j),'Zdata');
    set(hb(j),'Cdata',zdata)
end
title('DCT Matrix')



