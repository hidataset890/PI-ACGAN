function pyr = gaussian_pyramid(I,nlev)

r = size(I,1);
c = size(I,2);

if ~exist('nlev')
    %compute the highest possible pyramid
    nlev = floor(log(min(r,c)) / log(2));
end

% start by copying the image to the finest level
pyr = cell(nlev,1);
pyr{1} = I;

% recursively downsample the image
filter = pyramid_filter;
%figure('Name','gaussian_pyramid');
for l = 2:nlev
    I = downsample(I,filter);
    pyr{l} = I;
    
    %subplot(2,2,l); imshow(I);
end