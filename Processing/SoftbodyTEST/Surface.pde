class Surface
{
  ArrayList<Vec2> surface;
  
  Surface()
  {
    surface = new ArrayList<Vec2>();
    float j = random(100);
    for(int x=0; x<700; x++)
    {
      surface.add(new Vec2(x, map(noise(j), 0, 1, 300, height)));
      j += 0.003;
    }
    
    ChainShape chain = new ChainShape();
    
    Vec2[] vertices = new Vec2[surface.size()];
    
    for(int i=0; i<vertices.length; i++)
    {
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }
    
    chain.createChain(vertices, vertices.length);
    
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);
  }
  
  void display()
  {
    strokeWeight(1);
    stroke(200);
    noFill();
    
    beginShape();
    for(Vec2 v: surface)
      vertex(v.x, v.y);
    endShape();
  }
}