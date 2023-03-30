% Create a histogram from some random samples

% This is the rate parameter:
lambda = 0.8;
mean_param = 1/lambda;

% Remember that in Matlab, the exponential distribution is specified by its
% mean instead of by its rate parameter.
sample_dist = makedist("Exponential", mu=mean_param);
samples = random(sample_dist, [1, 1000]);

% This generates bin counts automatically, but doesn't make the bar chart.
[counts, bin_edges, bin_index] = histcounts(samples);

% counts(k) is the number of items x in samples for which 
% bin_edges(k) ≤ x < bin_edges(k+1)
% except that the right-most bin includes its right boundary,
% bin_edges(end-1) ≤ x ≤ bin_edges(end).

% bin_index(j) is the index of the bin k to which samples(j) belongs.

% You can pass other information to histcounts.
% For example, you can pass in the bin edges to use,
% a uniform width to use for all bins,
% or specify how many bins.

% Here's how to get a histogram picture with theoretical values
% superimposed

% This is the theoretical CDF
F = @(x) 1 - exp(-lambda*x);

% Note that if we apply F to an input array, the output is an array of the
% same size whose entries are F applied to the corresponding entry in the
% input array.

% Tell Matlab to apply multiple plotting commands to the current figure.
hold on;

% Create the histogram picture.
% The histogram object has fields, and you can set them to 
% your desired values and use them for other things.
% The picture and histogram data are automatically updated when you change
% settable fields.

% Here we start with a vanilla, automatic histogram:
h = histogram(samples);
% Specify that all bins are this width:
h.BinWidth = 0.5;
% And set it to make the height of each bar be the fraction of samples in
% the bin, rather than the count of samples in the bin:
h.Normalization = 'probability';



% For a theoretical estimate of the fraction of samples in a bin, use the
% difference in the CDF values at the boundaries:
%
% Prob(a_k ≤ x < a_{k+1}) = CDF(a_{k+1}) - CDF(a_{k}).
%
% We'll use those estimates as y-values:
y_values = F(h.BinEdges(2:end)) - F(h.BinEdges(1:end-1));

% We'll use the middle of each bin as the corresponding x-value:
x_values = (h.BinEdges(1:end-1) + h.BinEdges(2:end))/2;

% Plot a red disk with a black outline for each bar in the histogram.
plot(x_values, y_values, 'o', ...
    'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');



% Alternatively, we could use the PDF, f = F' and use the mean value
% theorem, resulting in
% Prob(x in bin) approx = f(center of bin) * bin width
f = @(x) exp(-lambda * x) * lambda;
y2_values = f(x_values) * h.BinWidth;

% We'll plot these with a green line
plot(x_values, y2_values, 'LineWidth', 2, 'Color', 'g');

% This sets some paper-related properties of the figure so that you can
% save it as a PDF and it doesn't fill a whole page.
% gcf is "get current figure handle"
% See https://stackoverflow.com/a/18868933/2407278
fig = gcf;
fig.Units = 'inches';
screenposition = fig.Position;
fig.PaperPosition = [0 0 screenposition(3:4)];
fig.PaperSize = [screenposition(3:4)];