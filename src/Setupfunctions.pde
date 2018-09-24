////////////////////////////////////////////////////
// A Function that builds a grid!

void createGrid( int Width, int Height, int size) { 


  int buffer = 20; //Buffering is the area from the edge of the Screen. Need some sorta Autoformatting thing? - Smaller Numbers are smaller Grid

  Grid = new ArrayList<gBox>(); //Sets up the Grid - Global variable

  for ( int i = Width/buffer+ size; i < Width && i+size < Width - Width/buffer; i = i + size) {
    for (int j = Height/buffer + size; j < Height && j+size < Height - 4 * Height/buffer; j = j + size) {  //Creates the grid according to size of screen

      gBox grid = new gBox(i, j, size);
      Grid.add(grid);
    }
  }
} 


////////////////////////////////////////////////////
// A Function that builds a grid in the How to Play menu

void createGrid (int Width, int Height, int size, int yPos, int buffer) {



  Grid = new ArrayList<gBox>(); //Sets up the Grid - Global variable

  for ( int i = Width/buffer + size/3; i < Width && i+size < Width - Width/buffer; i = i + size) {
    for (int j = yPos + unit/2; j < Height && j+size < Height - Height/buffer; j = j + size) {  //Creates the grid according to size of screen

      gBox grid = new gBox(i, j, size);
      Grid.add(grid);
    }
  }
}

////////////////////////////////////////////////////
// A Function to create all the buttons and puts them into an array

