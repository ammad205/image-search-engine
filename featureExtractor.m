function [ temp ] = featureExtractor(name)

img = double(imread(name));
    [x y z] = size(img);
    temp = zeros(1,32*9*3);
    for i = 1:z           % for the colors
        for j = 1:y
            n = 3*floor((j-1)/ceil(y/3));
            for k = 1:x
                m = floor((k-1)/ceil(x/3));
                temp(ceil((img(k,j,i) + 1)/8) + (i-1)*9*32 + (m+n)*32) = temp(ceil((img(k,j,i) + 1)/8) + (i-1)*9*32 + (m+n)*32) + 1;
            end    
        end    
    end
    
    for t=1:27
        temp((t-1)*32+1:t*32) = temp((t-1)*32+1:t*32)/max(temp((t-1)*32+1:t*32));
    end    
end

