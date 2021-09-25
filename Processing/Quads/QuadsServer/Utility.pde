
float Width = 800;
float Height = 600;
float my_leading;


float rele(float v, String mod)
{
  float perc;
  float new_val;

  if (mod.equals("h"))
  {
    perc = v * 100 / Width;
    new_val = perc * width / 100;
  } 
  else
  {
    perc = v * 100 / Height;
    new_val = perc * height / 100;
  }

  return new_val;
}


int textHeight(String str, int specificWidth) 
{
  float leading = my_leading;
  // split by new lines first
  String[] paragraphs = split(str, "\n");
  int numberEmptyLines = 0;
  int numTextLines = 0;
  for (int i=0; i < paragraphs.length; i++) 
  {
    // anything with length 0 ignore and increment empty line count
    if (paragraphs[i].length() == 0) {
      numberEmptyLines++;
    } else
    {      
      numTextLines++;
      // word wrap
      String[] wordsArray = split(paragraphs[i], " ");
      String tempString = "";

      for (int k=0; k < wordsArray.length; k++)
      {
        if (textWidth(tempString + wordsArray[k]) < specificWidth)
          tempString += wordsArray[k] + " ";
        else 
        {
          tempString = wordsArray[k] + " ";
          numTextLines++;
        }
      }
    }
  }

  float totalLines = numTextLines + numberEmptyLines;
  return round(totalLines * leading);
}

color getColor(int v)
{
  switch(v)
  {
    case 0:
      return color(255, 255, 255);
    
    case 1:
      return color(255, 0, 0);
    
    case 2:
      return color(240, 140, 30);
    
    case 3:
      return color(255, 255, 0);
    
    case 4:
      return color(0, 255, 0);
    
    case 5:
      return color(0, 0, 255);
    
    case 7:
      return color(150, 0, 200);
    
    default:
      return color(0);
  }
}