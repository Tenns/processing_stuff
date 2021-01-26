float x1 = 0;
float x2 = 0;
float r1 = 0;
float r2 = 0;
float t1 = 0;
float t2 = 0;
int loose = 0;

  void setup() {
   size(400, 400);
   stroke (255);
  }
  
  void draw() {
    if (loose == 0) {
   background (0);
   translate(width/2, height);
   r1 = abs(randomGaussian()*5);
   r2 = 1/r1;
   t1 = abs(randomGaussian()*5);
   t2 = 1/t1;
   if (x1 < height) {
   x1 = x1 + r2;
   rectMode(RADIUS);
   rect(-100, 0, width/4, x1);
     }
   else {
     x1 = 0;
     loose ++;
     }
        if (x2 < height) {
   x2 = x2 + t2;
   rectMode(RADIUS);
   rect(100, 0, width/4, x2);
     }
   else {
     x2 = 0;
     loose++;
     }
   }
   else {
    background (0);
    textSize(30);
    text("you lose", width/2-50, height/2);
     }
  }
  void mouseClicked() {
    if (mouseX < width/2) {
    x1 = 0;
    }
    else{
    x2 = 0;
    }
  }
  
