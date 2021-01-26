class Pile_structure implements Entity
{
  Element[] elements;
  float x;
  float y;
  float element_x_offset;
  boolean animation_playing;
  float alpha;
  int alpha_i;
  float delta_alpha;
  int type;
  
  Pile_structure(int size, float x, float y, int type)
  {
    elements = new Element[size];

    this.x = x;
    this.y = y;

    animation_playing = false;
    element_x_offset = 0;
    alpha = 255;
    delta_alpha = 0;
  }

  @Override
  void update()
  {
    if (animation_playing)
    {
      // Movement
      element_x_offset = update_offset(element_x_offset, 5);

      // Fading
      alpha += delta_alpha;
      if (delta_alpha < 0)
      {
        if (alpha <= 0)
        {
          elements[alpha_i] = null; // remove the car now
          animation_playing = false;
          alpha = 255;
          delta_alpha = 0;
        }
      }
      else if (delta_alpha > 0)
      {
        if (alpha >= 255)
        {
          animation_playing = false;
          alpha = 255;
          delta_alpha = 0;
        }
      }
    }
  }

  float update_offset(float offset, float speed)
  {
    if (offset < 0)
    {
      offset += speed;
      if (offset >= 0)
      {
        offset = 0;
        animation_playing = false;
      }
    }
    else if (offset > 0)
    {
      offset -= speed;
      if (offset <= 0)
      {
        offset = 0;
        animation_playing = false;
      }
    }

    return offset;
  }

  @Override
  void draw()
  {
    draw_pile(0, 0);
    draw_elements(element_x_offset, 0);
    
  }

  void draw_pile(float x_offset, float y_offset)
  {
    // We'll be using 32px per car + 4px between each cars
    c = color(255);
    fill(c);
    rect(x + x_offset, y + y_offset, elements.length * 32 + (elements.length + 1) * 20, 12);
  }

  void draw_elements(float x_offset, float y_offset)
  {
    float element_x = 8;
    for (int i = 0; i < elements.length; i++)
    {
      Element element = elements[i];
      if (element != null)
      {
        push();
        if (animation_playing && i == alpha_i)
        {
          stroke(#000000, alpha);
          fill(#ffffff, alpha);
        }
        
        element.draw(x + element_x + x_offset, y + y_offset - 34);
        pop();
      }

      element_x += 40;
    }
  }

  void element_enter(Element element)
  {
    element_enter(element, 0);
  }

  void element_enter(Element element, int i)
  {
    if (elements[i] == null && !animation_playing)
    {
      // Put the car at the first spot
      elements[i] = element;

      // Start the animation
      animation_playing = true;
      alpha = 0;
      alpha_i = i;
      delta_alpha = 20;
    }
  }

  Element element_leave()
  {
    return element_leave(elements.length - 1);
  }

  Element element_leave(int i)
  {
    if (elements[i] != null && !animation_playing)
    {
      // Start the animation
      // The car will be removed from the array at the end of it
      animation_playing = true;
      alpha = 255;
      alpha_i = i;
      delta_alpha = -20;
    }

    return elements[i];
  }

  void move_elements_left()
  {
    if (elements[0] == null && !animation_playing)
    {
      // Move the cars in the array
      for (int i = 0; i < elements.length - 1; i++)
      {
        elements[i] = elements[i + 1];
      }

      elements[elements.length - 1] = null;

      // Start the animation
      animation_playing = true;
      element_x_offset = 36;
    }
  }

  void move_elements_right()
  {
    if (elements[elements.length - 1] == null && !animation_playing)
    {
      // Move the element to the right
      for (int i = elements.length - 1; i > 0; i--)
      {
        elements[i] = elements[i - 1];
      }

      elements[0] = null;

      
      animation_playing = true;
      element_x_offset = -36;
    }
  }

  void move_element_from(Pile_structure source)
  {
    move_element_from(source, source.elements.length - 1, 0);
  }

  void move_element_from(Pile_structure source, int source_i, int dest_i)
  {
    if (source.elements[source_i] != null && elements[dest_i] == null && !source.animation_playing && !animation_playing)
    {
      element_enter(source.element_leave(source_i), dest_i);
    }
  }
}
