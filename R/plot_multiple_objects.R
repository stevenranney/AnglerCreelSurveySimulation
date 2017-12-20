
plot_multiple_objects <- structure(
function # Plot multiple ggplots in one window

  ##############################################################################
  # File:  PlotMultipleObjects.R
  ##author<<  Steven H. Ranney
  ## Contact: \email{Steven.Ranney@gmail.com}
  # Created: 12/31/14  
  # Last Edited: 12/31/14 by SHR
  ##description<< This function takes multiple \code{\link{ggplot}} objects and 
  ## puts them in one plot window. 
  #
  # TODO: add RData for example
  # TODO: add testing section
  ###############################################################################
  (..., ##<<The plots to include in the window.
  plotlist=NULL, ##<<If a \code{plotlist} exists, it should be included here.
  file, ##<<A plot file
  cols=1, ##<<How many columns should the window have?
  layout=NULL ##<<A matrix specifying the layout. If present, 'cols' is ignored..
  ){
  
  library(grid)
  ##details<< If the layout is something like \code{matrix(c(1,2,3,3), nrow=2, byrow=TRUE)},
  ## then plot 1 will go in the upper left, 2 will go in the upper right, and
  ## 3 will go all the way across the bottom.

  #Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    } #end for loop
  } # end else
})
