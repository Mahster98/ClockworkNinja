////////////////////////////////////////////////////
// Function that is the Double Click/Tap Functionality

void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2) {
    doubleClick();
  }
}

void onDoubleTap(float x, float y)
{
  doubleClick();
}



////////////////////////////////////////////////////
// A Function that builds a grid!

void createGrid( int Width, int Height, int size) {

  int buffer = 10; //Buffering is the area from the edge of the Screen. Need some sorta Autoformatting thing?

  Grid = new ArrayList<gBox>(); //Sets up the Grid - Global variable

  for ( int i = Width/buffer+ size; i < Width && i+size < Width - Width/buffer; i = i + size) {
    for (int j = Height/buffer + size; j < Height && j+size < Height - Height/buffer; j = j + size) {  //Creates the grid according to size of screen

      gBox grid = new gBox(i, j, size);
      Grid.add(grid);
    }
  }
} 

////////////////////////////////////////////////////
// A Function that builds a grid in the How to Play menu

void createGrid (int Width, int Height, int size, int yPos){
  
  stroke(0);
  int buffer = 20;
  
  Grid = new ArrayList<gBox>(); //Sets up the Grid - Global variable

  for ( int i = Width/buffer+ size; i < Width && i+size < Width - Width/buffer; i = i + size) {
    for (int j = yPos + unit/2; j < Height && j+size < Height - Height/buffer; j = j + size) {  //Creates the grid according to size of screen

      gBox grid = new gBox(i, j, size);
      grid.box.setStrokeWeight(1);
      Grid.add(grid);
    }
  }
  
}

////////////////////////////////////////////////////
// A Function to create all the buttons and puts them into an array

