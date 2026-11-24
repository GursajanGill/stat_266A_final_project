# plots the results from the zeta test 
library(ggplot2)


# Figure 1: shows the strenght of the auditory response of the neuron, split by z-score (how many standard deviations is that neuron away from the mean)
ggplot(auditory_responsive_neurons, aes(x = zeta_z, fill = responsive)) + # take z-score of responsive neurons from the ZETA test
    geom_histogram(binwidth = 1, boundary = 0, color = "white") + 
    labs(x = "ZETA z-score", y = "Number of Neurons", fill = "Responsive", 
      title = "Strength of Auditory Responsiveness of Neurons") +
    theme_minimal()
ggsave("output/figures/fig3_auditory_responsiveness_strength.png", width = 7, height = 4.5, bg = "white")

# Figure 2: plot the location of the auditory neurons on the probe...auditory neurons sit deeper so we expect them to be on the lower ends of the probe
ggplot(auditory_responsive_neurons, aes(x = responsive, y = depth, fill = responsive)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.15, alpha = 0.4) + 
  scale_y_reverse() + # have to reverse order of y-axis to help create a visual of deeper being lower
  labs(x = "Responsive", y = "Depth on the Probe (um)", fill = "Responsive", 
      title = "Depth of Responsive vs Non-Responsive Neurons") +
  theme_minimal()
ggsave("output/figures/fig4_depth_neurons.png", width = 7, height = 4.5, bg = "white")

