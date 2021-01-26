
void setup(){
  size(16,16);
  readPPM("dich.ppm");

}

void readPPM(String filename) {
  String[] lines = loadStrings(filename);
  int count= 0;
  
  println(lines[0]);
  
    println("cool");
  
  //int w = int(lines[2].substring(0,2));
  //int h = int(lines[2].substring(3)); 
  //println(lines[0].substring(0,2));

  if ( "P3".equals(lines[0]) ){
    for (int i = 4 ; i < lines.length; i = i + 3) {
      int r = int(lines[i]);
      int g = int(lines[i+1]);
      int b = int(lines[i+2]);
      
      int col = count%width;
      int row = (count-col)/width;
      count ++;
      
      stroke(r,g,b);
      point(col, row);
    }
      
  } else { 
    if ("P0".equals(lines[0]) ) {
      for (int i = 4;i < lines.length; i ++){
        int level = int(lines[i]);
          
        int col = count%width;
        int row = (count-col)/width;
        count ++;
      
        stroke(level);
        point(col, row);
      }
    } 
  }
}
