class RubiksCube
{
  Cube[] cubes;
  Cube[][][] c3x3;
  
  float x;
  float y;
  float z;
  float rot_x;
  float rot_y;
  
  boolean left, right, up, down;
  boolean moving;
  
  
  
  RubiksCube(float _x, float _y, float _z)
  {
    cubes = new Cube[27];
    c3x3 = new Cube[3][3][3];
    x = _x;
    y = _y;
    z = _z;
    rot_x = 0;
    rot_y = 0;

    cubes[0]  = new Cube("ownngn", 100, -100, -100, -100);
    cubes[1]  = new Cube("onnngn", 100, 0   , -100, -100);
    cubes[2]  = new Cube("onnygn", 100, +100, -100, -100);
    cubes[3]  = new Cube("ownnnn", 100, -100, -100, 0   );
    cubes[4]  = new Cube("onnnnn", 100, 0   , -100, 0   );
    cubes[5]  = new Cube("onnynn", 100, +100, -100, 0   );
    cubes[6]  = new Cube("owbnnn", 100, -100, -100, +100);
    cubes[7]  = new Cube("onbnnn", 100, 0   , -100, +100);
    cubes[8]  = new Cube("onbynn", 100, +100, -100, +100);
    
    cubes[9]  = new Cube("nwnngn", 100, -100, 0   , -100);
    cubes[10] = new Cube("nnnngn", 100, 0   , 0   , -100);
    cubes[11] = new Cube("nnnygn", 100, +100, 0   , -100);
    cubes[12] = new Cube("nwnnnn", 100, -100, 0   , 0   );
    cubes[13] = new Cube("nnnnnn", 100, 0   , 0   , 0   );
    cubes[14] = new Cube("nnnynn", 100, +100, 0   , 0   );
    cubes[15] = new Cube("nwbnnn", 100, -100, 0   , +100);
    cubes[16] = new Cube("nnbnnn", 100, 0   , 0   , +100);
    cubes[17] = new Cube("nnbynn", 100, +100, 0   , +100);
    
    cubes[18] = new Cube("nwnngr", 100, -100, +100, -100);
    cubes[19] = new Cube("nnnngr", 100, 0   , +100, -100);
    cubes[20] = new Cube("nnnygr", 100, +100, +100, -100);
    cubes[21] = new Cube("nwnnnr", 100, -100, +100, 0   );
    cubes[22] = new Cube("nnnnnr", 100, 0   , +100, 0   );
    cubes[23] = new Cube("nnnynr", 100, +100, +100, 0   );
    cubes[24] = new Cube("nwbnnr", 100, -100, +100, +100);
    cubes[25] = new Cube("nnbnnr", 100, 0   , +100, +100);
    cubes[26] = new Cube("nnbynr", 100, +100, +100, +100);
    
    
    for(int i=0; i<27; i++)
      cubes[i].id = i;
    
    for(int iy=0; iy<3; iy++)
      for(int iz=0; iz<3; iz++)
        for(int ix=0; ix<3; ix++)
          c3x3[ix][iy][iz] = cubes[(iy * 3 * 3) + (iz * 3) + ix];
  }
  
  void run()
  {
    for(int i=0; i<cubes.length; i++)
    {
      cubes[i].update();
      cubes[i].display(x, y, z, rot_x, rot_y);
    }
      
    rotateLogic();
  }
  
  
  
  
  
  void rotateLogic()
  {
    float vel = 1.2;
    
    if(left)
      rot_y -= vel;
    if(right)
      rot_y += vel;
    if(up)
      rot_x += vel;
    if(down)
      rot_x -= vel;
  }
  
  
  
  
  
  void O_rot()
  {
    Cube tmp = c3x3[0][0][0];
    c3x3[0][0][0] = c3x3[0][0][1];
    c3x3[0][0][1] = c3x3[0][0][2];
    c3x3[0][0][2] = c3x3[1][0][2];
    c3x3[1][0][2] = c3x3[2][0][2];
    c3x3[2][0][2] = c3x3[2][0][1];
    c3x3[2][0][1] = c3x3[2][0][0];
    c3x3[2][0][0] = c3x3[1][0][0];
    c3x3[1][0][0] = tmp;
  }
  
  void O()
  {
    for(int i=0; i<2; i++)
      O_rot();
      
    for(int iz=0; iz<3; iz++)
        for(int ix=0; ix<3; ix++)
          c3x3[ix][0][iz].rot_y_par -= 90;
  }
  
  void Oi()
  {
    for(int i=0; i<6; i++)
      O_rot();
      
    for(int iz=0; iz<3; iz++)
        for(int ix=0; ix<3; ix++)
          c3x3[ix][0][iz].rot_y_par += 90;
  }
  
  
  void W_rot()
  {
    Cube tmp = c3x3[0][0][0];
    c3x3[0][0][0] = c3x3[0][1][0];
    c3x3[0][1][0] = c3x3[0][2][0];
    c3x3[0][2][0] = c3x3[0][2][1];
    c3x3[0][2][1] = c3x3[0][2][2];
    c3x3[0][2][2] = c3x3[0][1][2];
    c3x3[0][1][2] = c3x3[0][1][1];
    c3x3[0][1][1] = c3x3[0][1][0];
    c3x3[0][1][0] = tmp;
  }
  
