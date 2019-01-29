class Pipe
{
  float topPipe;
  float bottomPipe;
  float x;
  float w; 
  int speed;
  
  Pipe()
  {
    this.topPipe = random(40, 300);
    this.bottomPipe = height - this.topPipe - 150;
    this.x = width;
    this.w = imagePipes.get(0).width; 
    this.speed = -3;
  }
  
  void update()
  {
    this.x += this.speed;
  }
  
  void show()
  {
    imageMode(CORNER);
    image(imagePipes.get(0), this.x, this.topPipe - imagePipes.get(0).height);
    image(imagePipes.get(1), this.x, height - this.bottomPipe);
  }   
  
  boolean collision(Bird bird)
  {
    if (bird.y - imageBirds.get(0).height / 2 < this.topPipe || bird.y + imageBirds.get(0).height / 2 > height - this.bottomPipe)
      if (bird.x + imageBirds.get(0).width / 2 > x && bird.x - imageBirds.get(0).width / 2 < this.x + this.w)
      {
        return true;
      }
    return false;
  }
}  
