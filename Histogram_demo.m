%% Create a histogram from some random samples

% This is the rate parameter:
lambda = 0.8;
mean_param = 1/lambda;

% In MATLAB, the exponential distribution is specified by its
% mean instead of by its rate parameter.
sample_dist = makedist("Exponential", mu=mean_param);

% Set the random number generator seed.
% This causes MATLAB to use the same sequence of pseudo-random numbers each
% time this script is run.
rng(2024);

% Make an array of random numbers sampled from that distribution.
% It's one row by 1000 columns.
samples = random(sample_dist, [1, 1000]);

% In case you need the bins but not the actual chart,
% histcounts generates bin counts automatically,
% but doesn't draw anything.
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

%% Histogram with theoretical values superimposed

% Note that if we apply F to an input array, the output is an array of the
% same size whose entries are F applied to the corresponding entry in the
% input array.

% Make a figure object with one set of axes.
fig = figure();
t = tiledlayout(fig,1,1);
ax = nexttile(t);

% Set the axes to "hold", meaning plot several pieces of data
% superimposed. Without this, each charting command would replace the
% contents of the axes.
hold(ax, "on");

% Put some labels on the axes.
title(ax, "Histogram of inter-arrival times");
xlabel(ax, "time");
ylabel(ax, "probability");

% Set ranges on the axes.
% You can let MATLAB choose these automatically, but if you want ranges
% that are the same on several plots, you might have to set them manually.
xlim(ax, [-0.5, 6]);
ylim(ax, [0, 0.4]);

% Create the histogram picture.
% The histogram object has fields, and you can set them to 
% your desired values and use them for other things.
% The picture and histogram data are automatically updated when you change
% settable fields.

% Draw a histogram.
% BinWidth=0.5 means that all bins are 0.5 units wide
% Normalization="probability" means that the bar height is the fraction of
% samples that land in the bin, rather than the count of samples.
h = histogram(ax, samples, BinWidth=0.5, Normalization="probability");

% For a theoretical estimate of the fraction of samples in a bin, use the
% difference in the CDF values at the boundaries:
%
% Prob(a_k ≤ x < a_{k+1}) = CDF(a_{k+1}) - CDF(a_{k}).
%
% This is the theoretical CDF:
F = @(x) 1 - exp(-lambda*x);

% We'll use these estimates as y-values:
y_values = F(h.BinEdges(2:end)) - F(h.BinEdges(1:end-1));

% We'll use the middle of each bin as the corresponding x-value:
x_values = (h.BinEdges(1:end-1) + h.BinEdges(2:end))/2;

% Plot a red disk with a black outline for each bar in the histogram.
% The "o" means the marker is a disk.
% MarkerFaceColor="r" means fill the interior with red
% MarkerEdgeColor="k" means draw the outline in black
plot(ax, x_values, y_values, "o", ...
    MarkerFaceColor="r", MarkerEdgeColor="k");



% Alternatively, we could use the PDF, f = F', for theoretical values.
% The mean value theorem, results in
% Prob(x in bin) approx = f(center of bin) * bin width
f = @(x) exp(-lambda * x) * lambda;
y2_values = f(x_values) * h.BinWidth;

% We'll plot these with a green line of width 2.
plot(ax, x_values, y2_values, LineWidth=2, Color="g");

% Pause for a moment to let MATLAB's picture renderer catch up
pause(2);

% Save the picture as a PDF file
exportgraphics(fig, "Example histogram.pdf");