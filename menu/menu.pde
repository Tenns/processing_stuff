int num = 0;
int s = 20;
int y = 1;

void setup() {
  size(640, 480);
  background(204);
  rectMode(CENTER);
  stroke(0);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  
}

void mouseClicked() { 
  num++;
  
  while ((y*s*1.5) < width) {
    y++;
  }
}

void draw() {
  background(204);
  stroke (0);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  fill(0);
  textAlign(CENTER);
  textSize(14);
  text("num_w = " + y, width/2, height-20);
  
  int level = 1;
  int num_c = 0;
  int f = 255;
  float i_c;
  
  
  for (int i = 1; i < num; i++) {
    
    // gradient 
    if (f > 10) {
      f = f - 10;
    } else {
      f = 255;
    }
    fill(f);
    
    float y_c = s;
    
    // new line of boxes wip
    if ((num*s*1.5)>(width)) { //if more than one row 
      if ((i*s*1.5)>(width)) { // in second row when 2 rows

        
        y_c = level*2.5*s; // to be changed to get vertical margin on multiple levels and get more than 2 rows
        //console.log(num_w)
        num_c = num - y;
        i_c = i - y +0.5  ; // why is not centered ? (shouldn't have to add .5)
        
      } else { // in first row of 2 row 
      
        //console.log(num_w)
        
        num_c = y ;
        i_c = i;
        
      }
    } else { // if only one row
    
      num_c = num;
      i_c = i;
      
    }
    
    float x_c = width/2  -(num_c*s*1.5)/2 +i_c*s*1.5;   
    
    float newX = x_c-s/2;
    float newY = y_c-s/2;
    
    // hover (vewy noice)
    if ((mouseX > newX) && (mouseX < newX+s) && (mouseY > newY) && (mouseY < newY+s)) {
      fill(137, 211, 255);
      stroke(237, 247, 170);
    }
    
    
    
    rect(x_c, y_c, s, s);
    
    fill(255, 0, 0);
    textSize(10);
    text(f, x_c, y_c +4);
    
    stroke(0);
  }
  
} 