  void W()
  {
    for(int i=0; i<2; i++)
      W_rot();
      
    for(int iy=0; iy<3; iy++)
        for(int iz=0; iz<3; iz++)
          c3x3[0][iy][iz].rot_x_par -= 90;
  }
  
  void Wi()
  {
    for(int i=0; i<6; i++)
      W_rot();
      
    for(int iy=0; iy<3; iy++)
        for(int iz=0; iz<3; iz++)
          c3x3[0][iy][iz].rot_x_par += 90;
  }
  
  
  void B_rot()
  {
    Cube tmp = c3x3[0][0][2];
    c3x3[0][0][2] = c3x3[0][1][2];
    c3x3[0][1][2] = c3x3[0][2][2];
    c3x3[0][2][2] = c3x3[1][2][2];
    c3x3[1][2][2] = c3x3[2][2][2];
    c3x3[2][2][2] = c3x3[2][1][2];
    c3x3[2][1][2] = c3x3[2][0][2];
    c3x3[2][0][2] = c3x3[1][0][2];
    c3x3[1][0][2] = tmp;
  }
  
  void B()
  {
    for(int i=0; i<2; i++)
      B_rot();
      
    for(int iy=0; iy<3; iy++)
        for(int ix=0; ix<3; ix++)
          c3x3[ix][iy][2].rot_z_par += 90;
  }
  
  void Bi()
  {
    for(int i=0; i<6; i++)
      B_rot();
      
    for(int iy=0; iy<3; iy++)
        for(int ix=0; ix<3; ix++)
          c3x3[ix][iy][2].rot_z_par -= 90;
  }
  
  
  
  
  
  void rbkeyPressed()
  {
    if(key == CODED)
      if(keyCode == LEFT)
        left = true;
      else if(keyCode == RIGHT)
        right = true;
      else if(keyCode == UP)
        up = true;
      else if(keyCode == DOWN)
        down = true;
  }
  
  void rbkeyReleased()
  {
    if(key == CODED)
      if(keyCode == LEFT)
        left = false;
      else if(keyCode == RIGHT)
        right = false;
      else if(keyCode == UP)
        up = false;
      else if(keyCode == DOWN)
        down = false;
  }
  
  
  
  
  
  void printCubeGrid()
  {
    println("\n"+rot_x);
    println(cubes[0].rot_x + ", " + cubes[0].rot_y + ", " + cubes[0].rot_z);
    
    /*println("              " + fgc(c3x3[0][0][0].id) + " " + fgc(c3x3[1][0][0].id) + " " + fgc(c3x3[2][0][0].id));
    println("              " + fgc(c3x3[0][0][1].id) + " " + fgc(c3x3[1][0][1].id) + " " + fgc(c3x3[2][0][1].id));
    println("              " + fgc(c3x3[0][0][2].id) + " " + fgc(c3x3[1][0][2].id) + " " + fgc(c3x3[2][0][2].id));
    println();
    
    println(fgc(c3x3[0][0][0].id) + " " + fgc(c3x3[0][0][1].id) + " " + fgc(c3x3[0][0][2].id) + "   " + fgc(c3x3[0][0][2].id) + " " + fgc(c3x3[1][0][2].id) + " " + fgc(c3x3[2][0][2].id) + "   " + fgc(c3x3[2][0][2].id) + " " + fgc(c3x3[2][0][1].id) + " " + fgc(c3x3[2][0][0].id) + "   " + fgc(c3x3[2][0][0].id) + " " + fgc(c3x3[1][0][0].id) + " " + fgc(c3x3[0][0][0].id));
    println(fgc(c3x3[0][1][0].id) + " " + fgc(c3x3[0][1][1].id) + " " + fgc(c3x3[0][1][2].id) + "   " + fgc(c3x3[0][1][2].id) + " " + fgc(c3x3[1][1][2].id) + " " + fgc(c3x3[2][1][2].id) + "   " + fgc(c3x3[2][1][2].id) + " " + fgc(c3x3[2][1][1].id) + " " + fgc(c3x3[2][1][0].id) + "   " + fgc(c3x3[2][1][0].id) + " " + fgc(c3x3[1][1][0].id) + " " + fgc(c3x3[0][1][0].id));
    println(fgc(c3x3[0][2][0].id) + " " + fgc(c3x3[0][2][1].id) + " " + fgc(c3x3[0][2][2].id) + "   " + fgc(c3x3[0][2][2].id) + " " + fgc(c3x3[1][2][2].id) + " " + fgc(c3x3[2][2][2].id) + "   " + fgc(c3x3[2][2][2].id) + " " + fgc(c3x3[2][2][1].id) + " " + fgc(c3x3[2][2][0].id) + "   " + fgc(c3x3[2][2][0].id) + " " + fgc(c3x3[1][2][0].id) + " " + fgc(c3x3[0][2][0].id));
    println();
    
    println("              " + fgc(c3x3[0][2][2].id) + " " + fgc(c3x3[1][2][2].id) + " " + fgc(c3x3[2][2][2].id));
    println("              " + fgc(c3x3[0][2][1].id) + " " + fgc(c3x3[1][2][1].id) + " " + fgc(c3x3[2][2][1].id));
    println("              " + fgc(c3x3[0][2][0].id) + " " + fgc(c3x3[1][2][0].id) + " " + fgc(c3x3[2][2][0].id));*/
  }
  
  String fgc(int v)
  {
    if(v < 10)
      return (" 0" + v);
    else
      return(" " + v);
  }
}