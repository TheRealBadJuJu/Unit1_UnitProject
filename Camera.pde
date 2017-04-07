class Camera
{
  Camera() 
  {
    pos = new PVector(0, 0);
  }

  void draw()
  {
    pos.x += (camRight-camLeft)*speed;
    pos.y += (camDown-camUp)*speed;
    translate(width/2, height/2);
    fill(0, 0, 255);
    stroke(0, 0, 255, 50);
    textSize(20);
    fill(0);
    text(pos.x, pos.x-1300, pos.y-650);
    text(pos.y, pos.x-1300, pos.y-700);
    if (pos.x >=1340)
    {
      pos.x = 1340;
    }
    if (pos.x<=-2700)
    {
      pos.x = -2700;
    }
    if (pos.y>=1600)
    {
      pos.y = 1600;
    }
    if (pos.y<=-2400)
    {
      pos.y = -2400;
    }
  }
}