
# Created 12/31/14

#' Plot multiple ggplots in one window
#' 
#' @author Steven H. Ranney
#' 
#' @description This function takes multiple \code{\link{ggplot}} objects and 
#' puts them in one plot window.
#' 
#' @param ... The plots to include in the window
#' @param plotlist If a \code{plotlist} exists, it should be included here
#' @param file A plot file
#' @param cols How many columns should the window have?
#' @param layout A matrix specifying the layout. If present, \code{cols} is ignored.
#' 
#' @details If the layout is something like \code{matrix(c(1,2,3,3), nrow=2, byrow=TRUE)},
#' then plot 1 will go in the upper left, 2 will go in the upper right, and
#' 3 will go all the way across the bottom.
#' 
#' @export


library(grid)

plot_multiple_objects <- function(..., plotlist=NULL, file, cols=1, layout=NULL){
  

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
}
