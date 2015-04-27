%% loads eeg data sets and correlates N channels with 2 phonemes
%% each dataset is (channel, frames per epoch, epoch)
%% output is 0 if channel is more correlated to a phoneme, 1 if more to b phoneme 
%% output(i) = [results channel(i)]
function IN = loadNcorr (aRef,aName,bRef,bName, channels)
 
INa = []; % input for a
%%compare to a
for i=1:4 % 4 datasets
    filename = [aName num2str(i) '.mat'];
    load (filename)
    data = EEG.data;
%% get channel correlation to aRef and bRef    
    for chan = 1:length(channels) % for all appropriate channels
        for epoch = 1: size(data,3)
            corrA = xcorr(data(channels(chan),:,epoch),aRef(chan,:)); % correlation with a
            corrB = xcorr(data(channels(chan),:,epoch),bRef(chan,:)); % correlation with b
            
            if sum(corrA)>sum(corrB) % more correlated to a
                temp(chan,epoch) = 0;
            else
                temp(chan,epoch) = 1;
            end
        end
    end
 INa = [INa temp];        
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SAME FOR B

INb = []; % input for b
temp =[];
%%compare to a
for i=1:4 % 4 datasets
    filename = [aName num2str(i) '.mat'];
    load (filename)
    data = EEG.data;
%% get channel correlation to aRef and bRef    
    for chan = 1:length(channels) % for all appropriate channels
        for epoch = 1: size(data,3)
            corrA = xcorr(data(channels(chan),:,epoch),aRef(chan,:)); % correlation with a
            corrB = xcorr(data(channels(chan),:,epoch),bRef(chan,:)); % correlation with b
            
            if sum(corrA)>sum(corrB) % more correlated to a
                temp(chan,epoch) = 0;
            else
                temp(chan,epoch) = 1;
            end
        end
    end
 INb = [INb temp];        
end


IN = [INa INb];
end