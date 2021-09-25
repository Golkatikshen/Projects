class DirObject
{
  int id;
  String name;
  String full_path;
  
  DirObject(String _name, String _full_path, int _id)
  {
    if(_name.length() > off_name_length)
      name = _name.substring(0, off_name_length);
    else
      name = _name;
      
    full_path = _full_path;
    id = _id;
  }
  
  DirObject(String _name, String _full_path)
  {
    if(_name.length() > 20)
      name = _name.substring(0, 20);
    else
      name = _name;
      
    full_path = _full_path;
  }
}