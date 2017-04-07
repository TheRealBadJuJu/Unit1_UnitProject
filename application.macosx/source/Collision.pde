class Collision
{
  Collision()
  {
  }
  void checkMap()
  {
    loadPixels();
    posColour = get((int)width/2, (int)height/2);
    println(blue(posColour));
    if (blue(posColour) == 162)
    {
      speed = 1.5;
    }
    else 
    {
      speed = 3;
    }
    if (red(posColour) == 255)
    {
      screen = 4;
    }
  }
}