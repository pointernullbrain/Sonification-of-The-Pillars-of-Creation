# Sonification of the Pillars of Creation

A small R-based data sonification and signal-analysis project inspired by the Pillars of Creation astronomical region. The project reads optical and X-ray audio files, applies signal-processing techniques, and visualizes their waveform, frequency spectrum, and spectrogram characteristics.

## Project goal

This repository explores how astronomical imagery can be translated into sound and analyzed as audio signals. The script focuses on two layered audio recordings:

- `m16_optical.wav`
- `m16_xray.wav`

It then uses a range of signal-processing tools to:

- downsample the waveforms for computational efficiency
- plot waveform oscillograms
- compute duration and timing statistics
- generate FFT magnitude spectra
- identify dominant frequency peaks
- create spectrograms and dynamic spectra

## Repository contents

- `PillarsOfCreation_AudioAnalysis.R` — main analysis script
- `report.docx` — project report document
- `README.md` — project overview and usage notes

## Requirements

This project is written in R and depends on the following packages:

```r
install.packages(c("tuneR", "seewave"))
```

You will also need the audio files used in the analysis:

- `m16_optical.wav`
- `m16_xray.wav`

## Usage

1. Open the project in RStudio or any R environment.
2. Ensure the WAV files are available in the working directory or adjust the file paths in the script.
3. Update the `setwd()` line if needed to reflect your local folder structure.
4. Run the script:

```r
source("PillarsOfCreation_AudioAnalysis.R")
```

The script will:

- load both audio files
- play them using the `tuneR` package
- display oscillograms for the optical and X-ray layers
- compute wave duration metrics
- generate FFT spectra and dominant frequency peaks
- visualize spectrograms for each layer

## Important note

The script currently contains a hard-coded Windows file path in this line:

```r
setwd("C:\Users\adria\Desktop\Aaron DS master folder\STQD6114 Unstructured Data Analysis\Project 2\audio")
```

Before running it on another machine, replace this with the path to your local audio folder or change the script to use relative paths.

## Example workflow

```r
library(tuneR)
library(seewave)

optical <- readWave("m16_optical.wav")
xray <- readWave("m16_xray.wav")

optical_small <- downsample(optical, 8000)
xray_small <- downsample(xray, 8000)

optical_fft <- meanspec(optical, wl = 4096, flim = c(0,25), dB = "max0", ovlp = 50)
xray_fft <- meanspec(xray, wl = 4096, flim = c(0,25), dB = "max0", ovlp = 50)

spectro(optical_small, wl = 512, flim = c(0,2.5), wn = "hanning")
spectro(xray, wl = 512, flim = c(0,2.5), wn = "hanning")
```

## Summary

This project combines digital signal processing, audio analysis, and astronomical inspiration to create a sonified interpretation of the Pillars of Creation. It is a compact, exploratory workflow for generating meaningful audio-based visualizations from data.

## License

This repository does not currently specify a license. If you plan to share or reuse it publicly, consider adding an open-source license such as MIT or GPL.
