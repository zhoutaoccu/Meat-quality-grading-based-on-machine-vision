function [ rima ] = noise( img,sigma )
%noise add noise to a photo.

if size(img,3) > 1
    ima = rgb2gray(img);
end
ima=double(ima);
rima=ima+sigma*randn(size(ima));

end

