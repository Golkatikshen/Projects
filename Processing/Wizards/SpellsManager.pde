class SpellsManager
{
  ArrayList<String> spells_names;
  ArrayList<ANNetwork> spells_ann;
  
  SpellsManager()
  {
    spells_names = new ArrayList();
    spells_ann = new ArrayList();
    
    for(int i=0; i<spells_names.size(); i++)
      spells_ann.add(new ANNetwork("ann_spells/"+spells_names.get(i)+".txt"));
  }
  
  
}