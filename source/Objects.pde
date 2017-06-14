////////////////////////////////////////////////////
// Class for Ninja player object

class Ninja {

  int xPos, yPos;
  int dx, dy;
  float size, time;
  boolean move, stop;
  int speed, strokeWeight, ninPath;
  color strokeColour;

  // First Constructor  

  Ninja(int tXpos, int tYpos, int tdx, int tdy, int tninPath, int tSpeed, float unit) {

    xPos = tXpos;
    yPos = tYpos;
    size = unit;
    dx = tdx;
    dy = tdy;
    move = false;
    speed = tSpeed;
    stop = false;
    strokeColour = color(0);
    strokeWeight = 1;
    ninPath = tninPath;
  }

  void direction(gBox center, gBox adj) {


    if (move && ((adj.on == true) && isAdj(center, adj) != 0)) { //|| (adj.gSpawn == true && endPathCheck(center) > 1))) {


      center.on = false;                        //turns off selected paths
      center.nSpawn = false;
      
      if (center.boost){
        speed = 5;
      }
      
      else if (center.boost == false){
        speed = 1;
      }
      

      if (adj.gSpawn) {
        ninPath ++;
      }

      if (isAdj(center, adj) == 1) { //Left
        dx = -speed;
        dy = 0;
      } else if (isAdj(center, adj) == 2) { //Right
        dx = speed;
        dy = 0;
      } else if (isAdj(center, adj) == 3) { //Up
        dx = 0;
        dy = -speed;
      } else if (isAdj(center, adj) == 4) { //Down
        dx = 0;
        dy = speed;
      }
    }
    if (center.gSpawn || endPathCheck(center) == false || move == false) {    //Stops the ninja
      center.on = false;
      dx = dy = 0;
      move = false;
      endSave();
    }
    
   //center.boost = false;
  }

  void splitPath( gBox center, gBox adj) {

    if (move && isAdj(center, adj) != 0 && ((adj.on == true && isPermissable(center) >= 1) || adj.gSpawn == true)) { 
      //Condition to save data of a new Decoy
      


      int Dx = 0;
      int Dy = 0;


      if (isAdj(center, adj) == 1) { //Left
        Dx = -speed;
        Dy = 0;
      } else if (isAdj(center, adj) == 2) { //Right
        Dx = speed;
        Dy = 0;
      } else if (isAdj(center, adj) == 3) { //Up
        Dx = 0;
        Dy = -speed;
      } else if (isAdj(center, adj) == 4) { //Down
        Dx = 0;
        Dy = speed;
      }

      int add = 1;
      if (adj.gSpawn) {
        add = 0;
      }


      Ninja substitute = new Ninja(int(center.box.getParam(0)), int(center.box.getParam(1)), Dx, Dy, ninPath + add, speed, unit);  //Creates a new "Ninja" Substitute
      substitute.move = true;


      decoys.add(substitute); //Saves copy to the storage array.

      if (adj.gSpawn) {
        ninPath --;
      }
    }
  }


  boolean endPathCheck(gBox center) {    //Checks if the Ninja is at a Dead End
    int counter= 0;
    for (gBox g : Grid) {
      if (isAdj(center, g) != 0 && (g.on == true || g.gSpawn == true)) {
        counter++;
      }
    }

    if (counter > 0) {
      return true;
    } else {
      return false;
    }
  }

  void endSave() { //Saves when all Stop?

    if (stop == false) {

      time = millis();
      stop = true;
    }
  }


  void display(int i) {
    // Temporary Rectangle Display until I get some form of Animation or sprite.
    xPos = xPos + dx; //Co -ordinate movements
    yPos = yPos + dy;
    //fill(0);
    //text(ninPath, xPos, yPos); 
    strokeWeight(strokeWeight);
    stroke(strokeColour);
    fill(0);
    rect(xPos, yPos, size, size);
    
  }
}

////////////////////////////////////////////////////
// Class Guard Enemy Object

class Guard { 

  int xPos;
  int yPos;
  int size;

  // First Constructor  

  Guard( int tXpos, int tYpos, int unit) {

    xPos = tXpos;
    yPos = tYpos;
    size = unit;
  }

  void display() {
    // Temporary Rectangle Display until I get some form of Animation or sprite.
    strokeWeight(1);
    stroke(0);
    fill(255, 0, 0);
    rect(xPos, yPos, size, size);
  }
}

////////////////////////////////////////////////////
//Grid box
class gBox {

  PShape box;
  boolean on, boost;
  boolean nSpawn, gSpawn;


  gBox (int x, int y, int size) {
    on = false; //For toggleing the grid
    nSpawn = false; //Check for spawn of the Ninja
    gSpawn = false; //Check for spawn of the Guard
    box = createShape(RECT, x, y, size, size);
    boost = false;
  }
}

////////////////////////////////////////////////////
//Buttons

class Button {

