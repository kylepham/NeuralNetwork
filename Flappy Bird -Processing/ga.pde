void birdEvolution()
{
  calculateFitness();  
  
  //generate the whole new birds with the genes (nn's) mutated from their parents
  birds.clear();
  for (int i = 0; i < TOTAL; i++)
  {
    birds.add(previousGene());  
  }
}

void calculateFitness()
{
  double sum = 0;
  for (int i = 0; i < prevBirds.size(); i++)
  {
    sum += prevBirds.get(i).fitness;
  }
  
  //normalize
  for (int i = 0; i < prevBirds.size(); i++)
  {
    prevBirds.get(i).fitness /= sum; // birds' fitness range in [0..1]
  }
}

Bird previousGene()
{
  double percentage = random(1);
  int index = prevBirds.size() - 1;
  while (percentage > 0)
  {
    percentage -= prevBirds.get(index).fitness;
    index--;
  }
  index++;
  Bird bird = prevBirds.get(index);
  int partnerIndex = floor(random(0, prevBirds.size()));
  Bird partner = prevBirds.get(partnerIndex);
  Bird child = new Bird(bird.brain);
  child.crossOver(partner.brain);
  child.mutate();
  return child;
}
