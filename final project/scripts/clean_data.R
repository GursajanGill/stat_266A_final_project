# clean data and keep only good neurons
clusters_good <- clusters[clusters$group == "good", ] # only keeps the information of clusters labeled good
spikes_good <- spikes[spikes$unit %in% clusters_good$cluster_id, ] # keeps the spike times of only the good clusters
spikes_per_cluster <- table(spikes_good$unit) # number of spikes per each good cluster

neuron_ids <- as.numeric(names(spikes_per_cluster)[spikes_per_cluster >= 100]) #only keeps clusters with at least 100 spikes

neurons <- clusters_good[clusters_good$cluster_id %in% neuron_ids, ] #filters to create the set of neurons for analysis, the good clusters with at least 100 spikes
spikes_neurons <- spikes_good[spikes_good$unit %in% neuron_ids, ] #filters to keep the spikes of good neurons with at least 100 spikes

cat("There are", nrow(neurons), "good neurons")
cat("Total spikes:", nrow(spikes_neurons))
