class Screen
{
  Screen()
  {
    map1DisplayX = width/2;
    map2DisplayX = -250;
    map3DisplayX = width + 250;
    hero1DisplayX = width/2;
    hero2DisplayX = -250;
    hero3DisplayX = width + 250;
  }
  void loadScreen()
  {

    noCursor();
    background(0);
    back.draw();
    textSize(100);
    fill(0, 255, 0);
    text("Z3MB13 5URV1V4l", width/2, height/2-200);
    textSize(25);
    text("Press Space to Continue", width/2, height/2+200);
    if (key == ' ')
    {
      screen = 5;
    }
  }
  void mapSelect()
  {
    cursor();
    background(0);
    back.draw();
    fill(255, 0, 0);
    textSize(50);
    text("Select your Map", width/2, height/2-300);
    textSize(25);
    text("Use Left and Right arrow keys to change map", width/2, height-50);
    image(map1, map1DisplayX, height/2);
    image(map3, map3DisplayX, height/2);
    image(map2, map2DisplayX, height/2);
    image(arrowLeft, 50, height-50);
    image(arrowRight, width-50, height-50);
    text("Press enter", 216.5, height/2);
    text("to confirm your choice", 216.5, height/2+20);
    if (dist(mouseX, mouseY, 50, height-50)<50 && mousePressed)
    {
      map1DisplayX-=250+width/2;
      map2DisplayX-=250+width/2;
      map3DisplayX-=250+width/2;
    }
    if (dist(mouseX, mouseY, width-50, height-50)<50 && mousePressed)
    {
      map1DisplayX+=250+width/2;
      map2DisplayX+=250+width/2;
      map3DisplayX+=250+width/2;
    }
    switch(map1DisplayX)
    {
    case 683:
      MapChoice = 0;
      break;

    case -250:
      MapChoice = 1;
      break;

    case 1616:
      MapChoice = 2;
      break;

    default:
      break;
    }
    if (map1DisplayX<-250)
    {
      map1DisplayX=width+250;
    }
    if (map2DisplayX<-250)
    {
      map2DisplayX=width+250;
    }
    if (map3DisplayX<-250)
    {
      map3DisplayX=width+250;
    }
    if (map1DisplayX>width+250)
    {
      map1DisplayX=-250;
    }
    if (map2DisplayX>width+250)
    {
      map2DisplayX=-250;
    }
    if (map3DisplayX>width+250)
    {
      map3DisplayX=-250;
    }
  }
  void heroSelect()
  {
    background(0);
    back.draw();
    fill(255, 0, 0);
    textSize(50);
    text("Select your Hero", width/2, height/2-300);
    textSize(25);
    text("Use Left and Right arrow keys to change Hero", width/2, height-50);
    image(arrowLeft, 50, height-50);
    image(arrowRight, width-50, height-50);
    text("Press shift", 216.5, height/2);
    text("to confirm your choice", 216.5, height/2+20);
    fill(250, 0, 255);
    stroke(250, 0, 255, 30);
    ellipse(hero1DisplayX, height/2, 100, 100);
    fill(0, 0, 255);
    stroke(0, 0, 255, 30);
    ellipse(hero2DisplayX, height/2, 100, 100);
    fill(255, 145, 0);
    stroke(255, 145, 0, 30);
    ellipse(hero3DisplayX, height/2, 100, 100);
    switch(hero1DisplayX)
    {
    case 683:
      HeroChoice = 0;
      break;

    case -250:
      HeroChoice = 1;
      break;

    case 1616:
      HeroChoice = 2;
      break;

    default:
      break;
    }
    if (hero1DisplayX<-250)
    {
      hero1DisplayX=width+250;
    }
    if (hero2DisplayX<-250)
    {
      hero2DisplayX=width+250;
    }
    if (hero3DisplayX<-250)
    {
      hero3DisplayX=width+250;
    }
    if (hero1DisplayX>width+250)
    {
      hero1DisplayX=-250;
    }
    if (hero2DisplayX>width+250)
    {
      hero2DisplayX=-250;
    }
    if (hero3DisplayX>width+250)
    {
      hero3DisplayX=-250;
    }
  }
  void game()
  {
    background(0);
    m.draw();
    c.checkMap();
    cam.checklocation();
    noCursor();
    h.draw();
    cam.draw();
    for (int i = 0; i < Enemys.length; i++)
    {
      Enemys[i].update();
      Enemys[i].enemy();
      Enemys[i].checkCollision();
      Enemys[i].checkEnemy();
    }
  }
  void deathScreen()
  {
    cursor();
    background(0);
    back.draw();
    fill(255, 0, 0);
    textSize(50);
    text("You died, I'm proud, jk", width/2, height/2-300);
    textSize(25);
    text("Press tab to go back to the home screen", width/2, 600);
  }
  void lvlcomplete()
  {
  }
  void homeScreen()
  {
    cursor();
    background(0);
    back.draw();
    textSize(50);
    fill(0, 255, 0);
    text("Z3MB13 5URV1V4l", width/2, height/2-300);
    rectMode(CENTER);
    fill(255, 255, 255);
    strokeWeight(50);
    stroke(255, 255, 255, 50);
    rect((width/2)/2, height/2+50, width/2-100, height-200);
    rect((width/2)/2+width/2, height/2+(height/2)/2+25, width/2-100, height/2-150);
    rect((width/2)/2+width/2, (height/2)/2+75, width/2-100, height/2-150);
    if (dist(mouseX, mouseY, (width/2)/2, height/2+50)<(width/2)/2 && mousePressed)
    {
      screen = 1;
    }
    fill(0);
    text("Start", (width/2)/2, height/2+50);
  }
  void reset()
  {
    for (int i = 0; i < Enemys.length; i++)
    {
      Enemys[i].enemyReset();
    }
    camLeft = 0;
    camRight = 0;
    camUp = 0;
    camDown = 0;
  }
}