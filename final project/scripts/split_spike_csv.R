# splits full spiking dataset csv into two csv's to allow for raw data file to be uploaded to GitHub
spikes_all <- read.csv("data/raw/spikes_seg2_speaker_array_sound.csv")
half <- ceiling(nrow(spikes_all)/2) 
write.csv(spikes_all[1:half, ], "data/raw/spikes_part1.csv", row.names = FALSE)
write.csv(spikes_all[(half + 1):nrow(spikes_all), ], "data/raw/spikes_part2.csv", row.names = FALSE)

# check that the two halves are correctly split by stacking them back together:
stacked <- rbind(read.csv("data/raw/spikes_part1.csv"), read.csv("data/raw/spikes_part2.csv"))
stopifnot("rebind did not recapitulate total rows in original csv" = nrow(stacked) == nrow(spikes_all), all.equal(stacked, spikes_all))