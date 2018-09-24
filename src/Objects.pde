////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
// Class for Ninja player object

class Ninja {

  int xPos, yPos;
  int dx, dy;
  float size, time, speedVar;
  boolean move, stop;
  int speed, strokeWeight, ninPath, deaccel;
  color strokeColour;
  gBox gBox;

  
  // Inital Constructor  

  Ninja(int tXpos, int tYpos, float unit) {

    xPos = tXpos;
    yPos = tYpos;
    size = unit;
    dx = 0;
    dy = 0;
    move = false;
    speed = 6;    //Inital Speed
    stop = false;
    strokeColour = color(0);
    strokeWeight = 1;
    ninPath = 0;
    speedVar = 1;
    deaccel = 2;
  }
  
  
  // Respawn Constructor  

  Ninja(int tXpos, int tYpos, int tdx, int tdy, int tninPath, int tSpeed, float unit, float tSpeedVar) {

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
    speedVar = tSpeedVar;
    deaccel = 2;
  }

  void direction(gBox center, gBox adj) {


    if (move && ((adj.on == true) && isAdj(center, adj) != 0)) { //|| (adj.gSpawn == true && endPathCheck(center) > 1))) {

      //center.on = false;                        //Turns off selected paths
      center.nSpawn = false;
      
      //speedVar += 0.5;
      
      //if (center.boost == false && speed > 1 && speedVar % 1 == 0){
      //  speed -= 2;
      //}
      
      if (speed <= 1) {
        speed = 1;
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
      xPos = int(center.box.getParam(0));
      yPos = int(center.box.getParam(1));
    }
    

  }

  void splitPath( gBox center, gBox adj) {

    if (move && isAdj(center, adj) != 0 && ((adj.on == true && isPermissable(center) >= 1) || adj.gSpawn == true)) { 
      //Condition to save data of a new Decoy
      
      
      int Dx = 0;
      int Dy = 0;


      if (isAdj(center, adj) == 1) { //Left
        Dx = -speed;
        Dy = 0;
        yPos = int(center.box.getParam(1));
        
      } else if (isAdj(center, adj) == 2) { //Right
        Dx = speed;
        Dy = 0;
        yPos = int(center.box.getParam(1));
        
      } else if (isAdj(center, adj) == 3) { //Up
        Dx = 0;
        Dy = -speed;
        xPos = int(center.box.getParam(0));
    
      } else if (isAdj(center, adj) == 4) { //Down
        Dx = 0;
        Dy = speed;
        xPos = int(center.box.getParam(0));
     
      }

      
      Ninja substitute = new Ninja(int(center.box.getParam(0)), int(center.box.getParam(1)), Dx, Dy, ninPath, speed, unit, speedVar);  //Creates a new "Ninja" Substitute
      substitute.move = true;
      


      decoys.add(substitute); //Saves copy to the storage array.
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

  void endSave() { //Saves when all Stop

    if (stop == false) {

      time = millis();
      stop = true;
    }
  }
  
  void counterChecker(gBox center) {
    
    if (gBox != center) {
      ninPath ++;
      speed = speed - deaccel;
      center.on = false;
      gBox = center;
      
    }

    
  }


  void display(int i) {
    // Temporary Rectangle Display until I get some form of Animation or sprite.
    xPos = xPos + dx; //Co -ordinate movements
    yPos = yPos + dy;
    //fill(0);
    //text(i, xPos, yPos); 
    //println(i, move);
    
    if (menuState == 1) {
    if(winCondition() > 0 && allNinjasStop()) {
    
    if (this.time == score.minTime) {
      this.strokeWeight = 5;
      this.strokeColour = color(0, 255, 0);
    } else if (clan.get(i).time == score.maxTime) {

     this.strokeWeight = 5;
     this.strokeColour = color(255, 0, 0);
         
     } 
    }
    
  }
       
     
     else {
          
       this.strokeWeight = 1;
       this.strokeColour = color(0);
        
      }
      
    
    strokeWeight(strokeWeight);
    stroke(strokeColour);
    fill(0);
    rect(xPos, yPos, size, size);
    
    if(winCondition() > 0 && allNinjasStop() && menuState == 1) {
    menuText(str(ninPath), 255, xPos + size/2, yPos + size/2, size, size);
    }
    
    
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
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

  //void display() {
  //  // Temporary Rectangle Display until I get some form of Animation or sprite.
  //  strokeWeight(1);
  //  stroke(0);
  //  fill(255, 0, 0);
  //  rect(xPos, yPos, size, size);
  //}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
//Grid box
class gBox {

  PShape box;
  boolean on, boost;
  boolean nSpawn, gSpawn, blockage;
  int boostSpeed, ghostBoost, ghostNum;
  
  int numAssist;


  gBox (int x, int y, int size) {
    on = false; //For toggleing the grid
    nSpawn = false; //Check for spawn of the Ninja
    gSpawn = false; //Check for spawn of the Guard
    blockage = false;
    box = createShape(RECT, x, y, size, size);
    box.setStroke(0);
    box.setStrokeWeight(1);
    boost = false;
    boostSpeed = 0;
    numAssist = 0;
    ghostBoost = -1;
  }
  
  void numberAssistant (gBox other) { //Calculates the numbers
    
    if (mouseWithinGrid(box, unit) && isPermissable(this) == 1){
    
    if (isAdj(this, other) != 0 && (other.on == true || other.nSpawn == true)) { // && other.numAssist < this.numAssist) {
            
      if (other.nSpawn) {
        numAssist = 2;
      }
      else {
      numAssist = other.numAssist + 1;
      
      }

  }
 
    }
    
    
    //if (isAdj(this, other) != 0 && this.gSpawn && other.on && other.numAssist != 0 && (this.numAssist > other.numAssist || this.numAssist == 0) && winCondition() == false) { 
       
       
       
       
    //   this.numAssist = other.numAssist + 1;
       
    //    }
    
    
     //if(isAdj(this, other) != 0 && other.gSpawn && on) {
       
     //  other.numAssist = numAssist + 1;
     // }
     
        
     //if (isPermissable(this) == 0 || (on == false && isPermissable(this) == 1 && gSpawn == false)) {
     //numAssist = 0;
    //}   
 
}
  
  
  
  void numberDisplay() {
    
    if (numAssist > 0) { // || clan.get(clan.size() - 1).move == false) {
    //fill(0);
    //fontSize("99", width/8, height/8);
    menuText(str(numAssist), 0, box.getParam(0) + box.getParam(2)/2, box.getParam(1) + box.getParam(3)/2, box.getParam(2), box.getParam(3) );
    //text(numAssist, box.getParam(0) + unit/2, box.getParam(1) + 6*unit/8); 
    
    }
  }
          
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
//Boost Box

class boost {
  float xPos, yPos;
  float size; 
  int type, nindX, nindY;
  int charge, chargeNum;
  //float startTime;
  boolean remove, startCharge, howToPlay;
  color chargeColour;
  int counter, speed;
  
  boost(float txPos, float tyPos, float tsize, int tType) {
    xPos = txPos;
    yPos = tyPos;
    size = tsize;
    //startTime = millis();
    charge = 0;
    remove = false;
    nindX = 0;
    nindY = 0;
    type = tType;
    
    if (tType == 1) {
      chargeNum = 3;
      chargeColour = colours[13];
      speed = 5;
    }
    
    if (tType == 2) {
      chargeNum = 6;
      chargeColour = colours[14];
      speed = 7;
    }
    
    if (tType == 3) {
      chargeNum = 10;
      chargeColour = colours[4];
      speed = 10;
    }
    
    howToPlay = false;
    counter = 0;
  }
  
  boost(float txPos, float tyPos, float tsize, int tType, boolean thowToPlay) {
    xPos = txPos;
    yPos = tyPos;
    size = tsize;
    //startTime = millis();
    charge = 0;
    remove = false;
    nindX = 0;
    nindY = 0;
    type = tType;
    
    if (tType == 1) {
      chargeNum = 3;
      chargeColour = colours[13];
      speed = 5;
    }
    
    if (tType == 2) {
      chargeNum = 6;
      chargeColour = colours[14];
      speed = 7;
    }
    
    if (tType == 3) {
      chargeNum = 10;
      chargeColour = colours[4];
      speed = 10;
    }
    
    howToPlay = thowToPlay;
    counter = 0;
    
  }
  
  //Method for Charging
  void charging(gBox center, Ninja Genji) {
    
      
      if (Genji.xPos < xPos + Genji.speed && Genji.xPos > xPos - Genji.speed && 
        Genji.yPos > yPos - Genji.speed && Genji.yPos < yPos + Genji.speed) {
          
          nindX = Genji.dx;
          nindY = Genji.dy;
          Genji.speed = Genji.dx = Genji.dy = 0;
          //startTime = millis();
          startCharge = true;
          Genji.xPos = int(xPos);
          Genji.yPos = int(yPos);
        }
    
    if (center.box.getParam(0) == xPos && center.box.getParam(1) == yPos && center.boost == false && clan.get(0).move == false) {
      remove = true;
    }
   
    if ((startCharge && Genji.xPos == xPos && Genji.yPos == yPos) || howToPlay) {
      
      
    if (charge*size / chargeNum > size && howToPlay == false) {
      remove = true;
      
      if (nindX > 0) {
        Genji.dx = speed;
      }
      
      if (nindY > 0) {
        Genji.dy = speed;
      }
      
      if (nindX < 0) {
        Genji.dx = -speed;
      }
      
      if (nindY < 0) {
        Genji.dy = -speed;
      }
      
      Genji.speed = speed;
    }
    
    else if (charge*size / chargeNum > size && howToPlay) {
      charge = 0;
    }
    
    //else if ((millis() - startTime < 1500 && millis() - startTime > 1000)) {
    //  charge ++;
    //  startTime = millis();
      
    //}
    
    else if ( counter == int(size/(chargeNum+1) * type)) {
      charge ++;
      counter = 0;
      
    }
    
    
    
    }
    
  }
  
  void chargeAssist() {
    if (startCharge || howToPlay) {
    counter++;
    //println(counter);
  }
  }
  
  //Method for Displaying
   void display(){
     
     
    
    for( float i = yPos; i + size/chargeNum <= yPos + size; i += size/chargeNum){
        
       if ( i + size/chargeNum <= yPos + size - charge*size/chargeNum){ 
        fill(255);
      }
      else {
        fill(chargeColour);
      }
      rect(xPos, i, size, size/chargeNum);
  }
  
}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
//Buttons

class Button {

  PShape box;
  String label;
  color buttonColour, textColour;
  int buttonNum;

  Button (float txPos, float tyPos, float txSize, float tySize, color tButtonC, color tTextC, String tLabel) { //Standard Constructor

    buttonColour = tButtonC;
    box = createShape(RECT, txPos, tyPos, txSize, tySize);
    textColour = tTextC;
    label = tLabel ;
    buttonNum = 0;
  
   }
   
   Button (float txPos, float tyPos, float txSize, float tySize, color tButtonC, color tTextC, String tLabel, int tButtonNum) { //Boost Button Constructor

    buttonColour = tButtonC;
    box = createShape(RECT, txPos, tyPos, txSize, tySize);
    textColour = tTextC;
    label = tLabel ;
    buttonNum = tButtonNum;
  
   }

  void display() {

   //box.setTint(false);
    box.setFill(buttonColour);
    shape(box);
    fill(textColour);    //Puts the text in the center of the rectangular button, with the specified colour and size
    fontSize(label, box.getParam(2), box.getParam(3));
    //textSize(textSize);
    float xCord = box.getParam(0) + box.getParam(2)/2;
    float yCord = box.getParam(1) + box.getParam(3)/2;
    text(label, xCord, yCord);
  }
  
  void display(int boost) {
    
    
    box.setFill(buttonColour);
    shape(box);
    fill(textColour);     //Puts the text in the center of the rectangular button, with the specified colour and size
    
    fontSize(label, box.getParam(2), box.getParam(3));
    float xCord = box.getParam(0) + box.getParam(2)/2;
    float yCord = box.getParam(1) + box.getParam(3)/2;
    
    //println(boost, buttonNum);
    text(label, xCord, yCord);
    
    if (boost == buttonNum) {
     box.setStroke(textColour);
     box.setStrokeWeight(9);
    }
    
    else {
      box.setStroke(0);
      box.setStrokeWeight(1);
    }
    
  }
  
  void display(boolean numAssist) {
    
    box.setFill(buttonColour);
    shape(box);
    fill(textColour);                                            //Puts the text in the center of the rectangular button, with the specified colour and size
    fontSize(label, box.getParam(2), box.getParam(3));
    float xCord = box.getParam(0) + box.getParam(2)/2;
    float yCord = box.getParam(1) + box.getParam(3)/2;
    
    if (numAssist){
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

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
//Score Object

class scoreSaver {
  
  float time;
  float minTime, maxTime;
  int distance;
  int totalDistance;
  int numOfBoosts;
  int offBy;
  
  
  scoreSaver() {
    
    time = -1.0;
    distance = -1;
    totalDistance = -1;
    numOfBoosts = 0;
    minTime = -1;
    maxTime = -1;
    offBy = -1;
    
  }
    
    //Method that Calculates the time of the puzzle. It returns the time of the puzzle and returns the best time of the puzzle.
    void scoreCalculator() {
      
      minTime = clan.get(0).time;
      maxTime = clan.get(0).time;
      int minPath = clan.get(0).ninPath, maxPath = clan.get(0).ninPath, boostNum = 0;
      

      for (int i = clan.size() - 1; i >= 0; i--) {  //Calculates the Minimum and Maximum time it took to get there


        if (clan.get(i).time < minTime) {


          minTime = clan.get(i).time;
          minPath = clan.get(i).ninPath;
        } else if (clan.get(i).time > maxTime) {


          maxTime = clan.get(i).time;
          maxPath = clan.get(i).ninPath;
        }
      }
      
      for (gBox i : Grid) {
        if (i.ghostBoost > 0 && i.ghostBoost < 4) {
          boostNum++;
        }
      }


      distance = abs(maxPath - minPath);
      time = (maxTime - minTime)/1000;
      totalDistance = maxPath;
      numOfBoosts = boostNum;
      
      
      
    
    }
    
    //Prints properties to the console
    void getProperties() {
      
      println("Distance is " + distance);
      println("Time is " + time);
      println("Total Distance is " + totalDistance);
      println("Num Of Boosts is " + numOfBoosts);
      println("**********************************************");
      
      
    }
      
    
    
    //Saves data for the lowest values collected.... will need priority?
    void bestScore ( scoreSaver other) {
      
      if( other.distance < this.distance ) {
        other.distance = this.distance ;
      }
      
      if( other.time < this.time ) {
        other.time = this.time;
      }
      
      if( other.totalDistance < this.totalDistance ) {
        other.totalDistance = this.totalDistance;
      }
      
      if( other.numOfBoosts < this.numOfBoosts ) {
        other.numOfBoosts = this.numOfBoosts;
      }
      
      
    }
  
    //Saves data for previous puzzle
    void saveLastPuzzle( scoreSaver other) {
      
      this.distance = other.distance ;
      this.time = other.time;
      this.totalDistance = other.totalDistance;
      this.numOfBoosts = other.numOfBoosts;
      
    }
    
    void displayScore(scoreSaver HighScore) {
      
      if( winCondition() == 1 && popUpMenu == false){
      
      menuText("Distance: " + str(distance), 0, 0.15* width, 0.1 * height, width/5, 0.1 * height);
      menuText("Time: " + str(time), 0, 0.375 * width, 0.1 * height, width/5, 0.1 * height);
      menuText("Total Distance: " + str(totalDistance), 0, 0.625 * width, 0.1 * height, width/5, 0.1 * height);
      menuText("Number of Boosts: " + str(numOfBoosts), 0, 0.85 * width, 0.1 * height, width/5, 0.1 * height);
       
       if (distance == 0) {
         menuText("PERFECT", color(random(255), random(255), random(255)), width/2, height/2, width/2, height/12);
       }
       
    }
    
    if (winCondition() == 1 && popUpMenu) {
      
    pushStyle();
    rectMode(CENTER);
    
    
    stroke(0);
    strokeWeight(1);
    //Background box to add some shade
    fill( color(0, 100));
    rect(width/2, height/2, width, height);
    
    fill(255);
    rect(width/2, height/2, width, 0.4 * height);
    
    popStyle();
    
    //Current Score
    menuText("Distance: " + str(distance), 0, 0.15* width, 0.4 * height, width/5, 0.1 * height);
    menuText("Time: " + str(time), 0, 0.375 * width, 0.4 * height, width/5, 0.1 * height);
    menuText("Total Distance: " + str(totalDistance), 0, 0.625 * width, 0.4 * height, width/5, 0.1 * height);
    menuText("Number of Boosts: " + str(numOfBoosts), 0, 0.85 * width, 0.4 * height, width/5, 0.1 * height);
    
    //HighScore
    
    //Temporary if statement until I decide how to get best score
    
    if (HighScore.distance != -1 && HighScore.time != -1.0 && HighScore.totalDistance != -1){
    menuText("Previous", 0, width/2, 0.5 * height, 0.2 * width, 0.1 * height);
    menuText("Distance: " + str(HighScore.distance), 0, 0.15* width, 0.6 * height, width/5, 0.1 * height);
    menuText("Time: " + str(HighScore.time), 0, 0.375 * width, 0.6 * height, width/5, 0.1 * height);
    menuText("Total Distance: " + str(HighScore.totalDistance), 0, 0.625 * width, 0.6 * height, width/5, 0.1 * height);
    menuText("Number of Boosts: " + str(HighScore.numOfBoosts), 0, 0.85 * width, 0.6 * height, width/5, 0.1 * height);
    }
    
    }
    
    if (winCondition() == 2) {
   
      if (offBy == 1) {
         menuText( "You are off by " + str(offBy) + " square", 0, width/2, height/15, 0.6 * width, 0.1 * height);
      }
      
      else{
      menuText( "You are off by " + str(offBy) + " squares", 0, width/2, height/15, 0.6 * width, 0.1 * height);
      }
      
    }
    
    if (winCondition() == -1) {
       menuText( "Try splitting your paths!", 0, width/2, height/15, 0.6 * width, 0.1 * height);
    }

}

}
