
setwd("C:/Users/upasanad/OneDrive - Kansas State University/KSU/literature related to project/data files/Rcircos/new input files")
getwd()
library(readxl)
library(RCircos)

#23468
df <- read_excel("CirclePlot_data.xlsx", sheet= "23522")
id <- read_excel("ideograph.xlsx", sheet= "23522")


df1 <- subset(df, select = c(1,2,3,4,19))
df2 <- subset(df, select = c(1,2,3,5,20))
df3 <- subset(df, select = c(1,2,3,6,19))
df4 <- subset(df, select = c(1,2,3,7,20))
df5 <- subset(df, select = c(1,2,3,8,19))
df6 <- subset(df, select = c(1,2,3,9,19))
df7 <- subset(df, select = c(1,2,3,10,20))
df8 <- subset(df, select = c(1,2,3,12,20))
df9 <- subset(df, select = c(1,2,3,13,19))
df10 <- subset(df, select = c(1,2,3,14,20))
df11 <- subset(df, select = c(16, 17, 18,19))
df12<-df11[complete.cases(df11), ]



df1 <- as.data.frame(df1)
df2 <- as.data.frame(df2)
df3 <- as.data.frame(df3)
df4 <- as.data.frame(df4)
df5 <- as.data.frame(df5)
df6 <- as.data.frame(df6)
df7 <- as.data.frame(df7)
df8 <- as.data.frame(df8)
df9 <- as.data.frame(df9)
df10 <- as.data.frame(df10)
df12 <- as.data.frame(df12)


RCircos.Set.Core.Components(cyto.info=id, chr.exclude=NULL,tracks.inside=0,tracks.outside=11)
                            
RCircos.Set.Plot.Area()
RCircos.Chromosome.Ideogram.Plot()

rcircos.params <- RCircos.Get.Plot.Parameters()
rcircos.params$base.per.unit <- 50000
rcircos.params$chrom.paddings <- 300
rcircos.params$hist.width <- 1
rcircos.params$chrom.width <- 0.02
rcircos.params$track.background <- "white"
rcircos.params$grid.line.color <- "grey"
#rcircos.params$hist.color <- "blue"
rcircos.params$track.out.start <- .1
rcircos.params$chr.name.pos <- 1.3
RCircos.Reset.Plot.Parameters(rcircos.params)

RCircos.Set.Plot.Area()
RCircos.Chromosome.Ideogram.Plot()

RCircos.Histogram.Plot(df9,track.num = 1, side = 'out')
RCircos.Histogram.Plot(df10,track.num = 2, side = 'out')
RCircos.Histogram.Plot(df6,track.num = 3, side = 'out')
RCircos.Histogram.Plot(df7,track.num = 4, side = 'out')
RCircos.Histogram.Plot(df1,track.num = 5, side = 'out')
RCircos.Histogram.Plot(df2,track.num = 6, side = 'out')
RCircos.Histogram.Plot(df3,track.num = 7, side = 'out')
RCircos.Histogram.Plot(df4,track.num = 8, side = 'out')
RCircos.Histogram.Plot(df5,track.num = 9, side = 'out')
RCircos.Histogram.Plot(df8,track.num = 10, side = 'out')
RCircos.Tile.Plot(df12,track.num=12,side='out')

#cs3005
df <- read_excel("CirclePlot_data.xlsx", sheet= "cml3066")
id <- read_excel("ideograph.xlsx", sheet= "cml3066")


df1 <- subset(df, select = c(1,2,3,4,17))
df2 <- subset(df, select = c(1,2,3,5,18))
df3 <- subset(df, select = c(1,2,3,6,17))
df4 <- subset(df, select = c(1,2,3,7,18))
df5 <- subset(df, select = c(1,2,3,8,17))
df6 <- subset(df, select = c(1,2,3,9,17))
df7 <- subset(df, select = c(1,2,3,10,18))
df8 <- subset(df, select = c(1,2,3,11,17))
df9 <- subset(df, select = c(1,2,3,12,18))
df11 <- subset(df, select = c(14, 15, 16,17))
df12<-df11[complete.cases(df11), ]



df1 <- as.data.frame(df1)
df2 <- as.data.frame(df2)
df3 <- as.data.frame(df3)
df4 <- as.data.frame(df4)
df5 <- as.data.frame(df5)
df6 <- as.data.frame(df6)
df7 <- as.data.frame(df7)
df8 <- as.data.frame(df8)
df9 <- as.data.frame(df9)
df12 <- as.data.frame(df12)


RCircos.Set.Core.Components(cyto.info=id, chr.exclude=NULL,tracks.inside=0,tracks.outside=11)

RCircos.Set.Plot.Area()
RCircos.Chromosome.Ideogram.Plot()

rcircos.params <- RCircos.Get.Plot.Parameters()
rcircos.params$base.per.unit <- 50000
rcircos.params$chrom.paddings <- 300
rcircos.params$hist.width <- 1
rcircos.params$chrom.width <- 0.02
rcircos.params$track.background <- "white"
rcircos.params$grid.line.color <- "grey"
#rcircos.params$hist.color <- "blue"
rcircos.params$track.out.start <- .1
rcircos.params$chr.name.pos <- 1.3
RCircos.Reset.Plot.Parameters(rcircos.params)

RCircos.Set.Plot.Area()
RCircos.Chromosome.Ideogram.Plot()

RCircos.Histogram.Plot(df8,track.num = 1, side = 'out')
RCircos.Histogram.Plot(df9,track.num = 2, side = 'out')
RCircos.Histogram.Plot(df6,track.num = 3, side = 'out')
RCircos.Histogram.Plot(df7,track.num = 4, side = 'out')
RCircos.Histogram.Plot(df1,track.num = 5, side = 'out')
RCircos.Histogram.Plot(df2,track.num = 6, side = 'out')
RCircos.Histogram.Plot(df3,track.num = 7, side = 'out')
RCircos.Histogram.Plot(df4,track.num = 8, side = 'out')
RCircos.Histogram.Plot(df5,track.num = 9, side = 'out')
RCircos.Tile.Plot(df12,track.num=12,side='out')
 
View(df3)
