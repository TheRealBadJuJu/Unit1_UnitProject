class Maps
{
  Maps()
  {
  }
  void checkMap()
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
  void draw()
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