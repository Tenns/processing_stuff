import processing.video.*;
int x;
Capture cam;

void setup() {
  size(1280, 360);
  frameRate(60);
  String[] cameras = Capture.list();
  x = width/2;
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
    cam = new Capture(this, cameras[32]);
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

  if( frameCount % 5 == 0) {
    loadPixels();
    for(int i=1; i <= cam.pixels.length; i++){
     if( i % cam.width == cam.width/2){
       pixels[x + int(i/cam.width)*width] = cam.pixels[i];
     }  
    }
    if(x+1 < width){
      x++;
    } else {
      x = width/2;
      background(0);
    }
    updatePixels();
    circle(50, 50, 25);
  }
    line(width/4 - 1, 0, width/4 - 1, height);
    line(width/4 + 1, 0, width/4 + 1, height);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}
