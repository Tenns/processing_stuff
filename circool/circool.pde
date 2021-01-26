float i = 0;
float r = 0;
float h = 0;

  void setup() {
   size(400, 400);
   stroke (255);
   background (0);
  }
  
  void draw() {
    
   colorMode(HSB);
   stroke (h, 255, 255);
   translate(width/2, height/2);
   fill(h, 255, 255);
   
   ellipse(0, 0, r, r);
   r = r + 4;
   
   if (r>400) {
     
     if (h < 256) {
     h = h+20; 
     }
     else {
       h = 0;
     }
     stroke (h);
     
     r = 0;
     ellipse(0, 0, i, i);
   }
  }
  

/*  void circle(float ray) {
    ellipse(0, 0, ray, ray);
    float ray = ray + 1 ;
    if (ray > 200) {
    circle(0);
    }
    
  }
*/
