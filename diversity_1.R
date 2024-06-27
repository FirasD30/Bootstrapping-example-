library(vegan) # community ecology
library(SpadeR)
library(bootstrap)


# Calculate Shannon's index for a community of 5 species with equal abundance
x = c(10,10,10,10,10)
diversity(x)

# At equal abundance, the community is maximumally diverse
# so diversity should equal log(num species)
log(5)

# Calculate Shannon's index for a community dominated
# by one species. Diversity tends towards zero for
# less diverse species
y= c(100,1)
diversity(y)

# Can compare both communities at once by padding
# community with fewer species with zeros.
# Be careful with the margin argument when calculating diversity
# Can just add 0s to get same number as x
y = c(100,1,0,0,0)
diversity_matrix <- rbind(x,y)
diversity(diversity_matrix, MARGIN = 1)

# Use rarefaction to compare two difference communities at the same sampling effort (here
# number of individuals sampled)
community1 = c(504,408,356,200,199,196,50,21,20,20,19,19,19,17,15,15,15,15,6,6,6,5,5,5,4,4,4,1,1,1,1,1)
community2 = c(66, 61, 48, 43, 42, 20, 19, 19, 19, 19, 18, 17, 16, 16, 15, 14, 14, 13, 12, 7, 3, 2,2,2,1)

# Number of species in each community
print(length(community1))
print(length(community2))

# Number of individuals in each community
print(sum(community1))
print(sum(community2))

# Community 1 appears more diverse - but has also been much more heavily sampled
# Standardize the sampling effort to the same number of individuals as community2
rarefy(community1, 508)

# After rarefying, at the same sampling effort the communities are almost identically
# equal in species richness

# Non-parametric estimation of total (asymptotic) richness
ChaoSpecies(community1, datatype="abundance")
ChaoSpecies(community2, datatype="abundance")

# Bootstrap example from class
CommunityA = c(14,13,12,5,8,2,3,1,1,12)

# Calculate Shannon evenness for this sample
diversity(CommunityA)

# Bootstrap sample
output <- bootstrap(CommunityA, 1000, diversity)
hist(output$thetastar, xlab = "Shannon's Index", ylab = "Number of bootstrap samples", main = "")
output <- sort(output$thetastar)



