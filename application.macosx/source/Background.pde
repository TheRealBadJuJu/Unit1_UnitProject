class Background
{
  Background()
  {
  }
  void draw()
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