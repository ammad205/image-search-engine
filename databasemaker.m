close all;
clear all;
clc;

%%      Database Making     %%

files=dir('images');

database=[];
filenames='';

for q=3:length(files)
    tic
    database = [database;featureExtractor(strcat('images\',files(q).name))];
    filenames = strvcat(filenames,files(q).name);
    toc
end

dlmwrite('database',database);
dlmwrite('filesnames',files);