void createButtons() { 

  buttonList = new Button[26];

  //Move button
  buttonList[0] = new Button(0, height - height/5, width/4, height/5, colours[8], colours[9], "  Move  ");

  //Reset button
  buttonList[1] = new Button(width - width/4, height - height/5, width/4, height/5, colours[8], colours[9], "  Reset  ");

  //New Puzzle Button
  buttonList[2] = new Button(width - width/3, 0, width/3, height/5, colours[8], colours[9], "New Puzzle");

  //Return to Main Menu Button
  buttonList[3] = new Button(0, 0, width/3, height/5, colours[8], colours[9], "Main Menu");


  /////////////////////////////////
  //Menu buttons

  //Title
  buttonList[4] = new Button(width/4, height/3, width/2, height/4, color(#1d3461), 255, "Clockwork Ninja");

  //Play Button
  buttonList[5] = new Button(0, 0, width/2, height/2, color(#bb0a21), 0, "     Play     ");

  //How to Play button

  buttonList[6] = new Button(width/2, 0, width/2, height/2, color(#252627), 255, "How to Play");

  //Options Buttons

  buttonList[7] = new Button(0, height/2, width/2, height/2, color(#4b88a2), 0, " Options ");

  //Exit Button

  buttonList[8] = new Button(width/2, height/2, width/2, height/2, color(#318240), 0, "     Exit    ");


  /////////////////////////////////
  //Some Options Buttons

  //Color Selector Menu Button

  buttonList[9] = new Button( 1.25*width/5, height/4, width/2, height/5, color(#318240), 255, "Colour Selector");

  //Credits Button

  buttonList[10] = new Button( 1.25*width/5, height/2, width/2, height/5, color(#318240), 255, "Credits");

  //Back Button

  buttonList[11] = new Button(0, 5*height/6, width/10, height/6, color(#318240), 255, "Left");

  //Colour Selector Save Button

  buttonList[12] = new Button( width/3, 5*height/6, width/3, height/6, color(#bb0a21), 0, "  Save  ");

  //Colour Selector Left Button

  buttonList[13] = new Button( width - width/4, height/2 - height/6, width/25, height/8, color(#318240), 255, "Left");

  //Colour Selector Right Button

  buttonList[14] = new Button( width - width/12, height/2 - height/6, width/25, height/8, color(#318240), 255, "Right");

  //Default Colours Button

  buttonList[15] = new Button (3 *width/4, 5*height/6, width/4, height/6, color(#4b88a2), 0, "Default Settings");

  /////////////////
  //How to Play Left Right buttons

  //Left
  buttonList[16] = new Button( width/24, height/2 - height/8, width/25, height/8, color(#318240), 255, "Left");

  //Right
  buttonList[17] = new Button( width - width/12, height/2 - height/8, width/25, height/8, color(#318240), 255, "Right");

  ///////////////////////////////
  //Number Assistant Button

  buttonList[18] = new Button(1.25*width/5, 0.75 * height, width/2, height/5, color(#FF7C0F), 255, "Number Assistant");
  
  ////////////////////////////////////////////////////////////////////////////////

  //Boost Buttons

  // x1
  buttonList[19] = new Button(0.10 * width, height - height/6, 0.20 * width, 0.15 * height, colours[13], colours[12], "x1", 1); 
  
  // x2
  buttonList[20] = new Button(width/2 - 0.1 * width, height - height/6, 0.20 * width, 0.15 * height, colours[14], colours[12], "x2", 2);
  
  // x3
  buttonList[21] = new Button( 0.80 * width - 0.1 * width, height - height/6, 0.20 * width, 0.15 * height, colours[4], colours[12], "x3", 3);
  
  ///////////////////////////////////////////////////////////////////////////////////
  
  // Restore Button
  buttonList[22] = new Button(3 * width/8, height - height/5, width/4, height/5, colours[8], colours[9], "Restore");
  
  ///////////////////////////////////////////////////////////////////////////////////
  
  //Difficulty Buttons
  
  //Easy
  buttonList[23] = new Button( 0.1 * width, height/2, width/4, height/4, color(#FFA20A), 255, "Easy");
  
  //Medium
  buttonList[24] = new Button( width/2 - width/8, height/2, width/4, height/4, color(#FF7C0F), 255, "Meh");
  
  //Hard
  buttonList[25] = new Button( 0.9 * width - width/4, height/2, width/4, height/4, color(#bb0a21), 255, "Hard");
  
  //buttonList[26] = new Button( 1.25*width/5, height/4, width/2, height/5, color(#318240), 255, "Impossible");
  
}

////////////////////////////////////////////////////
// A Function for intial colours and storage of colours
void colourCreate() {

  colours = new color[15];

  //Almost Black
  colours[0] = color(#252627);

  //Light Blue
  colours[1] = color(#4b88a2);

  //Moss Green
  colours[2] = color(#318240);

  //Light Purple - Squares
  colours[3] = color(#565Cf2);

  //Deep blue color - The one for the Boost Square (x3)
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
  
  //Ghost Path Colors
  colours[10] = color(148);
  
  //Ghost Path Start Point Colour
  colours[11] = color(#D81CCF);

  //Font colour for Boost Button
  colours[12] = color(255);
  
  //Boost Button x1 Colour 
  colours[13] = color(#7409AF);
  
  //Boost Button x2 Colour
  colours[14] = color(#177109);
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


    for ( gBox center : Grid) { //Checks if 2 guards are spawned right next to the same square. If so, resets the spawn

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

    if (reset) {
      for (gBox grid : Grid) { //Clears the grid so there is no problems with gSpawn variable.
        grid.gSpawn = false;
      }
    }
  } while (reset);
}

////////////////////////////////////////////////////
// Function that Spawns in Guards
void gSpawn(int lower, int upper) {

  boolean reset;


  do {
    reset = false;
    security = new ArrayList<Guard>(); //Creating the ArrayList
    int numSpawn = int(random(lower, upper));  //Controls the amount of enemies in total 

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


    for ( gBox center : Grid) { //Checks if 2 guards are spawned right next to the same square. If so, resets the spawn

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

    if (reset) {
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
      spawnLoc.ghostBoost = 4;
      NspawnLoc = spawnLoc; //Respawn Stuff
      

      if ( spawnLoc.nSpawn == false && spawnLoc.gSpawn == false) {
        spawnLoc.nSpawn = true;
        //spawnLoc.numAssist = 1; //Number Assistant functionality
        Ninja Genji = new Ninja (int(spawnLoc.box.getParam(0)), int(spawnLoc.box.getParam(1)), unit);
        clan.add(Genji);
        break;
      }
    }

    for (gBox grid : Grid) {

      if (isAdj(NspawnLoc, grid) != 0 && grid.gSpawn) { //Checks if guard box has spawned next to Ninja Square
        reset = true;
      }
    }

    if (reset) {
      for (gBox grid : Grid) {
        grid.nSpawn = false;
        grid.ghostBoost = -1;
      }
    }
  } while (reset);
}

////////////////////////////////////////////////////
// Function Spawns the Ninja How to play

void nSpawn(int size) {

  boolean reset;

  do {
    reset = false;
    clan = new ArrayList<Ninja>(); //Creating the ArrayList for Actual ninjas
    decoys = new ArrayList<Ninja>(); //Creates an Arraylist to Save Decoy data

    while (true) {                            //Same algorithm to spawn in the Ninja as the guards
      int index = int(random(Grid.size()));
      gBox spawnLoc = Grid.get(index);
      spawnLoc.ghostBoost = 4;
      NspawnLoc = spawnLoc; //Respawn Stuff

      if ( spawnLoc.nSpawn == false && spawnLoc.gSpawn == false) {
        spawnLoc.nSpawn = true;
        //spawnLoc.numAssist = 1; //Number Assistant functionality
        Ninja Genji = new Ninja (int(spawnLoc.box.getParam(0)), int(spawnLoc.box.getParam(1)), size);
        clan.add(Genji);
        break;
      }
    }

    for (gBox grid : Grid) {

      if (isAdj(NspawnLoc, grid) != 0 && grid.gSpawn) { //Checks if guard box has spawned next to Ninja Square
        reset = true;
      }
    }

    if (reset) {
      for (gBox grid : Grid) {
        grid.nSpawn = false;
        grid.ghostBoost = -1;
      }
    }
  } while (reset);
}

////////////////////////////////////////////////////
// Function that removes grids, creating Blockages
void blockageSpawn(float amountToRemove) {

  boolean reset;


  do {
    reset = false;
    security = new ArrayList<Guard>(); //Creating the ArrayList
    int numSpawn = int(Grid.size() * amountToRemove);  //Controls the amount of enemies in total 
    //int numSpawn = int(40);

    for ( int i = 0; i <= numSpawn - 1; i++) {

      while (true) {                                //Loop to prevent double spawnings
        int index = int(random(Grid.size()));
        gBox removeLoc = Grid.get(index);
         
        if ( removeLoc.nSpawn == false && removeLoc.gSpawn == false && removeLoc.blockage == false) {
          removeLoc.blockage = true;
          break;
        }
      }
    }


    for ( gBox center : Grid) { //Checks if 2 blocks are spawned right next to the same square. If so, resets the spawn

      int side = 0;

      for (gBox adj : Grid) {

        if ( isAdj(center, adj) != 0 && (adj.gSpawn == true || adj.nSpawn == true) ) {
          side++;
        }
      }
      if (side >= 2) {

        reset = true;
      }
    }

    if (reset) {
      for (gBox grid : Grid) { //Clears the grid so there is no problems with blockage variable.
        grid.blockage = false;
      }
    }
  

} while (reset);

for (int i = Grid.size() -1; i >= 0; i--) {
  if (Grid.get(i).blockage == true) {
    Grid.remove(i);
  }
}

}

////////////////////////////////////////////////////////////
// Difficulty spawner

void difficultySpawn( String difficulty) {
  
    clearArrays();
    int upper = 0;
    int lower = 0;
    float fractionOfRemoval = 0;
    
    if (difficulty.equals("Easy") ) {
  
    unit = 120;
    lower = 2;
    upper = 3;
    
    }
    
    if (difficulty.equals("Medium") ) {
  
    unit = 90;
    lower = 5;
    upper = 8;
    
    }
   
    if (difficulty.equals("Hard") ) {
  
    unit = 60;
    lower = 15;
    upper = 18;
    fractionOfRemoval = 0.3;
    
    }
    
    
    menuState = 1;
    createGrid(width, height, unit);
    //blockageSpawn(fractionOfRemoval);
    gSpawn(lower, upper);
    nSpawn();
    score = new scoreSaver();
    bestScore = new scoreSaver();
  
  
}
