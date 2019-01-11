function S_num = getSessionsNumbers(S)
    % Transform Sessions dates into numbers
    
    S_num = zeros(size(S));       
    % transform session info into a number
    for k = 1:numel(S)
        parts = strsplit(S{k},'_');
        if numel(parts) == 1
            parts = strsplit(S{k},'/');
        end                            
        numstr = [parts{1},parts{2},parts{3}];
        S_num(k) = str2num(numstr);
    end
end