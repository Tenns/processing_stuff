int n = 999999999 ;

int s = 0;
int j = 1;

for(int i = 1; i <= n; i++){ // < --> <=  
  while( (j % 5 != 0) && (j % 7 != 0)){
    j = j+1;
    //println("j " + j);
  }
  s = s+j;
  j = j+1; // added this line
  //println("s " + s);
}

println(s);
