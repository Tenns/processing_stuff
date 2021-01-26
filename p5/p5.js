var x1 = 0;
var x2 = 0;
var r1 = 0;
var r2 = 0;
var t1 = 0;
var t2 = 0;
var loose = 0;

function setup() { 
  createCanvas(400, 400);
} 

function draw() { 
  if (loose == 0) {
   background (0);
   translate(width/2, height);
   r1 = random(0.001, 5);
   r2 = 1/r1;
   t1 = random(0.001, 5);
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

function mouseClicked() {
    if (mouseX < width/2) {
    x1 = 0;
    }
    else{
    x2 = 0;
    }
  }
