PImage bg;
color c;
// Entities
Entity[] entities;
Pile_structure b1;
Lift lift;
Pile_structure exit;
Pile_structure[] pile = new Pile_structure[6];
Button new_uranium_button;
Button new_cadmium_button;
Button b1_move_button;
Button b1_out_button;
Button lift_left_button;
Button lift_right_button;
Button lift_up_button;
Button lift_down_button;
Button lift_out_button;
Button exit_right_button;
Button exit_leave_button;
Button[] pile_out_buttons = new Button[6];
Button[] pile_left_buttons = new Button[6];
Button[] pile_right_buttons = new Button[6];

void setup()
{
  // Window setup
  size(800, 800);
  bg = loadImage("background.jpg");
  frameRate(60);
  
  // Pile
  b1 = new Pile_structure(2, 280, 580, 0);
  lift= new Lift(1, b1.x + 140, 580, 0);
  exit = new Pile_structure(2, lift.x + 100, 580, 0);
  
  pile[5] = new Pile_structure(2, lift.x + 100, 100, 0);
  pile[4] = new Pile_structure(2, pile[5].x, pile[5].y + 80, 0);
  pile[3] = new Pile_structure(2, pile[5].x, pile[4].y + 80, 0);
  pile[2] = new Pile_structure(2, pile[5].x, pile[3].y + 80, 0);
  pile[1] = new Pile_structure(2, pile[5].x, pile[2].y + 80, 0);
  pile[0] = new Pile_structure(2, pile[5].x, pile[1].y + 80, 0);

  
  // b1 buttons
  new_uranium_button = new Button("New Uranium", b1.x - 140, b1.y - 20, 100);
  new_cadmium_button = new Button("New Cadmium", new_uranium_button.x, new_uranium_button.y + 20, 100);
  b1_move_button = new Button("→", b1.x + 67, b1.y + 20, 16);
  b1_out_button = new Button("Out", b1_move_button.x + b1_move_button.w + 4, b1_move_button.y, 36);
  
  // Lift buttons
  
  lift_up_button = new Button("↑", b1.x + 10, b1.y - 120, 40);
  lift_down_button = new Button("↓", lift_up_button.x, lift_up_button.y + 20, 40);
  lift_out_button = new Button("In", lift_up_button.x + 40, lift_up_button.y + 8, 40);
  
  // Exit buttons
  exit_right_button = new Button("→", exit.x, exit.y + 20, 16);
  exit_leave_button = new Button("Out", exit_right_button.x + 20, exit_right_button.y, 40);
  
  // Pile buttons
  for (int i = 0; i < 6; i++)
  {
    pile_out_buttons[i] = new Button("Out", pile[i].x, pile[i].y + 20, 36);
    pile_left_buttons[i] = new Button("←", pile[i].x + 130, pile[i].y - 10, 16);
    pile_right_buttons[i] = new Button("→", pile_left_buttons[i].x + 16, pile_left_buttons[i].y, 16);
  }
  
  
  // Entity list for update and drawing
  entities = new Entity[]
  {
    b1, lift, exit, pile[0], pile[1], pile[2], pile[3], pile[4], pile[5],
    new_uranium_button, new_cadmium_button, b1_move_button, b1_out_button,
    lift_up_button, lift_down_button, lift_out_button,
    exit_right_button, exit_leave_button,
    pile_out_buttons[0], pile_out_buttons[1], pile_out_buttons[2], pile_out_buttons[3], pile_out_buttons[4], pile_out_buttons[5],
    pile_left_buttons[0], pile_left_buttons[1], pile_left_buttons[2], pile_left_buttons[3], pile_left_buttons[4], pile_left_buttons[5],
    pile_right_buttons[0], pile_right_buttons[1], pile_right_buttons[2], pile_right_buttons[3], pile_right_buttons[4], pile_right_buttons[5],
 
  };
}

void draw()
{
  background(bg);
  c = color(#333333);
  fill(c);
  rect(lift_up_button.x - 12, lift_up_button.y - 10 , 120, 60);
  for (Entity entity : entities)
  {
    entity.update();
  }
  
  for (Entity entity : entities)
  {
    entity.draw();
  }
  
}

void mouseReleased()
{
  if (mouseButton == LEFT)
  {
    // Entrance buttons
    if (new_uranium_button.contains(mouseX, mouseY))
    {
      b1.element_enter(new Element("uranium"));
    }
     else if (new_cadmium_button.contains(mouseX, mouseY))
    {
      b1.element_enter(new Element("cadmium"));
    }
    else if (b1_move_button.contains(mouseX, mouseY))
    {
      b1.move_elements_right();
    }
    else if (b1_out_button.contains(mouseX, mouseY))
    {
      if (lift.level == 0)
      {
        lift.move_element_from(b1);
      }
    }
    
    // Elevator buttons
    else if (lift_up_button.contains(mouseX, mouseY))
    {
      lift.move_up();
    }
    else if (lift_down_button.contains(mouseX, mouseY))
    {
      lift.move_down();
    }
    else if (lift_out_button.contains(mouseX, mouseY))
    {
      switch (lift.level)
      {
        case 0:
          exit.move_element_from(lift);
          break;
        
        case 5: case 4: case 3: case 2: case 1: 
          pile[lift.level - 1].move_element_from(lift);
          break;
        case 6: 
          break;
      }
    }
    
    // Exit buttons
    else if (exit_right_button.contains(mouseX, mouseY))
    {
      exit.move_elements_right();
    }
    else if (exit_leave_button.contains(mouseX, mouseY))
    {
      exit.element_leave();
    }
    
    else
    {
      // Parkings buttons
      for (int i = 0; i < 6; i++)
      {
        if (pile_out_buttons[i].contains(mouseX, mouseY))
        {
          if (lift.level == i+1)
          {
            lift.move_element_from(pile[i], 0, 0);
            break;
          }
        }
        else if (pile_left_buttons[i].contains(mouseX, mouseY))
        {
          pile[i].move_elements_left();
          break;
        }
        else if (pile_right_buttons[i].contains(mouseX, mouseY))
        {
          pile[i].move_elements_right();
          break;
        }
      }
    }
  }
}