void createButtons() { 

  buttonList = new Button[17];

  //Move button
  buttonList[0] = new Button(0, height - height/5, width/2, height/5, colours[8], colours[9], 72, "Move");

  //Reset button
  buttonList[1] = new Button(width/2, height - height/5, width/2, height/5, colours[8], colours[9], 72, "Reset");

  //New Puzzle Button
  buttonList[2] = new Button(width - width/4, 0, width/4, height/5, colours[8], colours[9], 68, "New Puzzle");

  //Return to Main Menu Button

  buttonList[3] = new Button(0, 0, width/4, height/5, colours[8], colours[9], 68, "Main Menu");


  /////////////////////////////////
  //Menu buttons

  //Title
  buttonList[4] = new Button(width/4, height/3, width/2, height/4, color(#1d3461), 255, 72, "Clockwork Ninja");

  //Play Button
  buttonList[5] = new Button(0, 0, width/2, height/2, color(#bb0a21), 0, 68, "Play");

  //How to Play button

  buttonList[6] = new Button(width/2, 0, width/2, height/2, color(#252627), 255, 68, "How to Play");

  //Options Buttons

  buttonList[7] = new Button(0, height/2, width/2, height/2, color(#4b88a2), 0, 68, "Options");

  //Exit Button

  buttonList[8] = new Button(width/2, height/2, width/2, height/2, color(#318240), 0, 68, "Exit");
  
  ////////////////////////////////////////////////////////////////////////////////
  
  //Boost Button
  
  buttonList[9] = new Button(width/4, 0, width/2, height/5, colours[4], colours[10], 68, "Boost"); 
  
  /////////////////////////////////
  //Some Options Buttons
  
  //Color Selector Menu Button
  
  buttonList[10] = new Button( 1.25*width/5, height/4, width/2, height/5, color(#318240), 255, 68, "Colour Selector");
  
  //Credits Button
  
  buttonList[11] = new Button( 1.25*width/5, height/2, width/2, height/5, color(#318240), 255, 68, "Credits");
  
  //Back Button
  
  buttonList[12] = new Button(0, 5*height/6, width/10, height/6, color(#318240), 255, 68, "Left");
  
  //Colour Selector Save Button
  
  buttonList[13] = new Button( width/3, 5*height/6, width/3, height/6, color(#bb0a21), 0, 68, "Save");
  
  //Colour Selector Left Button
  
  buttonList[14] = new Button( width - width/4, height/2 - height/6, width/25, height/8, color(#318240), 255, 68, "Left");
  
  //Colour Selector Right Button
  
  buttonList[15] = new Button( width - width/12, height/2 - height/6, width/25, height/8, color(#318240), 255, 68, "Right");
  
  //Default Colours Button
  
  buttonList[16] = new Button (3 *width/4, 5*height/6, width/4, height/6, color(#4b88a2), 0, 68, "Default Settings");
  
}

////////////////////////////////////////////////////
// A Function for intial colours and storage of colours
void colourCreate() {

  colours = new color[11];
  
   //Almost Black
  colours[0] = color(#252627);
  
  //Light Blue
  colours[1] = color(#4b88a2);
  
  //Moss Green
  colours[2] = color(#318240);
  
  //Light Purple - Squares
  colours[3] = color(#565Cf2);
  
  //Deep blue color - The one for the Boost Square
  colours[4] = color(#1d3461);
  
  //Baby Blue - Squares
  colours[5] = color(#14EBFC);
  
  //Light Orange - Squares
  colours[6] = color(#FFA20A);
  
  //Dark Orange - Squares
  colours[7] = color(#FF7C0F);
  
  //Red colour
  colours[8] = color(#bb0a21);
  
  //Font colour for Pop Up Menu Button
  colours[9] = color(0);
  
  //Font colour for Boost Button
  colours[10] = color(255);
  
  
}

////////////////////////////////////////////////////
// A Function for displaying Background Images

void displayBackground(PImage background) {

  //Draws image into background
  for (int x = 0; x < width; x += background.width) {
    for (int y = 0; y < height; y += background.height) {
      image(background, x, y);
    }
  }
}

////////////////////////////////////////////////////
// A Function that returns true if on a certain part of the grid

boolean mouseWithinGrid(PShape node, float size) {


  float xMax = node.getParam(0) + size; //Max boundary - X
  float xMin = node.getParam(0);        //Min boundary - X
  float yMax = node.getParam(1) + size; //Max boundary - Y
  float yMin = node.getParam(1);        //Min boundary - Y

  if (mouseX > xMin  && mouseX < xMax && mouseY > yMin && mouseY < yMax) {
    return true;
  } else {
    return false;
  }
}

////////////////////////////////////////////////////
// A Function that returns true if Boxes are Adjacent
int isAdj(gBox center, gBox adjacent) {


  float pointX = center.box.getParam(0);
  float pointY = center.box.getParam(1);
  float xLeft = pointX - unit;
  float xRight = pointX + unit;
  float yUp = pointY - unit;
  float yDown = pointY + unit;
  float adjBoxX = adjacent.box.getParam(0);
  float adjBoxY = adjacent.box.getParam(1);

  if ( adjBoxX == xLeft && adjBoxY == pointY) { //Returns if box is to the left
    return 1;
  } else if (adjBoxX == xRight && adjBoxY == pointY) {  //Returns if box is to the right
    return 2;
  } else if (adjBoxY == yUp && adjBoxX == pointX) {   //Returns if box is upwards
    return 3;
  } else if (adjBoxY == yDown && adjBoxX == pointX) {  //Returns if box is downwards
    return 4;
  } else {                                              //Returns if box is none of the above
    return 0;
  }
}

////////////////////////////////////////////////////
// A Function that gives a number depending on how many directions are blocked

int isPermissable(gBox i) {

  int check = 0;


  for (gBox j : Grid) { //Another loop - yeeeeah it's slowing the program down a bit. Find a optimization?

    if (isAdj(i, j) != 0 && (j.on == true  || j.nSpawn == true) && (j.gSpawn == false || i.on == true)) {  

      //If the grid is adjacent, if the other grid box is toggled on or spawned the ninja, and if other box spawned the Guard or if the current box is toggled
      //then the counter will go up.

      check++;
    }
  }

  return check;
}

////////////////////////////////////////////////////
// A Function that toggles the "On" boolean of the Grid
void gridToggle(gBox center, gBox adj) {

  if (mouseWithinGrid(center.box, unit)) { //Check Which box the mouse is inside



    if (isAdj(center, adj) != 0 && isPermissable(center) < 3 ) {


      if (adj.on == true || adj.nSpawn == true) {  //Checks if any of the surrounding boxes is pretoggled or the starting piece, and is Adjacent
        //If true, then goes through

        if (center.on == false) {
          center.on = true;
        }else if (center.on == true) {
          center.on = false;
        }
        
        if (boost) {
          if (center.boost) {
            center.boost = false;
          }
          else if (center.boost == false){
            center.boost = true;
          }
          }
         
          if (center.on == false) {
            center.boost = false;
          }
     
    }
    }
  }
}
////////////////////////////////////////////////////
// A Function that does grid calculations in draw instead of mousePressed

void autonomousGrid(Ninja Genji) {

  if (Genji.move) {

    for (gBox center : Grid) {   //BasicallyLocks in the Grid if the Ninjas are in motion

      if (center.gSpawn) {

        boolean side = false;

        for (gBox adj : Grid) {

          if (isAdj(center, adj) != 0 &&  adj.on == true) {
            side = true;
          }

          if (side) {
            center.on = true;
          }
        }
      }
      
      if(center.on == false && center.boost == true){ //Turns off the booster squares
      center.boost = false;
    }
   
  }
  }
  
}


////////////////////////////////////////////////////
// A Function that Displays the Grid. Also includes toggle functionality
void displayGrid(gBox i) {


  if (i.on == false || isPermissable(i) >= 3 ) {

    i.box.setFill(color(255));     //Returns it to White
  }

  if (isPermissable(i) == 1) { 
    i.box.setFill(colours[5]); //Blue color
  }

  if (i.on) {
    i.box.setFill(colours[6]); //Orange colour
    if (isPermissable(i) >= 2) {
      i.box.setFill(colours[7]);
    }
  } 
  
  if (i.boost) {
    i.box.setFill(colours[3]);    // Boost Displays
    if (isPermissable(i) >= 2) {
      i.box.setFill(colours[4]);
    }
  }


  shape(i.box);
}


////////////////////////////////////////////////////
// Function that Spawns in Guards
void gSpawn() {

  boolean reset;
  

do {
  reset = false;
  security = new ArrayList<Guard>(); //Creating the ArrayList
  int numSpawn = int(random(2, 6));  //Controls the amount of enemies in total 

  for ( int i = 0; i <= numSpawn - 1; i++) {

    while (true) {                                //Loop to prevent double spawnings
      int index = int(random(Grid.size()));
      gBox spawnLoc = Grid.get(index);

      if ( spawnLoc.nSpawn == false && spawnLoc.gSpawn == false) {
        spawnLoc.gSpawn = true;
        Guard guard = new Guard (int(spawnLoc.box.getParam(0)), int(spawnLoc.box.getParam(1)), unit);
        security.add(guard);
        break;
      }
    }
  }


  for( gBox center : Grid) { //Checks if 2 guards are spawned right next to the same square. If so, resets the spawn
    
    int side = 0;
    
    for (gBox adj : Grid) {

      if ( isAdj(center, adj) != 0 && adj.gSpawn == true ) {
        side++;
      }
    }
    if (side >= 2) {
        
        reset = true;
    }      
  }
  
  if(reset) {
    for (gBox grid : Grid) { //Clears the grid so there is no problems with gSpawn variable.
      grid.gSpawn = false;
    }
  }
  
  
} while (reset);

 
}

////////////////////////////////////////////////////
// Function Spawns the Ninja randomly (Inital)

void nSpawn() {

  boolean reset;
  
  do {
  reset = false;
  clan = new ArrayList<Ninja>(); //Creating the ArrayList for Actual ninjas
  decoys = new ArrayList<Ninja>(); //Creates an Arraylist to Save Decoy data

  while (true) {                            //Same algorithm to spawn in the Ninja as the guards
    int index = int(random(Grid.size()));
    gBox spawnLoc = Grid.get(index);
    NspawnLoc = spawnLoc; //Temp Respawn Stuff

    if ( spawnLoc.nSpawn == false && spawnLoc.gSpawn == false) {
      spawnLoc.nSpawn = true;
      Ninja Genji = new Ninja (int(spawnLoc.box.getParam(0)), int(spawnLoc.box.getParam(1)), 0, 0, 0, 1, unit);
      clan.add(Genji);
      break;
    }
  }
  
  for (gBox grid : Grid) {
    
    if(isAdj(NspawnLoc, grid) != 0 && grid.gSpawn) {
      reset = true;
    }
  }
  
  if(reset) {
    for (gBox grid : Grid) {
      grid.nSpawn = false;
    }
  }
    
  
   } while (reset);
}

////////////////////////////////////////////////////
// Function Spawns the Ninja on Paths

void nPathSpawn() {
  boolean spawn = false;

  for ( Ninja Genji : clan) {
    for (gBox grid : Grid) {

      if (Genji.xPos == grid.box.getParam(0) && Genji.yPos == grid.box.getParam(1) && isPermissable(grid) >=1) { //Checks if the Ninja location is the same as the Grid
        spawn = true;
      }
    }
  }

  if (spawn) { //Adds ninjas to Main array

    for (Ninja kawarimi : decoys) {
      clan.add(kawarimi);
    }
    
    
  }
  
  for ( int poof = decoys.size() -1; poof >= 0; poof --) { //Removes decoys from Temporary Array
      decoys.remove(poof);
      //println("remove");
    }

    for (int i = clan.size() - 1; i >= 0; i --) { //Removes Duplicates from Main array
      for (int j = clan.size() - 1; j >= 0; j --) {
        if (i != j && clan.get(i).xPos == clan.get(j).xPos && 
          clan.get(i).yPos == clan.get(j).yPos 
          && clan.get(i).dx == clan.get(j).dx
          && clan.get(i).dy == clan.get(j).dy) {
          
          if( clan.get(i).time > clan.get(j).time) {
            clan.get(i).time = clan.get(j).time;
            clan.get(i).ninPath = clan.get(j).ninPath;
          }
            
          clan.remove(j);
          break;
            }
        }
      }
      
      
    
  }

////////////////////////////////////////////////////
// Function that puts texts in the center of a rectagular PShape

void textFunc(PShape button, String text, int fontSize, color fontcolour) {

  fill(fontcolour);                                            //Puts the text in the center of the rectangular button, with the specified colour and size
  textSize(fontSize);
  float xCord = button.getParam(0) + button.getParam(2)/2;
  float yCord = button.getParam(1) + button.getParam(3)/2;
  text(text, xCord, yCord);
}


////////////////////////////////////////////////////
// Function that Calculates the scores

void scoreFunc() {
  
  float distance = 0, time = 0;;
  int rewards = 0, punishments = 0;
  
  if(clan.size() == 1) {
  for (int j = security.size()-1; j >= 0; j--){
       if (clan.get(0).xPos == security.get(j).xPos && clan.get(0).yPos == security.get(j).yPos){
         distance = (security.size() - clan.size() ) * 999999;
       }
  }
     }
  
  if (clan.size() > 1) {
    
    float minTime = clan.get(0).time;
    float maxTime = clan.get(0).time;
    int minPath = clan.get(0).ninPath, maxPath = clan.get(0).ninPath;
    
    for (int i = clan.size() - 1; i >= 0; i--){
     
        
        if (clan.get(i).time < minTime) {
          
          
          minTime = clan.get(i).time;
          minPath = clan.get(i).ninPath;
          
        }
      
      else if (clan.get(i).time > maxTime) {
        
        
        maxTime = clan.get(i).time;
        maxPath = clan.get(i).ninPath;
      
    }  
    
   // println(i, minTime, minPath, maxTime, maxPath);
    }
    
    int counter = 0;
    
    for (int i = clan.size() - 1; i >= 0; i--){
      if(clan.get(i).stop == true) {
        counter ++;
      }
    }
    
     
    
    
      
    
     
    if (counter == clan.size()){
      int add;
    
    for (int i = clan.size() - 1; i >= 0; i--){ //Bit of QOL asthetic to the squares. The Green square is the first Square to Stop, while the Red square is last to stop.
    
    if (clan.get(i).time == minTime) {
      clan.get(i).strokeWeight = 5;
      clan.get(i).strokeColour = color(0, 255, 0);
      add=0;
    }
    
    else if (clan.get(i).time == maxTime) {
      
      clan.get(i).strokeWeight = 5;
      clan.get(i).strokeColour = color(255, 0, 0);
      add = 1;
      maxPath = maxPath + 1;
    }
    
    else {
      clan.get(i).strokeWeight = 1;
      clan.get(i).strokeColour = color(0);
      add = 0;
    }
    
    fill(255);
    text(clan.get(i).ninPath + add, clan.get(i).xPos + unit/2, clan.get(i).yPos + 6*unit/8); 
    
    // Yo SELF for when you inevitably forget - your last square doesn't count the last square
    //This means that the last ninja object to stop will always be 1 less than it should be. This here is a workaround to make it seem like it works.
    
    
    }
    }
   
   
    
 // println((maxTime - minTime), rewards, punishments);
 //score = (maxTime - minTime) - rewards + punishments;
 fill(0);
 distance = abs(maxPath - minPath);
 time = (maxTime - minTime)/1000;
    }
  

  
  textSize(68);
  if (distance != 0 || (clan.size() > 1 && distance == 0)){
    
    text("Distance: " + int(distance), width/4, height/15);
    text("Time: " + time, 3*width/4, height/15);
    }
    
    else {
      
      text("Score", width/2, height/15);
    }
  
  
}

////////////////////////////////////////////////////
// Function that activates when double clicked/tapped

void howToPlay() {
  
    background(255);
    fill(0);
    textSize(68);
    text("How To Play", width/2, height/10);
    
    textSize(40);
    text("Double tap screen to open the Pop up menu! \nCreate a path from the Black square to the Red Squares! \n Try and get the smallest score!", 
    width/2, height/4 - unit);
    
    textSize(28);
    
    fill(colours[5]);
    rect(width/4, height/3, unit, unit);
    fill(0);
    text("Press These To Set a New Path", width/4, height/3 + 2*unit);
    
    fill(colours[6]);
    rect(width/2, height/3, unit, unit);
    fill(0);
    text("Press This Colour To Undo The Path You Just Placed", width/2, height/3 + 3*unit/2);
    
    fill(colours[7]);
    rect( 3*width/4, height/3, unit, unit);
    fill(0);
    text("This Is The Colour Of The Path That You Have Set", 3*width/4, height/3 + 2*unit);
    
}

////////////////////////////////////////////////////
// Function that extends the functionality of the colour selector

void colourCalcs() {
  
  if(buttonList[13].buttonTrue() ){  //Save button for colours
    colours[colourIndex] = colourPicker.colourGet();
    
    //Saves the colour for the Pop Up Menu
  if (colourIndex == 8) { 
    
    for (int i = 0; i < 4; i ++){
      buttonList[i].buttonColour = colours[colourIndex];
    }
    
  }
  
 
  
  //Saves the colour for the Pop Up Menu Font
  if (colourIndex == 9) {
    
    for (int i = 0; i < 4; i ++){
      buttonList[i].textColour = colours[colourIndex];
    }
    
  }
  
  //Boost button Colour
  
   if (colourIndex == 4) {
    buttonList[9].buttonColour = colours[colourIndex];
   }
   
  if(colourIndex == 10) {
    buttonList[9].textColour = colours[colourIndex];
  }
  
  
  }
  
  if(buttonList[14].buttonTrue() ) { //Button pointing left
   colourIndex --;
  }
  
  if(buttonList[15].buttonTrue() ) { //Button pointing right
    colourIndex ++;
  }
  
  if(colourIndex > colours.length - 1) {
    colourIndex = 3; //Boost colour
  }
  
  if(colourIndex < 3) {
    colourIndex = colours.length - 1; //Boost Font
  }
  
  //Default colour reset
  if (buttonList[16].buttonTrue()) {
    colourCreate();
    for (int i = 0; i < 4; i ++){
      buttonList[i].buttonColour = colours[8] ;
      buttonList[i].textColour = colours[9] ;
    }
    buttonList[9].buttonColour = colours[4];
    buttonList[9].textColour = colours[10];
  
  }
  
}

////////////////////////////////////////////////////
// Function that displays the colour selector

void colourCalculationsDisplay() {
  
  String words = "Hello";
  
  
  //Displays Buttons
  colourPicker.display();
  buttonList[13].display() ;
  buttonList[14].displayTri();
  buttonList[15].displayTri();
  buttonList[16].display();

  //Example Colour Square
  fill(colourPicker.colourGet());
  rect(5.72*width/7, height/3 - height/6, height/8, height/8);
  
  //Set Colour Square
  fill(colours[colourIndex]);
  rect(5.72*width/7, height/2 - height/6, height/8, height/8);
  
  fill(0);
  
  //Explaination Texts
  
  if(colourIndex == 3) {
    words = "Reversible\n Boost Square";
  }
  
  if(colourIndex == 4) {
    words = "Boost Square";
  }
  
  if(colourIndex == 5) {
    words = "Pathing Squares";
  }
  
  if(colourIndex == 6) {
    words = "Reversible \n Normal Squares";
  }
  
  if(colourIndex == 7) {
    words = "Normal Squares";
  }
  
  if(colourIndex == 8) {
    words = "Pop Up Menu";
  }
  
  if(colourIndex == 9) {
    words = "Pop Up Menu Font";
  }
  
  if(colourIndex == 10) {
    words = "Boost Button Font";
  }
  
  text(words, 6*width/7, height/2 + height/8);
  
}

////////////////////////////////////////////////////
// Function that activates when double clicked/tapped
void doubleClick () {

  if (popUpMenu) {
    popUpMenu = false;
  } else {
    popUpMenu = true;
  }
}

////////////////////////////////////////////////////
// Function that prints debugging information

void deBugger() {

  for (gBox i : Grid) {
    if (mouseWithinGrid(i.box, unit)) { //Check Which box the mouse is inside

      println("The X Co-ordinate is " + i.box.getParam(0));
      println("The Y Co-ordinate is " + i.box.getParam(1));
      println("On is " + i.on);
      println("Boost is " + i.boost);
      println("nSpawn is " + i.nSpawn);
      println("gSpawn is " + i.gSpawn);
      println("isPermissable value: " + isPermissable(i));
      println("*****************************************");
    }
  }
}