  PShape box;
  String label;
  color buttonColour, textColour;
  int textSize;

  Button(float txPos, float tyPos, float txSize, float tySize, color tButtonC, color tTextC, int tTextS, String tLabel) {


    buttonColour = tButtonC;
    box = createShape(RECT, txPos, tyPos, txSize, tySize);
    textColour = tTextC;
    textSize = tTextS;
    label = tLabel ;
  }

  void display() {

   //box.setTint(false);
    box.setFill(buttonColour);
    shape(box);
    fill(textColour);                                            //Puts the text in the center of the rectangular button, with the specified colour and size
    textSize(textSize);
    float xCord = box.getParam(0) + box.getParam(2)/2;
    float yCord = box.getParam(1) + box.getParam(3)/2;
    text(label, xCord, yCord);
  }
  
  void display(boolean boost) {
    
   //box.setTint(false);
    box.setFill(buttonColour);
    shape(box);
    fill(textColour);                                            //Puts the text in the center of the rectangular button, with the specified colour and size
    textSize(textSize);
    float xCord = box.getParam(0) + box.getParam(2)/2;
    float yCord = box.getParam(1) + box.getParam(3)/2;
    if (boost){
    text(label + ": On", xCord, yCord);
    }
    else {
      text(label + ": Off", xCord, yCord);
    }
    
  }
  
  void displayTri() {
    
    float x = box.getParam(0);
    float y = box.getParam(1);
    float Width = box.getParam(2);
    float Height = box.getParam(3);
    
    
    box.setFill(buttonColour);
    shape(box);
    stroke(textColour);
    strokeWeight(4);
    fill(buttonColour);
    
    if (label == "Left" || label == "left") {
      
      triangle( x + Width/20, y + Height/2, 
            (x + Width) - Width/20, y + Height/20,
            (x + Width) - Width/20, (y + Height) - Height/20);
      
    }
    
    if (label == "Right" || label == "right") {
      
      triangle( (x + Width) - Width/20, y + Height/2, 
            (x + Width/20), y + Height/20,
            (x + Width/20), (y + Height) - Height/20);
    }
    
    stroke(0);
    strokeWeight(1);
    
  }

  boolean buttonTrue() {

    boolean result = false;

    if (mouseX > box.getParam(0) && mouseX < box.getParam(0) + box.getParam(2) ) {   //Boundary Check for the button
      if (mouseY > box.getParam(1) && mouseY < box.getParam(1) + box.getParam(3)) {
        result = true;
      }
    }
    return result;
  }
}

////////////////////////////////////////////////////
//Colour Picker taken from Proccessing Website

 class ColourPicker 
{
  int x, y, Width, Height, c;
  PImage cpImage;
  
   ColourPicker ( int x, int y, int Width, int Height, int c )
  {
    this.x = x;
    this.y = y;
    this.Width = Width;
    this.Height = Height;
    this.c = c;
    
    cpImage = new PImage( Width, Height );
    
    init();
  }
  
  void init ()
  {
    // draw color.
    int cw = Width - Width/6;
    for( int i=0; i<cw; i++ ) 
    {
      float nColorPercent = i / (float)cw;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      int nColor = nR | nG | nB;
      
      //Top Gradient
      setGradient( i, 0, Height/2, 0xFFFFFF, nColor );
      //Bottom Gradient
      setGradient( i, (Height/2), Height/2, nColor, 0x000000 );
    }
    
    
    // draw grey scale.
    for( int j=0; j<Height; j++ )
    {
      int g = 255 - (int)(j/(float)(Height-1) * 255 );
      stroke(color(g));
      line(x + Width, j, x + Width, j);
      drawRect( Width - Width/6, j, Width/6, 1, color( g, g, g ) );
    }
  }

 void setGradient(int x, int y, float Height, int c1, int c2 )
  {
    
    //Color Ranges
    float deltaR = red(c2) - red(c1);  
    float deltaG = green(c2) - green(c1);
    float deltaB = blue(c2) - blue(c1);

    for (int j = y; j < (y + Height); j++)
    {
      int c = color( red(c1) + (j-y) * (deltaR/Height), green(c1)+ (j-y) * (deltaG/Height), blue(c1) + (j-y) * (deltaB/Height) );
      cpImage.set( x, j, c );
    
  }
  }
  
  void drawRect( int rx, int ry, int rw, int rh, int rc )
  {
    for(int i=rx; i<rx+rw; i++) 
    {
      for(int j=ry; j<ry+rh; j++) 
      {
        cpImage.set( i, j, rc );
      }
    }
  }
  
  color colourGet ()
  {
    if( mousePressed &&
  mouseX >= x && 
  mouseX < x + Width &&
  mouseY >= y &&
  mouseY < y + Height )
    {
      c = get( mouseX, mouseY );
    }
  return c;
  }
  
  void display() {
     image( cpImage, x, y );
  }
}