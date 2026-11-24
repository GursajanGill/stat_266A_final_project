# Plots figures that can be used to check the quality of the neurons collected in the data
source("scripts/read_data.R")
source("scripts/clean_data.R")



# Figure 1: histogram that plots the number of spikes of the good clusters after stimulus onset
# aligns spikes to stimulus onset with 5ms time bins
# auditory neurons should spike within the first 100ms post stimulus onset

library(ggplot2)
relative_spikes <- c() 
for (i in 1:1170) { # for loop to run for every trial "i" from trial 1 to trial 1170
  trial_onset  <- trials$ttl_time_s[i] # onset time of trial
  responsive_spike <- spikes_good$time_s >= trial_onset & spikes_good$time_s < trial_onset + 1.0 #sets spike as true if spike is after trial_onset and before trial_offset (each trial lasts 1000ms, the first 100ms is the stimulus)
  relative_spikes  <- c(relative_spikes, (spikes_good$time_s[responsive_spike] - trial_onset) * 1000)} #the time of the spike relative to onset in ms

relative_spikes <- data.frame(time_ms = relative_spikes) #turn relative_spikes vector into a dataframe

ggplot(relative_spikes, aes(x = time_ms)) +
  geom_histogram(binwidth = 5, boundary = 0) + #plot histogram with 5ms bin width
  labs(x = "Time After Stimulus Onset (ms)", y = "Number of Spikes", title = "# of Spikes of Clusters Post Stimulus Onset") +
  theme_minimal() 

ggsave("output/figures/fig1_good_clusters_histogram.png", width = 7, height = 4.5, bg = "white")


# Figure 2: plots the firing rate post stimulus onset for good vs mua vs noise clusters
# another quality check of the behavior of our dataset, we should expect good clusters to have a much more timelocked and elevated firing rate after stimulus onset compared to MUAs and nosie

cluster_type <- c("good", "mua", "noise") 
all_cluster_types <- data.frame()
for (x in cluster_type) { #make a really big loop for every "x" cluster, cycles through good, mua and noisy groups
  clusters_x <- clusters[clusters$group == x, ] 
  spikes_x <- spikes[spikes$unit %in% clusters_x$cluster_id, ]
  relative_spikes <- c() #Same for loop from previous figure
  for (i in 1:1170) {
    trial_onset <- trials$ttl_time_s[i]
    in_window <- spikes_x$time_s >= trial_onset & spikes_x$time_s < trial_onset + 1.0
    relative_spikes <- c(relative_spikes, (spikes_x$time_s[in_window] - trial_onset) * 1000)}

  counts <- table(floor(relative_spikes / 5)) # number of spikes in each 5 ms bin
  one_cluster_type <- data.frame(time_ms = as.numeric(names(counts)) * 5, # start time of each bin in ms
  spikes_per_cluster = as.numeric(counts) / nrow(clusters_x), # divide by number of clusters per cluster type
    group = x) # label the rows with teh clusters
  all_cluster_types <- rbind(all_cluster_types, one_cluster_type)} #add all clusters to one table
     
ggplot(all_cluster_types, aes(x = time_ms, y = spikes_per_cluster, color = group)) +
  geom_point() +
  geom_line() +
  labs(x = "Time After Stimulus Onset (ms)", y = "Spikes per Cluster (5ms Bins)", color = "Cluster Type", title = "Spikes After Stimulus Onset: Good vs MUA vs Noise") +
  theme_minimal() 
ggsave("output/figures/fig2_firing_by_cluster.png", width = 7, height = 4.5, bg = "white")