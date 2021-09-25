import java.io.File;
import java.util.Date;
import javax.swing.*;
import java.lang.*;

String path;
int W_FILES = 6;
int off_name_length = 20;
int w_space_length = 300;
int off_w = 20;
int off_h = 25;

void setup()
{
  size(2000, 2828);
  textFont(createFont("Consolas", 20));
  
  String[] cmds = loadStrings("config.txt");
  for(int i=0; i<cmds.length; i++)
    cmds[i] = dopoSpazio(cmds[i]);
  
  path = cmds[0];
  W_FILES = Integer.parseInt(cmds[1]);
  off_name_length = Integer.parseInt(cmds[2]);
  w_space_length = Integer.parseInt(cmds[3]);
  off_w = Integer.parseInt(cmds[4]);
  off_h = Integer.parseInt(cmds[5]);
}

String dopoSpazio(String s)
{
  for(int i=0; i<s.length(); i++)
    if(s.charAt(i) == ' ')
      return s.substring(i+1, s.length());
      
  return null;
}

void draw()
{
  background(255);
  fill(0);
  displayDirs(path, 5, 20);
  saveFrame("lista.png");
  exit();
  noLoop();
}

int displayDirs(String dir, int w, int h)
{
  //init;
  int id_f = 1;
  File file = new File(dir);
  String names[] = file.list();
  ArrayList<DirObject> Fobjs = new ArrayList();
  ArrayList<DirObject> Dobjs = new ArrayList();
  for(int i=0; i<names.length; i++)
  {
    File f = new File(dir+"\\"+names[i]);
    if(f.isDirectory())
      Dobjs.add(new DirObject(names[i], dir+"\\"+names[i]));
    else
    {
      Fobjs.add(new DirObject(names[i], dir+"\\"+names[i], id_f));
      id_f ++;
    }
  }
  
  text("*"+file.getName(), w, h);
  h += off_h;
  w += off_w;
  
  //files rap;
  int n_ceil = ceil((float)Fobjs.size() / W_FILES);
  int w_temp = w;
  int h_temp = h;
  
  for(int i=0; i<Fobjs.size(); i+=n_ceil)
  {
    for(int j=0; j<n_ceil; j++)
    {
      if(i+j >= Fobjs.size())
        break;
        
      text(Fobjs.get(i+j).id +". " + Fobjs.get(i+j).name, w, h);
      h += off_h;
    }
    h = h_temp;
    w += w_space_length;
  }
  
  for(int i=0; i<n_ceil; i++)
    h += off_h;
    
  w = w_temp;
  
  if(Dobjs.size() > 0)
  {
    for(int i=0; i<Dobjs.size(); i++)
      h = displayDirs(Dobjs.get(i).full_path, w, h);
    
    return h;
  }
  else
    return h;
}


void showDirs(String dir, String spaces)
{
  //println(dir);
  File file = new File(dir);
  if (file.isDirectory()) 
  {
    println(spaces+"*"+file.getName());
    String names[] = file.list();
    for(int i=0; i<names.length; i++)
      showDirs(dir+"\\"+names[i], spaces+"  ");
  }
  else 
    println(spaces+file.getName());
}

/*void setup() {

  // Path
  String path = "C:\\Users\\Ale\\Music";

  println("Listing all filenames in a directory: ");
  String[] filenames = listFileNames(path);
  println(filenames);
  
  println("\nListing info about all files in a directory: ");
  File[] files = listFiles(path);
  for (int i = 0; i < files.length; i++) {
    File f = files[i];    
    println("Name: " + f.getName());
    println("Is directory: " + f.isDirectory());
    println("Size: " + f.length());
    String lastModified = new Date(f.lastModified()).toString();
    println("Last Modified: " + lastModified);
    println("-----------------------");
  }
  
  println("\nListing info about all files in a directory and all subdirectories: ");
  ArrayList<File> allFiles = listFilesRecursive(path);
  
  for (File f: allFiles) {
    println("Name: " + f.getName());
    println("Full path: " + f.getAbsolutePath());
    println("Is directory: " + f.isDirectory());
    println("Size: " + f.length());
    String lastModified = new Date(f.lastModified()).toString();
    println("Last Modified: " + lastModified);
    println("-----------------------");
  }

  noLoop();
}

// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()
void draw() {

}

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list of all files in a directory and all subdirectories
ArrayList<File> listFilesRecursive(String dir) {
   ArrayList<File> fileList = new ArrayList<File>(); 
   recurseDir(fileList,dir);
   return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a,subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}*/

/* 
File folder;
String [] filenames;
 
void setup()
{
  java.io.File folder = new java.io.File("C:\\Users\\Ale\\Music\\Alan Walker\\");
  filenames = folder.list();
}
 
void draw()
{
  println(filenames.length + " elements");
 
  for(int i=0; i<filenames.length; i++)
  {
    println(filenames[i]);
  }
  
  noLoop();
}*/