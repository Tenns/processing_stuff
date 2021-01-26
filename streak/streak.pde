void setup(){
  size(400, 400);
  loadPixels();
  for (int i= 0; i< pixels.length; i++){
    if( i % width == 0){
      pixels[i] = color(255, 0, 0); 
    }
  }
  updatePixels();
}
