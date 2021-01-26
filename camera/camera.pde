import processing.video.*;
int x;
Capture cam;

void setup() {
  size(640, 360, P2D);
  frameRate(60);
  rectMode(CENTER);
  
  String[] cameras = Capture.list();
  x = width/2;
  noSmooth();
  stroke(255, 0, 0);
  fill(255, 0, 0);
  strokeWeight(1);
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i],"|",i);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[67]);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  cam.loadPixels();
  cam.updatePixels();
  
  //loadPixels();
  //klingemannBlur(4);
  
  
  
  //screenLinez();
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  //image(cam, 640, 0);

}

void linez(int[] storedPixels, int y, int factor){
  noFill();
  beginShape();                  //shape related
  float[] line = new float[width];
  
  for (int i = 0; i< line.length; i++){
    float displacement = (brightness(storedPixels[y*width+i]) / 255) * factor;
    //println(i, y + displacement);
    
    //rect(i, y, 1, displacement);   // if you want lines of constant width, then comment this line out
                                   // and enable shape related lines
    vertex(i, y - displacement); //shape related
  }
  endShape(OPEN);                //shape related
}

void screenLinez() {
  stroke(255);
  //strokeWeight(3);
  loadPixels();

  klingemannBlur(4);
  
  int[]storedPixels = new int[pixels.length];
  arrayCopy(pixels, storedPixels);
  
  background(0);
  for (int y= 0; y < height ; y += 10){
    linez(storedPixels, y, 10);
  }  
  
}

void klingemannBlur(int radius) {
  if (radius<1) {
    return;
  }
  loadPixels();
  int w=width;
  int h=height;
  int wm=w-1;
  int hm=h-1;
  int wh=w*h;
  int div=radius+radius+1;
  int r[]=new int[wh];
  int g[]=new int[wh];
  int b[]=new int[wh];
  int rsum, gsum, bsum, x, y, i, p, p1, p2, yp, yi, yw;
  int vmin[] = new int[max(w,h)];
  int vmax[] = new int[max(w,h)];
  int[] pix=pixels;
  int dv[]=new int[256*div];
  for (i=0;i<256*div;i++) {
    dv[i]=(i/div);
  }
  yw=yi=0;
  for (y=0;y<h;y++) {
    rsum=gsum=bsum=0;
    for(i=-radius;i<=radius;i++) {
      p = pix[yi+min(wm,max(i,0))];
      rsum+=(p & 0xff0000)>>16;
      gsum+=(p & 0x00ff00)>>8;
      bsum+= p & 0x0000ff;
    }
    for (x=0;x<w;x++) {
      r[yi]=dv[rsum];
      g[yi]=dv[gsum];
      b[yi]=dv[bsum];
      if(y==0) {
        vmin[x]=min(x+radius+1,wm);
        vmax[x]=max(x-radius,0);
      }
      p1=pix[yw+vmin[x]];
      p2=pix[yw+vmax[x]];
      rsum+=((p1 & 0xff0000)-(p2 & 0xff0000))>>16;
      gsum+=((p1 & 0x00ff00)-(p2 & 0x00ff00))>>8;
      bsum+= (p1 & 0x0000ff)-(p2 & 0x0000ff);
      yi++;
    }
    yw+=w;
  }
  for (x=0;x<w;x++) {
    rsum=gsum=bsum=0;
    yp=-radius*w;
    for(i=-radius;i<=radius;i++) {
      yi=max(0,yp)+x;
      rsum+=r[yi];
      gsum+=g[yi];
      bsum+=b[yi];
      yp+=w;
    }
    yi=x;
    for (y=0;y<h;y++) {
      pix[yi]=0xff000000 | (dv[rsum]<<16) | (dv[gsum]<<8) | dv[bsum];
      if(x==0) {
        vmin[y]=min(y+radius+1,hm)*w;
        vmax[y]=max(y-radius,0)*w;
      }
      p1=x+vmin[y];
      p2=x+vmax[y];
      rsum+=r[p1]-r[p2];
      gsum+=g[p1]-g[p2];
      bsum+=b[p1]-b[p2];
      yi+=w;
    }
  }
}
