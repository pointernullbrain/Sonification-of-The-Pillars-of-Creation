library(tuneR)
library(seewave)
setwd("C:\\Users\\adria\\Desktop\\Aaron DS master folder\\STQD6114 Unstructured Data Analysis\\Project 2\\audio")

optical = readWave("m16_optical.wav")
#Downsample to reduce computational load
optical_small <- downsample(optical, 8000)
play(optical)

xray = readWave("m16_xray.wav")
xray_small <- downsample(xray, 8000)
play(xray)

#Adjust layout to plot both oscillogram in one plot
par(mfrow = c(2, 1), mar = c(4.5, 4.5, 2.2, 2), oma = c(1, 0, 5, 0))

oscillo(optical, 
        title = "Optical Layer",
        colwave = "royalblue2",
        bty = "l",
        cexlab = 2,
        cextitle = 2,
        cexaxis = 1.5
        )


oscillo(xray,
        title = "X-ray Layer",
        colwave = "deeppink2",
        bty = "l",
        cexlab = 2,
        cextitle = 2,
        cexaxis = 1.5
        )

#Get duration of each audio wave
duration(optical)
duration(xray)


optical_stats <- timer(optical, f = optical@samp.rate, threshold = 5, ssmooth = 4000)
xray_stats <- timer(xray, f = xray@samp.rate, threshold = 5, ssmooth = 40)

#FFT
par(mfrow=c(1,2))
optical_fft <- meanspec(optical, 
         wl = 4096, #Best window length by trial and error
         flim = c(0,25), #Limit frequency range
         dB = "max0", #Standard db range
         ovlp = 50,
         col = "royalblue2",
         lwd = 1.5,
         main = "Main Frequency Spectrum: Optical Layer"
         )

xray_fft <- meanspec(xray,
         wl = 4096, 
         flim = c(0,25), 
         dB = "max0", 
         ovlp = 50,
         col = "deeppink2",
         lwd = 1.5,
         main = "Main Frequency Spectrum: X-Ray Layer"
         )

#Optional; to find dominant frequency peaks
fpeaks(optical_fft, nmax = 3)
fpeaks(xray_fft, nmax = 3)

#STFT spectrogram
spectro(optical_small, 
        wl = 512,
        flim = c(0,2.5), 
        wn = "hanning", #Prevention of spectral leakage
        main = "Spectrogram of Optical Layer"
        
        )

spectro(xray,
        wl = 512,
        flim = c(0,2.5),
        wn = "hanning",
        main = "Spectrogram of X-Ray Layer"
        )

#Dynspec
dynspec(optical_small, wl = 1024, osc = TRUE)

