function [chisquare, freedom_degrees, p_value] = chisquare_test(xs, prob_fcn)
    [frequencies, bins] = histcounts(xs, 'BinMethod', 'integers');
    bins = bins(1:end-1) + 0.5;
    
    theory_frequencies = numel(xs) * prob_fcn(bins);
    
    bins = bins(frequencies ~= 0);
    theory_frequencies = theory_frequencies(frequencies ~= 0);
    frequencies = frequencies(frequencies ~= 0);
    
    chisquare = sum(                                                    ...
                    (frequencies - theory_frequencies).^2 ./ frequencies...
                   );
    freedom_degrees = numel(bins) - 1;
               
    [~, p_value, ~] = chi2gof(bins,                      ...
                        'Ctrs',      bins,               ...
                        'Frequency', frequencies,        ...
                        'Expected',  theory_frequencies, ...
                        'NParams',   1);
end

