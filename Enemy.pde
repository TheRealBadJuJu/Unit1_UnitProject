class Enemy
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector vel;
  float Speed;
  PVector startingLocation;

  Enemy()
  {
    location = new PVector(random(-2000, 2000), random(-2000, 2000));
    velocity = new PVector(100, 100);
    vel = new PVector(0, 0);
    Speed = 2;
    startingLocation = new PVector(location.x, location.y);
  }

  void update()
  {

    PVector cam = new PVector(pos.x-width/2, pos.y-height/2);
    PVector dir = PVector.sub(cam, location);
    dir.normalize();
    dir.mult(0.5);
    acceleration = dir;
    velocity.add(acceleration);
    velocity.limit(Speed);
    location.add(velocity);
    location.add(vel);
  }

  void enemy()
  {
    fill(0, 255, 0);
    stroke(0, 255, 0, 50);
    ellipse(location.x, location.y, 50, 50);
  }
  void checkCollision()
  {
    for (int i = 0; i < Enemys.length; i++)
    {
      if (dist(pos.x-width/2, pos.y-height/2, location.x, location.y)<50)
      {
        pos.x = 0;
        randomInsultDeath = (int)random(8);
        pos.y = 0;
        screen = 4;
      }
    }
  }

  void enemyReset()
  {
    location.x = startingLocation.x;
    location.y = startingLocation.y;
  }
  void checkEnemy()
  {
    for (int i = 0; i < Enemys.length; i++)
    {
      for (int j = 0; j < Enemys.length; j++)
      {
        Enemy e1 = Enemys[i];
        Enemy e2 = Enemys[j];
        if (dist(e1.location.x, e1.location.y, e2.location.x, e2.location.y)<50)
        {
          e1.bump(e2.location);
          e2.bump(e1.location);
        }
      }
    }
  }
  void bump(PVector e)
  {
    PVector bumpDir = new PVector(20000*(location.x-e.x), 20000*(location.y-e.y));
    bumpDir.setMag(2);
    vel = bumpDir;
  }
  void mousePressed()
  {
    if (dist(mouseX, mouseY, location.x, location.y)<50)
    {
      location.x = random(-2000, 2000);
      location.y = random(-2000, 2000);
    }
  }
}