#' Create sounds from MCMC outputs
#'
#' This function will generate sounds using the outputs of an MCMC.
#' @param my.mcmc dataframe containing all mcmc outputs. Each column should be a parameter, and the rows should be their estimated values.
#' @param mean.freq The mean frequency to use. Values of the MCMC adjust this mean frequency.
#' @param speed The speed at which sounds are played.
#' @param player The name of the player to be used by tuneR (Default: mplay32.exe). See tuneR ?play() for options.
#' @export
#' @import tuneR
#' @examples 
#' \dontrun{
#' #example MCMC outputs from a 3 parameter model
#' good.mcmc <- data.frame(x1 = rnorm(300,0,1),
#'                         x2 = rnorm(300,10,1),
#'                         x3 = rnorm(300,20,1) )
#' bad.mcmc <- data.frame(x1 = rnorm(300,0,1),
#'                        x2 = rnorm(300,10,1), 
#'                        x3 = c(rnorm(25,0,1),rnorm(25,10,0.1),rnorm(250,0,10)) )
#' 
#' #lisen to MCMC chain
#' noisyMCMC(good.mcmc)
#' noisyMCMC(bad.mcmc)
#' }     
noisyMCMC <- function(my.mcmc, mean.freq = 400, speed=0.01, player=NULL){
  #main wave obs
  f=mean.freq + my.mcmc[1,1]                 #frequency of A4 note
  sr=8000 #2sw`
  bits=32
  secs=speed
  amp=abs(1 + my.mcmc[1,1] )
  t=seq(0, secs, 1/sr)
  y= amp*sin(2*pi*f*t)  #make a sinewave with above attributes
  s=floor(2^(bits-2)*y) #floor it to make it an integer value
  Wobj=Wave(s, samp.rate=sr, bit=bits)  #make a wave structure

  for(i in 1:nrow(my.mcmc)){

    #combine sounds from all traces
    for(j in 1:ncol(my.mcmc)){

      if(j==1){
        f=mean.freq + my.mcmc[i,j]                 #frequency of A4 note
        sr=8000 #2sw`
        bits=32
        secs=speed
        amp=abs(1 + my.mcmc[i,j])
        t=seq(0, secs, 1/sr)
        y= amp*sin(2*pi*f*t)  #make a sinewave with above attributes
        s=floor(2^(bits-2)*y) #floor it to make it an integer value
        u=Wave(s, samp.rate=sr, bit=bits)  #make a wave structure

      } else {
        f=mean.freq + my.mcmc[i,j]                 #frequency of A4 note
        sr=8000 #2sw`
        bits=32
        secs=speed
        amp=abs(1 + my.mcmc[i,j] )
        t=seq(0, secs, 1/sr)
        y= amp*sin(2*pi*f*t)  #make a sinewave with above attributes
        s=floor(2^(bits-2)*y) #floor it to make it an integer value
        u.temp=Wave(s, samp.rate=sr, bit=bits)  #make a wave structure
        u = u + u.temp
      }

    }

    Wobj <- bind(Wobj, u)


  }

  if(is.null(player)){
    play(normalize(Wobj, unit = "32") )
  } else {
    play(normalize(Wobj, unit = "32", player=player) )  
  }
  

}
