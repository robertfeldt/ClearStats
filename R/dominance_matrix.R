# Calculate the dominance matrix that compares all values of
# sample 1 to all values of sample 2 and indicates if they are
# larger (+1), equal (0) or smaller (-1), i.e.
# element ij of the dominance matrix is
#   -1 if Xi<Yj
#    0 if Xi==Yj
#   +1 if Xi>Yj
dominance_matrix <- function(sample1, sample2) {
  sign(outer(sample1, sample2, FUN="-"))
}
