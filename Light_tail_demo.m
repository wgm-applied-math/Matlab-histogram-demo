%% Demo of light-tail statistics
% This script creates a bunch of sample sets drawn from a normal
% distribution.  It then computes the maximum, the 90th percentile, and
% median of each set.  Those are then binned and plotted as histograms.
% That shows that the maximum of any given sample has a somewhat spread-out
% distribution, while the 90th percentile and the median are concentrated.

% This is the rate parameter used in Heavy_tail_demo.m
lambda = 0.8;
mean_param = 1/lambda;

% Set the random number generator seed.
% This causes MATLAB to use the same sequence of pseudo-random numbers each
% time this script is run.
rng(2024);

% This time we use a normal distribution with the same mean and standard
% deviation as the exponential distribution used in Heavy_tail_demo.m.
sample_dist = makedist("Normal", mu=mean_param, sigma=mean_param);

% Produce a random array of 50 rows and 2000 columns.
% These are interpreted as 2000 samples, with 50 values in each sample.
base_samples = random(sample_dist, [50, 2000]);

% Compute statistics for each of the 2000 samples.
% These functions treat each column of the base_samples array as a separate
% sample.  The result of each is an array with one row and a column for
% each column in base_samples.
max_samples = max(base_samples);
q90_samples = quantile(base_samples, 0.9);
med_samples = quantile(base_samples, 0.5);

% Make a figure object with one set of axes.
fig = figure();
t = tiledlayout(fig,1,1);
ax = nexttile(t);

% Set the axes to hold so we can plot several histograms at the same time.
hold(ax, "on");

% Create the histograms.
histogram(ax, max_samples, BinWidth=0.25);
histogram(ax, q90_samples, BinWidth=0.25);
histogram(ax, med_samples, BinWidth=0.25);

% Set titles
title(ax, "Distributions of sample statistics");
xlabel(ax, "time");
ylabel(ax, "count");

% Fix axes ranges
xlim(ax, [-0.5, 8]);
ylim(ax, [0, 1000]);

% Make a legend.
% The strings are used to label the plotted data sets in order.
legend(ax, "max", "90%", "median");

% Pause for a moment to let MATLAB's picture renderer catch up
pause(2);

% Save the picture as a PDF file
exportgraphics(fig, "Histogram of sample statistics of the normal distribution.pdf");