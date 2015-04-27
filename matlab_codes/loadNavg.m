%% loads eeg data sets and averages over epochs
%% each dataset is (channel, frames per epoch, epoch)
%% output is (channel, samples avraged from all epochs)
function avgEpochs = loadNavg(phoneme)

avgFiles = []; % average of 4 files

for i=1:4 % 4 datasets
    filename = [phoneme num2str(i) '.mat'];
    load (filename)
    data = EEG.data;
    if i==1 % get first dataset  
        avgFiles = data; % get data
    else
        avgFiles = avgFiles + data; % averages 4 files 
    end    
end

avgFiles = avgFiles/4;

%% avg epochs
avgEpochs = zeros (size(avgFiles,1),size(avgFiles,2)); % average of all epochs variable

for chan = 1:size(avgFiles,1) % sum all epochs
    for epoch = 1: size(avgFiles,3)
        avgEpochs(chan,:) = avgEpochs(chan,:) + avgFiles(chan,:,epoch);
    end
end

avgEpochs = avgEpochs/size(avgFiles,3); % average
end