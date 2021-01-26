class Element
{
  String type;
  
  Element(String temp_type){
    type = temp_type;
  }
  
  void draw(float x, float y)
  {
    if (type == "uranium"){
      c = color(0, 255, 0);
    }
    else if(type == "cadmium"){
      c = color(255, 204, 102);
    }
    else{
      c = color(255);
    }
    fill(c);
    rect(x + 12, y + 10, 30, 30);

  }
}
