# Matlab-histogram-demo

## `Histogram_demo.m`

This script does the following:

- sets the seed for the random number generator so that the script produces exactly the same output every time
- creates a sample of exponentially distributed random numbers
- demonstrates how to do some histogram calculations with `histcounts`
- creates a histogram figure
- sets binning and scaling parameters for the histogram
- uses the CDF to give a theoretical height for each bar as a function of its bin's left and right boundaries ("edges" in Matlab jargon)
- uses the PDF with a one-term-midpoint approximation to give a theoretical size for bars (which doesn't work well unless the bins are relatively narrow)
- overlays the histogram with the two sets of theoretical results

Along the way, the script

- uses the `hold` command to enable multiple things to be drawn on the same figure
- includes some plot styling options
- uses the `@` syntax for a function defined by a short formula
- uses `exporgraphics` to save the figure to a PDF file, using `pause` so that the figure object is (hopefully) up-to-date when the saving happens

## `Heavy_tail_demo.m`

This script does the following:

- sets the seed for the random number generator so that the script produces exactly the same output every time
- creates many samples of exponentially distributed random numbers
- computes the maximum, 90th percentile, and median of each sample
- superimposes histograms of those statistics over all the samples

Along the way, the script

- uses the `hold` command to enable multiple things to be drawn on the same figure
- makes a legend
- uses `exporgraphics` to save the figure to a PDF file, using `pause` so that the figure object is (hopefully) up-to-date when the saving happens

## `Light_tail_demo.m`

This script does the same as `Heavy_tail_demo.m` but using a normal distribution for the random numbers.
