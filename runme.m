
close all;
clear all;
clc;

%%      Comparison of Images        %%

imagename = 'images\0.jpg';
similaritymeasure = 3;   % '1' for sum of absolute differences % '2' for euclidian distances % '3' for cosine similarity
files = dir('images');
database = dlmread('database');
%filesnames = dlmread('filenames','\n');

features = featureExtractor('images\0.jpg');

difference = [];
diffsumm = [];
cosine=[];
for i = 1:length(database) 
difference = [difference;abs(database(i,:) - features)];
cosine = [cosine dot(database(i,:),features)/(norm(database(i,:))*norm(features))]; 
%squar=difference
%summ = [summ;sum(difference(i,:))];
end


squaresum = sum((difference.^2)');

%% three similarity criterions %%

diffsumm = sum(difference');    % sum of absolute differences 
rootsum = sqrt(squaresum);      % euclidian distances
cosine;                         % cosine similarity (which is the best one)

if(similaritymeasure == 1)
    selection = diffsumm;
elseif(similaritymeasure == 2)
    selection = rootsum;
elseif(similaritymeasure == 3)
    selection = cosine;
end    

%% sorting the data  %%

for p = 1:length(files)-1
  for q = p+1:length(files)
      if(selection(q)<selection(p))
         temp = selection(p);
         selection(p) = selection(q);
         selection(q) = temp;
         ftemp = files(p+2);
         files(p+2) = files(q+2);
         files(q+2) = ftemp;
      end
  end
end

if(similaritymeasure==3)
   files=files(end:-1:3);
end

%% displaying the subplots
n=2*(similaritymeasure~=3);
for i=0:length(files)
img=imread(strcat('images\',files(i+1+n).name));
subplot(3,3,mod(i,9)+1),imshow(img);
pause(0.3);
end

