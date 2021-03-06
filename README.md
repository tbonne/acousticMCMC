#### *Listening to MCMC outputs, the acoustic MCMC package:*

This package contains functions for listening to MCMC outputs. The idea here is that a good output should result in relatively static sounds, i.e., well behaved parameter estimates should result in steady acoustics. Whereas a badly performing MCMC should provide a more dynamic listening experience.

The aim is to collect a variety of ways of listening to the outputs of MCMC chains, and is mostly just for fun...

#### *Small example:*

``` r
#install the package
library(devtools)
install_github("tbonne/acousticMCMC")
library(acousticMCMC)

#create of use your own outputs: example MCMC outputs from a 3 parameter model
good.mcmc <- data.frame(x1 = rnorm(300,0,1),
                         x2 = rnorm(300,10,1),
                         x3 = rnorm(300,20,1) )
bad.mcmc <- data.frame(x1 = rnorm(300,0,1),
                        x2 = rnorm(300,10,1), 
                        x3 = c(rnorm(100,0,1),rnorm(100,10,0.1),rnorm(100,0,10)) )

#take a look at the chains
par(mfrow=c(1,2))
plot(good.mcmc$x3,type="b", main="good chain", xlab="Parameter estimate") 
plot(bad.mcmc$x3,type="b", main="bad chain", xlab="Parameter estimate") 
```

![](README_files/figure-markdown_github/unnamed-chunk-1-1.png)

``` r
#lisen to MCMC chain
noisyMCMC(good.mcmc)
noisyMCMC(bad.mcmc)
```

   
#### *Going forward:*

There might be a million ways to listen to this kind of output. What might be most challenging in the contexts of MCMC outputs is the dimensionality (i.e., many parameters), the alternate scaling of parameters, and turning that into some kind of acoustic output. With the ultimate goal of better distinguishing the quality of the MCMC estimation.
