import ddf.minim.*;

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
int Ballcount = (int)random(20, 50);
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
int randomInsultDeath;
int randomInsultCom;
String InsultCom;
String InsultDeath;
int posColour;
int enemycount = 100;
int enemyCount;
float[] EnemyposX = new float[enemycount];
float[] EnemyposY = new float[enemycount];
Enemy[] Enemys = new Enemy[enemycount];
Minim minim;
AudioPlayer song;
AudioPlayer song2;

void setup()
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
  smooth();
  fullScreen();
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

void draw()
{
  float time = millis();
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
    time = 0;
    scr.heroSelect();
  }
  if (screen == 3)
  {
    if (time>60000)
    {
      randomInsultCom = (int)random(6);
      screen = 6;
    }
    c.checkMap();
    scr.game();
  }
  if (screen == 4)
  {
    scr.deathScreen();
  }
  if (screen == 5)
  {
    screen = 1;
    //scr.homeScreen();
  }
  if (screen == 6)
  {
    scr.lvlcomplete();
  }
}

void keyReleased()
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

void keyPressed()
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