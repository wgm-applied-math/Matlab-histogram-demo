%% Demo of heavy-tail statistics
% This script creates a bunch of many sample sets drawn from an exponential
% distribution.  It then computes the maximum, the 90th percentile, and
% median of each set.  Those are then binned and plotted as histograms.
% That shows that the maximum of any given sample has a very spread-out
% distribution, while the 90th percentile is confined, and the median is
% very concentrated.

% This is the rate parameter:
lambda = 0.8;
mean_param = 1/lambda;

% Remember that in Matlab, the exponential distribution is specified by its
% mean instead of by its rate parameter.
sample_dist = makedist("Exponential", mu=mean_param);
base_samples = random(sample_dist, [50, 2000]);
max_samples = max(base_samples);
q90_samples = quantile(base_samples, 0.9);
med_samples = quantile(base_samples, 0.5);
% mean_samples = mean(base_samples);

% Here's how to get a histogram picture with theoretical values
% superimposed

% This is the theoretical CDF
F = @(x) 1 - exp(-lambda*x);

% Note that if we apply F to an input array, the output is an array of the
% same size whose entries are F applied to the corresponding entry in the
% input array.

% Tell Matlab to apply multiple plotting commands to the current figure.
hold on;

% Create the histograms.

histogram(max_samples, BinWidth=0.25);
histogram(q90_samples, BinWidth=0.25);
histogram(med_samples, BinWidth=0.25);
% histogram(mean_samples, BinWidth=0.25);

% This sets some paper-related properties of the figure so that you can
% save it as a PDF and it doesn't fill a whole page.
% gcf is "get current figure handle"
% See https://stackoverflow.com/a/18868933/2407278
fig = gcf;
fig.Units = 'inches';
screenposition = fig.Position;
fig.PaperPosition = [0 0 screenposition(3:4)];
fig.PaperSize = [screenposition(3:4)];