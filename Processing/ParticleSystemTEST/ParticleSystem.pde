import java.util.Iterator;

class ParticleSystem
{
  ArrayList<Particle> particles;
  PVector origin;
  int max;
  int perFrame;
  
  
  ParticleSystem(PVector origin_, int max_, int perFrame_)
  {
    origin = origin_.copy();
    max = max_;
    perFrame = perFrame_;
    
    particles = new ArrayList<Particle>();
  }
  
  void addParticle()
  {
    particles.add(new Particle(origin));
  }
  
  void exe()
  {
    if(particles.size() < max - perFrame)
    {
      for(int i=0; i<perFrame; i++)
        addParticle();
    }
    
    Iterator<Particle> it = particles.iterator();
    
    while(it.hasNext())
    {
      Particle p = it.next();
      p.exe();
      
      if(p.isDead())
        it.remove();
    }
  }
}