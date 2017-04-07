class Hero
{
  Hero()
  {
  }
  void checkHero()
  {
    switch(HeroChoice)
    {
    case 0:
      HeroR = 250;
      HeroG = 0;
      HeroB = 255;
      break;

    case 2:
      HeroR = 0;
      HeroG = 0;
      HeroB = 255;
      break;

    case 1:
      HeroR = 255;
      HeroG = 145;
      HeroB = 0;
      break;

    default:
      break;
    }
  }
  void draw()
  {
    translate(width/2, height/2);
    stroke(HeroR, HeroG, HeroB, 50);
    fill(HeroR, HeroG, HeroB);
    ellipse(pos.x, pos.y, 50, 50);
  }
}