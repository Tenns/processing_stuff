float a = 0;
float r = 0;
PVector old = new PVector(0, 0);
PVector current = new PVector(0, 0);
int x = 0;

void setup() {
 frameRate(5);
 size(500,500); 
 background(0);
 stroke(255);
 strokeWeight(7);
 
 ellipseMode(RADIUS); 
 // Ask aurele or the internet, what is the best way to move array of pixels, 1 pixel to the left :) 
 // THIS SHIT FIIIIIXXEEED
}

void draw() {
  translate(width/2, height/2);
  current.set(r*cos(a),r*sin(a));

  float distance = dist(0, 0, 1000*current.x, 1000*current.y);
  point(0, distance);

  a = a + 0.01;
  r = r + 0.00003*frameCount;
    
  loadPixels();
  for(int k=0; k <= pixels.length; k++){
    if( k % width != 0){
      pixels[k-1] = pixels[k];
    }
  }
  updatePixels();
  println("Shifting");
}
