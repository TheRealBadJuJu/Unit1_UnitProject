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
    } else 
    {
      speed = 3;
    }
    if (red(posColour) == 255)
    {
      randomInsultDeath = (int)random(8);
      pos.x = 0;
      pos.y = 0;
      screen = 4;
    }
  }
}