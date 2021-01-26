final int INTERVAL = 10;

void setup()
{
  noStroke();
  size(500,500);
  smooth();
  background(0);
  rectMode(RADIUS);
}

void draw()
{
  translate(0, height/2);
  //if (frameCount % 1 == 0){
    int r = int(random(0, 255));
    int g = int(random(0, 255));
    int b = int(random(0, 255));
    
    fill(r, g, b);
    rect(width+49, 0, 50, height);
  //}
  
  //if (frameCount > 480){
    // Scroll one line of pixels per frame
    loadPixels();
    for(int i=0; i <= pixels.length; i++){
     if( i % width != 0){
       pixels[i-1] = pixels[i];
     }  
    }
    updatePixels();
    println("Shifting");
  //}
}
