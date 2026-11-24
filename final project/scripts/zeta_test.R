# looks at zeta_results.csv from ZETA test python output

zeta_results <- read.csv("data/processed/zeta_results.csv")
stopifnot("Neurons do not match original dataset" = setequal(zeta_results$cluster_id, neurons$cluster_id)) # make sure no neurons are lost or duplicated during the ZETA test run

zeta_neurons <- merge(neurons, zeta_results, by = "cluster_id") # creates a new variable with one row per neuron
zeta_neurons$responsive <- zeta_neurons$zeta_p < 0.05 # keeps the neurons with a zeta p-value below 0.05

auditory_responsive_neurons <- zeta_neurons[order(-zeta_neurons$zeta_z), c("cluster_id", "depth", "zeta_z", "zeta_p", "responsive")] # organize neurons with most responsive neurons at top  

cat("There are", sum(zeta_neurons$responsive), "auditory responsive neurons")
