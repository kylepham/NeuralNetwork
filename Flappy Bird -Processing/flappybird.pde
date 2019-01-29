/*
ArrayList<> usage:
 arr.get(index)
 arr.set(index, value)
 arr.add(value)
 arr.remove(index)
 arr.clear()
 arr.size()
 */


PImage imageBackground;
ArrayList<PImage> imageBirds;
ArrayList<PImage> imagePipes; // [top pipe], [bottom pipe]
ArrayList<Pipe> pipes; // pipes
ArrayList<Bird> birds; // birds
ArrayList<Bird> prevBirds;
int count = 0;
int TOTAL = 500;
int screenWidth = 287;
int screenHeight = 511;
int targetedPipeIndex = -1;
NeuralNetwork brain;

void setup()
{
  size(287, 511); //size of Background image

  //Array of birds' images
  imageBirds = new ArrayList<PImage>();
  imageBirds.add(loadImage("images/Bird0.png"));
  imageBirds.add(loadImage("images/Bird1.png"));
  imageBirds.add(loadImage("images/Bird2.png"));

  //Array of pipes' images
  imagePipes = new ArrayList<PImage>();
  imagePipes.add(loadImage("images/TopPipe.png"));
  imagePipes.add(loadImage("images/BottomPipe.png"));

  imageBackground = loadImage("images/Background.png");

  //Initiate new bird
  birds = new ArrayList<Bird>();
  for (int i = 0; i < TOTAL; i++)
  {
    birds.add(new Bird());
  }
  prevBirds = new ArrayList<Bird>();

  //Initiate new pipe(s)
  pipes = new ArrayList<Pipe>();
  pipes.add(new Pipe());
  //Matrix matrix = new Matrix(3, 2);
  //matrix.randomize();
  //println(matrix.data);
  //ArrayList<Double> temp = new ArrayList<Double>();
  //temp.add((double)random(0.9));
  //temp.add((double)random(0.9));
  //NeuralNetwork brain1 = new NeuralNetwork(2, 2, 2);
  //println(brain1.weights_ih.data);
  //NeuralNetwork brain2 = new NeuralNetwork(2, 2, 1);
  //println(temp);
  //ArrayList<Double> outputs = brain1.feedForward(temp);
  //println(outputs);
}

void draw()
{
  if (count > 75)
  {
    pipes.add(new Pipe());   
    count = 0;
  }
  scale(1, 1);
  image(imageBackground, 0, 0);
  for (int i = 0; i < birds.size(); i++)
  {
    birds.get(i).show();
  }
  for (int i = 0; i < pipes.size(); i++)
  {
   
    pipes.get(i).show();
  }
  for (int i = 0; i < birds.size(); i++)
  {
    birds.get(i).decide(pipes);
    birds.get(i).update();
  }

  for (int i = 0; i < pipes.size(); i++)
  {
    pipes.get(i).update();
    for (int j = 0; j < birds.size(); j++)
    {
      if (pipes.get(i).collision(birds.get(j)) || birds.get(j).collision())
      {
        prevBirds.add(birds.get(j));
        birds.remove(j);
        //println("added to prevBirds, length" + prevBirds.size());
      }
    }
    //off-screened pipe(s)
    if (pipes.get(i).x < -imagePipes.get(0).width)
    {
      targetedPipeIndex = i;
    }
  }

  if (birds.size() == 0)
  {
    //new generation with new brains
    gameReset();
  }

  if (targetedPipeIndex != -1)
  {
    pipes.remove(targetedPipeIndex);
    targetedPipeIndex = -1;
  }

  count++;
}

void gameReset()
{
  //if (prevBirds.size() != 0)
  // --------------------- calls for genetic algorithm --------------------- //
  birdEvolution();
  // ------------------- end calls for genetic algorithm ------------------- //
  prevBirds.clear();
  pipes.clear();
  pipes.add(new Pipe());
  targetedPipeIndex = -1;
  count = 0;
}
