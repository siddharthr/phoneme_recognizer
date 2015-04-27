clc, clear all, close all
%% each dataset is originaly (channel, frames per epoch, epoch)
phonemes = {'po' ; 'pa' ; 'fo' ; 'fa'};

%% load and average datasets epochs - phoneme(chanel,samples avraged from all epochs)
po = loadNavg('po');
pa = loadNavg('pa');
fo = loadNavg('fo');
fa = loadNavg('fa');

%% find least correlated channels between phonemes
%% output indexes the channels from least to most correlated
popa = Lcorr (po,pa);
pofo = Lcorr (po,fo);
pofa = Lcorr (po,fa);
pafo = Lcorr (pa,fo);
pafa = Lcorr (pa,fa);
fofa = Lcorr (fo,fa);

%% get input vector for N least correlated channels
%% IN_ is 0 if channel is more correlated to first phoneme, 1 if more to second phoneme 
%% output(i) = [results channel (i)]
N = 5;
INpopa = loadNcorr (po,'po',pa,'pa', popa(1:N)); % pofo neural network input 
INpofo = loadNcorr (po,'po',fo,'fo', pofo(1:N)); 
INpofa = loadNcorr (po,'po',fa,'fa', pofa(1:N)); 
INpafo = loadNcorr (pa,'pa',fo,'fo', pafo(1:N)); 
INpafa = loadNcorr (pa,'pa',fa,'fa', pafa(1:N)); 
INfofa = loadNcorr (fo,'fo',fa,'fa', fofa(1:N));

%% first half of input is always samples of a, last half is b
%% correct output is 80 zeros representing a, followed by 80 ones
output(1,:) = [zeros(1,length(INpopa)/2) ones(1,length(INpopa)/2)]; % 0 = a correct
output(2,:) = [ones(1,length(INpopa)/2) zeros(1,length(INpopa)/2)]; % 0 = b correct 

nprtool % start matlabs Neural Network Toolbox and create 6 NN