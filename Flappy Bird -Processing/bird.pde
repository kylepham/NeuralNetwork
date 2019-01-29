class Bird
{
  int count = 0;
  int score = 0;
  float x = 64, y = screenHeight / 2;
  float vel = 0;
  float lift = -17;
  float gravity = 0.8;
  double fitness = 0;
  ArrayList<PImage> images = imageBirds;
  NeuralNetwork brain;
  
  Bird(NeuralNetwork brain)
  {
    this.brain = brain.copy();
  }
  
  Bird()
  {
    this.brain = new NeuralNetwork(4, 4, 2);
  }
  
  int frontPipe(ArrayList<Pipe> pipeList)
  {
    for (int i = 0; i < pipeList.size(); i++)
    {
      if (this.x < pipeList.get(i).x + pipeList.get(i).w)
      {
        return i;
      }  
    }
    return -1;
  }
  
  void decide(ArrayList<Pipe> pipeList)
  {
    if (pipeList.size() == 0)
    {
      return;
    }
    ArrayList<Double> inputs = new ArrayList<Double>();   
    inputs.add((double)this.y / screenHeight);
    inputs.add((double)pipeList.get(this.frontPipe(pipeList)).x / screenWidth);
    inputs.add((double)pipeList.get(this.frontPipe(pipeList)).topPipe / screenHeight);
    inputs.add((double)pipeList.get(this.frontPipe(pipeList)).bottomPipe / screenHeight);

    ArrayList<Double> outputs = this.brain.feedForward(inputs);
    if (outputs.get(0) > outputs.get(1))
    {
      this.up();  
    }
  }
  
  void crossOver(NeuralNetwork partner)
  {
    this.brain.crossOver(partner, 0.1);  
  }
  
  void mutate()
  {
    this.brain.mutate();  
  }
  
  void up()
  {
    if (this.count > 6)
    {
      this.vel += this.lift;
      this.vel *= 0.9;
      this.y += this.vel;
      
      this.count = 0;
    }
    else
      return;
  }
  
  void update()
  {
    this.vel += this.gravity;
    this.vel *= 0.9;
    this.y += this.vel;
    this.fitness++;
    this.count++;
  }
  
   
  void show()
  {
    imageMode(CENTER);
    image(imageBirds.get(0), this.x, this.y);
  }
  
  boolean collision()
  {
    if (this.y > screenHeight || this.y < 0)
    {
      return true; 
    }
    return false;
  }
}
