class Cube
{
  color[] colors;
  float w;
  float x;
  float y;
  float z;
  float rot_x;
  float rot_y;
  float rot_z;
  float rot_x_par;
  float rot_y_par;
  float rot_z_par;
  
  int id;
  
  
  Cube(String c, float _w, float _x, float _y, float _z)
  {
    if(c.length() != 6)
      exit();
      
    colors = new color[6];
    w = _w;
    x = _x;
    y = _y;
    z = _z;
    rot_x = 0;
    rot_y = 0;
    rot_z = 0;
    rot_x_par = 0;
    rot_y_par = 0;
    rot_z_par = 0;
      
    c = c.replace("o", "0");
    c = c.replace("w", "1");
    c = c.replace("b", "2");
    c = c.replace("y", "3");
    c = c.replace("g", "4");
    c = c.replace("r", "5");
    c = c.replace("n", "6");
    
    for(int i=0; i<6; i++)
      colors[i] = uc[Integer.valueOf(String.valueOf(c.charAt(i)))];
  }
  
  
  void update()
  {
    float sval = 5;
    
    if(rot_x_par != 0)
    {
      if(rot_x_par > 0)
      {
        rot_x += sval;
        rot_x_par -= sval;
      }
      
      if(rot_x_par < 0)
      {
        rot_x -= sval;
        rot_x_par += sval;
      }
    }
    
    if(rot_y_par != 0)
    {
      if(rot_y_par > 0)
      {
        rot_y += sval;
        rot_y_par -= sval;
      }
      
      if(rot_y_par < 0)
      {
        rot_y -= sval;
        rot_y_par += sval;
      }
    }
    
    if(rot_z_par != 0)
    {
      if(rot_z_par > 0)
      {
        rot_z += sval;
        rot_z_par -= sval;
      }
      
      if(rot_z_par < 0)
      {
        rot_z -= sval;
        rot_z_par += sval;
      }
    }
  }
  
  
  void display(float rb_x, float rb_y, float rb_z, float rb_rot_x, float rb_rot_y)
  {
    pushMatrix();
    
    translate(rb_x, rb_y, rb_z);
    rotateX(radians(rot_x + rb_rot_x));
    rotateY(radians(rot_y + rb_rot_y));
    rotateZ(radians(rot_z));
    
    float v = w/2;
    stroke(10);
    strokeWeight(5);
    beginShape(QUADS);
    fill(colors[0]);
    vertex(-v+x, -v+y, -v+z);
    vertex(-v+x, -v+y,  v+z);
    vertex( v+x, -v+y,  v+z);
    vertex( v+x, -v+y, -v+z);
    
    fill(colors[1]);
    vertex(-v+x,  v+y, -v+z);
    vertex(-v+x,  v+y,  v+z);
    vertex(-v+x, -v+y,  v+z);
    vertex(-v+x, -v+y, -v+z);
    
    fill(colors[2]); 
    vertex(-v+x, -v+y, v+z);
    vertex(-v+x,  v+y, v+z);
    vertex( v+x,  v+y, v+z);
    vertex( v+x, -v+y, v+z);
    
    fill(colors[3]);
    vertex(v+x,  v+y,  v+z);
    vertex(v+x, -v+y,  v+z);
    vertex(v+x, -v+y, -v+z);
    vertex(v+x,  v+y, -v+z);
    
    fill(colors[4]); 
    vertex(-v+x, -v+y, -v+z);
    vertex(-v+x,  v+y, -v+z);
    vertex( v+x,  v+y, -v+z);
    vertex( v+x, -v+y, -v+z);
    
    fill(colors[5]);
    vertex(-v+x,  v+y, -v+z);
    vertex(-v+x,  v+y,  v+z);
    vertex( v+x,  v+y,  v+z);
    vertex( v+x,  v+y, -v+z);
    endShape();
    
    popMatrix();
  }
}