expected_rows = 7405475 # exact number of rows in entire csv
clusters <- read.csv("data/raw/cluster_info.csv")
trials <- read.csv("data/raw/trials.csv")
spikes <- rbind(read.csv("data/raw/spikes_part1.csv"), read.csv("data/raw/spikes_part2.csv")) #combines two halves of raw spike data into one big table

stopifnot("a row is missing or was added twice" = nrow(spikes) == expected_rows)