import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Unit1_UnitProject extends PApplet {



Camera cam;
Screen scr;
Maps m;
Hero h;
Collision c;
Background back;

String[] Map;
PImage map1;
PImage map2;
PImage map3;
PImage arrowLeft;
PImage arrowRight;
int Ballcount = (int)random(10, 50);
float[] Xs = new float[Ballcount];
float[] Ys = new float[Ballcount];
float[] BounceX = new float[Ballcount];
float[] BounceY = new float[Ballcount];
float[] Color = new float[Ballcount];
float[] originalPos = new float[Ballcount];
float dirX= 1;
float dirY= 1;
float y= height/2;
float x= random(width);
float speedX= 3;//random(10);
float speedY= 3;//random(10);
float circlesize= 0;
int map1DisplayX;
int map2DisplayX;
int map3DisplayX;
int hero1DisplayX;
int hero2DisplayX;
int hero3DisplayX;
int screen = 0;
int MapChoice;
int HeroChoice;
int Unlock = parseInt("Unlocks.txt");
PVector pos;
PVector initial;
float speed = 1;
float camX;
float camY;
int camLeft = 0;
int camRight = 0;
int camDown = 0;
int camUp = 0;
int gridsize = 10;
int rectsize = 400;
int MapR;
int MapG;
int MapB;
int HeroR;
int HeroG;
int HeroB;
int posColour;
int enemycount = 100;
int enemyCount;
float[] EnemyposX = new float[enemycount];
float[] EnemyposY = new float[enemycount];
Enemy[] Enemys = new Enemy[enemycount];
Minim minim;
AudioPlayer song;
AudioPlayer song2;

public void setup()
{
  textAlign(CENTER);
  imageMode(CENTER);
  rectMode(CORNER);
  map1 = loadImage("Highway.png");
  map2 = loadImage("Desert.png");
  map3 = loadImage("Hell.png");
  arrowLeft = loadImage("Arrowleft.png");
  arrowRight = loadImage("Arrowright.png");
  arrowLeft.resize(50, 50);
  arrowRight.resize(50, 50);
  
  
  cam = new Camera();
  scr = new Screen();
  m = new Maps();
  h = new Hero();
  c = new Collision();
  back = new Background();
  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
  song2 = minim.loadFile("song2.mp3");
  song.play();
  song.loop();
  enemyCount = enemycount;
  for (int i = 0; i < Enemys.length; i++)
  {
    Enemys[i] = new Enemy();
  }
  for (int i=0; i<Ballcount; i++)
  {
    Color[i] = random(255);
    Xs[i] = random(25, width-25);
    Ys[i] = random(25, height-25);
    BounceX[i] = random(-1, 1);
    BounceY[i] = random(-1, 1);
  }
}

public void draw()
{
  translate(-pos.x, -pos.y);
  if (screen == 0)
  {
    scr.loadScreen();
  }
  if (screen == 1)
  {
    scr.mapSelect();
  }
  if (screen == 2)
  {
    scr.heroSelect();
  }
  if (screen == 3)
  {
    c.checkMap();
    scr.game();
  }
  if (screen == 4)
  {
    scr.deathScreen();
  }
  if (screen == 5)
  {
    scr.homeScreen();
  }
  if (screen == 6)
  {
    scr.lvlcomplete();
  }
}

public void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == UP && screen == 3)
    {
      camUp = 0;
    }
    if (keyCode == DOWN && screen == 3) 
    {
      camDown = 0;
    }
    if (keyCode == LEFT && screen == 3) 
    {
      camLeft = 0;
    } 
    if (keyCode == RIGHT && screen == 3) 
    {
      camRight = 0;
    }
  }
}

public void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == LEFT && screen == 2)
    {
      hero1DisplayX-=250+width/2;
      hero2DisplayX-=250+width/2;
      hero3DisplayX-=250+width/2;
    }
    if (keyCode == RIGHT && screen == 2)
    {
      hero1DisplayX+=250+width/2;
      hero2DisplayX+=250+width/2;
      hero3DisplayX+=250+width/2;
    }
    if (keyCode == LEFT && screen == 1)
    {
      map1DisplayX-=250+width/2;
      map2DisplayX-=250+width/2;
      map3DisplayX-=250+width/2;
    }
    if (keyCode == RIGHT && screen == 1)
    {
      map1DisplayX+=250+width/2;
      map2DisplayX+=250+width/2;
      map3DisplayX+=250+width/2;
    }
    if (keyCode == UP && screen == 3)
    {
      camUp = 1;
    }
    if (keyCode == DOWN && screen == 3) 
    {
      camDown = 1;
    }
    if (keyCode == LEFT && screen == 3) 
    {
      camLeft = 1;
    }
    if (keyCode == RIGHT && screen == 3) 
    {
      camRight = 1;
    }
  }
  if (keyCode == ENTER && screen == 1)
  {
    m.checkMap();
    screen = 2;
  }
  if (keyCode == SHIFT && screen == 2)
  {
    h.checkHero();
    screen = 3;
  }
  if (keyCode == TAB)
  {
    pos.x = 0;
    pos.y = 0;
    screen = 5;
    scr.reset();
  }
}
class Background
{
  Background()
  {
  }
  public void draw()
  {
    colorMode(HSB);
    strokeWeight(1);
    for (int i=0; i<Ballcount; i++)
    {
      fill(255);
      noStroke();
      Xs[i]=Xs[i]+5*BounceX[i];
      Ys[i]=Ys[i]+5*BounceY[i];
      Color[i]=Color[i]+1;
      if (Color[i]>255)
      {
        Color[i]=0;
      }

      if (Xs[i]>width-circlesize/2)
      {
        BounceX[i]=-BounceX[i];
      }
      if (Xs[i]<circlesize/2)
      {
        BounceX[i]= -BounceX[i];
      }
      if (Ys[i]>height-circlesize/2)
      {
        BounceY[i]= -BounceY[i];
      }
      if (Ys[i]<circlesize/2)
      {
        BounceY[i]= -BounceY[i];
      }

      for (int j=0; i<Ballcount*2; j++)
      {
        if (dist(Xs[i], Ys[i], Xs[j], Ys[j])<=250)
        {
          stroke(Color[i], 255, 255);
          fill(Color[i], 255, 255);
          line(Xs[i], Ys[i], Xs[j], Ys[j]);
        }
        if ( i == j)
        {
          break;
        }
        if (dist(Xs[i], Ys[i], Xs[j], Ys[j])<=circlesize+1)
        {
          BounceX[i]= -BounceX[i];
          BounceY[i]= -BounceY[i];
          BounceX[j]= -BounceX[j];
          BounceY[j]= -BounceY[j];
        }
      }
    }
    strokeWeight(50);
    colorMode(RGB);
  }
}
class Camera
{
  Camera() 
  {
    pos = new PVector(0, 0);
  }

