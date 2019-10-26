function [chisquare, freedom_degrees] = chisquare_test(xs, prob_fcn)
    n   = numel(xs);
    uns = sort(unique(xs));
    counts  = histcounts(xs, [uns, uns(end) + 1]);
   
    theorys = prob_fcn(uns);
    
    chisquare = n * sum(                               ...
                    (counts/n - theorys).^2 ./ theorys ...
                   );
    freedom_degrees = uns(end) - 1;
end

