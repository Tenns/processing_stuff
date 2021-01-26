  
import processing.sound.*;
SoundFile file;

void setup() {
  size(600, 600);
  background(255);
  frameRate(55);
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "tick.mp3");
  file.play();
  
  float increment = 0.02;
  
  loadPixels();
  float xoff = 0.0; // Start xoff at 0
  noiseDetail(3, 0.5);
  for (int x = 0; x < width; x++){
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    
    for(int y = 0; y < height; y++){
      
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff, yoff) * 255 - 80;
      bright = bright * 255/130;
            
      // Try using this line instead
      //float bright = random(0,255);
      
      pixels[x+y*width] = color(bright);
    }
    
  }
  
  updatePixels();
  
  
}      



void draw() { 
  loadPixels();

  for (int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){

      if(((mouseX == x) && (mouseY == y)) && (brightness(pixels[x+y*width])/255 + randomGaussian()*0.3 ) > 0.75){
         file.play();
        
      }
    }
  }
  
  updatePixels();
}
