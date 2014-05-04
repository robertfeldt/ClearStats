library(ggplot2)

# Parse a string of numbers, separated by non-digits, into an R
# vector.
parse_dataset_from_string <- function(string) {
  # This works but does not parse 1e-3 etc:
  # re <- "(\\d+\\.\\d+)|(\\d+)"
  # m <- gregexpr(re, string)
  #na.omit(as.numeric(unlist(regmatches(string, m))))

  na.omit(as.numeric(unlist(strsplit(string, "\\s*(,|;|\\s+)\\s*"))))
}

data_frame_from_strings <- function(datasetAstr, datasetBstr) {
  a <- parse_dataset_from_string(datasetAstr);
  b <- parse_dataset_from_string(datasetBstr);

  rbind(
    data.frame(dataset = rep("A", times=length(a)), value=a), 
    data.frame(dataset = rep("B", times=length(b)), value=b)
    )  
}

density_plot <- function(a, b) {
  data <- rbind(
    data.frame(dataset = rep("A", times=length(a)), value=a), 
    data.frame(dataset = rep("B", times=length(b)), value=b)
    )  

  p <- ggplot(data, aes(x = value, fill = dataset)) +
  geom_density(alpha = 0.3) +
  theme_bw() +
  theme(
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
    )

  medianA <- median(subset(data, dataset == "A")$value);
  medianB <- median(subset(data, dataset == "B")$value);

  p <- p + geom_vline(xintercept = medianA, linetype="dashed", size=0.4) +
  geom_vline(xintercept = medianB, linetype="dotted", size=0.5);

  print(p);
  invisible(); # So we do not both print and return the plot...
}