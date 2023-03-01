# Matlab-histogram-demo

This script creates a sample of exponentially distributed random numbers, then

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
- sets properties on the figure so that you can save it as a PDF and the file has reasonable margins instead of being a whole page

