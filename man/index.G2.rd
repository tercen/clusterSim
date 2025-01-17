\name{index.G2}
\alias{index.G2}
\title{Calculates G2 internal cluster quality index}
\description{Calculates G2 internal cluster quality index - Baker & Hubert adaptation of Goodman & Kruskal's Gamma statistic}
\usage{index.G2(d,cl)}
\arguments{
\item{d}{'dist' object}
\item{cl}{A vector of integers indicating the cluster to which each object is allocated}
}
\details{
See file \$R\_HOME\\library\\clusterSim\\pdf\\indexG2\_details.pdf for further details
}
\value{
calculated G2 index
}
\author{
Marek Walesiak \email{marek.walesiak@ue.wroc.pl}, Andrzej Dudek \email{andrzej.dudek@ue.wroc.pl} 

Department of Econometrics and Computer Science, University of Economics, Wroclaw, Poland \url{http://keii.ue.wroc.pl/clusterSim}
}
\references{
Everitt, B.S., Landau, E., Leese, M. (2001), \emph{Cluster analysis}, Arnold, London, p. 104. ISBN 9780340761199.

Gatnar, E., Walesiak, M. (Eds.) (2004), \emph{Metody statystycznej analizy wielowymiarowej w badaniach marketingowych [Multivariate statistical analysis methods in marketing research]}, Wydawnictwo AE, Wroclaw, p. 339. Available at: \url{http://keii.ue.wroc.pl/pracownicy/mw/2004_Gatnar_Walesiak_Metody_SAW_w_badaniach_marketingowych.pdf}.

Gordon, A.D. (1999), \emph{Classification}, Chapman & Hall/CRC, London, p. 62. ISBN 9781584880134.

Hubert, L. (1974), \emph{Approximate evaluation technique for the single-link and complete-link hierarchical clustering procedures}, "Journal of the American Statistical Association", vol. 69, no. 347, 698-704. Available at: \url{http://dx.doi.org/10.1080/01621459.1974.10480191}.

Milligan, G.W., Cooper, M.C. (1985), \emph{An examination of procedures of determining the number of cluster in a data set}, "Psychometrika", vol. 50, no. 2, 159-179. Available at: \url{https://dx.doi.org/10.1007/BF02294245}.
}
\seealso{
\code{\link{index.G1}}, \code{\link{index.G3}}, \code{\link{index.S}}, \code{\link{index.H}}, 
\code{\link{index.KL}}, \code{\link{index.Gap}}, \code{\link{index.DB}}
}
\examples{
# Example 1
library(clusterSim)
data(data_ratio)
d <- dist.GDM(data_ratio)
c <- pam(d, 5, diss = TRUE)
icq <- index.G2(d,c$clustering)
print(icq)

# Example 2
library(clusterSim)
data(data_ordinal)
d <- dist.GDM(data_ordinal, method="GDM2")
# nc - number_of_clusters
min_nc=2
max_nc=6
res <- array(0,c(max_nc-min_nc+1, 2))
res[,1] <- min_nc:max_nc
clusters <- NULL
for (nc in min_nc:max_nc)
{
cl2 <- pam(d, nc, diss=TRUE)
res[nc-min_nc+1,2] <- G2 <- index.G2(d,cl2$cluster)
clusters <- rbind(clusters,cl2$cluster)
}
print(paste("max G2 for",(min_nc:max_nc)[which.max(res[,2])],"clusters=",max(res[,2])))
print("clustering for max G2")
print(clusters[which.max(res[,2]),])
write.table(res,file="G2_res.csv",sep=";",dec=",",row.names=TRUE,col.names=FALSE)
plot(res, type="p", pch=0, xlab="Number of clusters", ylab="G2", xaxt="n")
axis(1, c(min_nc:max_nc))
}
\keyword{cluster}