  public void draw()
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
  public void checklocation()
  {
  }
}
class Collision
{
  Collision()
  {
  }
  public void checkMap()
  {
    loadPixels();
    posColour = get((int)width/2, (int)height/2);
    println(blue(posColour));
    if (blue(posColour) == 162)
    {
      speed = 1.5f;
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
    velocity = new PVector(100,100);
    vel = new PVector(0,0);
    Speed = 2;
    startingLocation = new PVector(location.x, location.y);
  }

  public void update()
  {

    PVector cam = new PVector(pos.x-width/2, pos.y-height/2);
    PVector dir = PVector.sub(cam, location);
    dir.normalize();
    dir.mult(0.5f);
    acceleration = dir;
    velocity.add(acceleration);
    velocity.limit(Speed);
    location.add(velocity);
    location.add(vel);
  }

  public void enemy()
  {
    fill(0, 255, 0);
    stroke(0, 255, 0, 50);
    ellipse(location.x, location.y, 50, 50);
  }
  public void checkCollision()
  {
    for (int i = 0; i < Enemys.length; i++)
    {
      if (dist(pos.x-width/2, pos.y-height/2, location.x, location.y)<50)
      {
        pos.x = 0;
        pos.y = 0;
        screen = 4;
      }
    }
  }

  public void enemyReset()
  {
    location.x = startingLocation.x;
    location.y = startingLocation.y;
  }
  public void checkEnemy()
  {
    for (int i = 0; i < Enemys.length; i++)
    {
      for (int j = 0; j < Enemys.length; j++)
      {
        Enemy e1 = Enemys[i];
        Enemy e2 = Enemys[j];
        if(dist(e1.location.x,e1.location.y,e2.location.x,e2.location.y)<50)
        {
          e1.bump(e2.location);
          e2.bump(e1.location);
        }
      }
    }
  }
  public void bump(PVector e)
  {
    PVector bumpDir = new PVector(20000*(location.x-e.x),20000*(location.y-e.y));
    bumpDir.setMag(2);
    vel = bumpDir;
  }
}
class Hero
{
  Hero()
  {
  }
  public void checkHero()
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
  public void draw()
  {
    translate(width/2, height/2);
    stroke(HeroR, HeroG, HeroB, 50);
    fill(HeroR, HeroG, HeroB);
    ellipse(pos.x, pos.y, 50, 50);
  }
}
class Maps
{
  Maps()
  {
  }
  public void checkMap()
  {
    switch(MapChoice)
    {
    case 0:
      Map = loadStrings("map1.txt");
      break;

    case 1:
      Map = loadStrings("map3.txt");
      break;

    case 2:
      Map = loadStrings("map2.txt");
      break;

    default:
      break;
    }
  }
  public void draw()
  {
    for (int i = 0; i<gridsize; i++)
    {
      for (int j = 0; j<gridsize; j++)
      {
        switch(Map[j].charAt(i))
        {
        case '0':
          MapR = 5;
          MapG = 59;
          MapB = 0;
          break;

        case '1':
          MapR = 0;
          MapG = 47;
          MapB = 162;
          break;

        case '2':
          MapR = 67;
          MapG = 67;
          MapB = 67;
          break;

        case '3':
          MapR = 196;
          MapG = 150;
          MapB = 0;
          break;

        case '4':
          MapR = 229;
          MapG = 177;
          MapB = 2;
          break;

        case '5':
          MapR = 28;
          MapG = 28;
          MapB = 28;
          break;

        case '6':
          MapR = 255;
          MapG = 0;
          MapB = 0;

        default:
          break;
        }
        fill(MapR, MapG, MapB); 
        stroke(MapR, MapG, MapB);
        rect((i*rectsize)-2000, (j*rectsize)-2000, rectsize, rectsize);
      }
    }
  }
}
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
  public void loadScreen()
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
  public void mapSelect()
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
    text("Press enter", 216.5f, height/2);
    text("to confirm your choice", 216.5f, height/2+20);
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
  public void heroSelect()
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
    text("Press shift", 216.5f, height/2);
    text("to confirm your choice", 216.5f, height/2+20);
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
  public void game()
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
  public void deathScreen()
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
  public void lvlcomplete()
  {
  }
  public void homeScreen()
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
  public void reset()
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
  public void settings() {  fullScreen();  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "Unit1_UnitProject" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
