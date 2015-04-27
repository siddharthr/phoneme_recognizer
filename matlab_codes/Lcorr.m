%% output indexes the channels from least to most correlated
function Idx = Lcorr (a,b)

for chan=1:size(a,1)
    c = xcorr (a(chan,:),b(chan,:)); % all correlation values from chan i
    chanCorr(chan) = sum (c); % sum to one value
end

[B Idx] = sort (chanCorr, 'ascend'); % sort from low to high value

end