////////////////////////////////////////////////////
// Function for How to Play Mouse Calcs

void howToPlayMouseCalcs(int stateOfMenu) {
  
  //int howtoPlaySize = 90;
 

if (buttonList[3].buttonTrue() && popUpMenu ) { //Main Menu Button
      menuState = 0;
    }

    if ( popUpMenu == false) {

      if (buttonList[16].buttonTrue() && stateOfMenu != 7) { //Back button
        menuState --;
      }

      if (buttonList[17].buttonTrue() && stateOfMenu != 14) { //Forward button
        menuState ++;
      }


      if ((buttonList[16].buttonTrue() && stateOfMenu == 9) || (buttonList[17].buttonTrue() && stateOfMenu == 7)) { //Setup for Page 8 - Autonomous Grid
        
        
        createGrid(width, height - height/20, unit, height/3, 10);
        gSpawn(1, 1);
        nSpawn();
        clan.get(0).time = millis();
        pathFinder();
      }

      if ((buttonList[16].buttonTrue() && stateOfMenu == 10) || (buttonList[17].buttonTrue() && stateOfMenu == 8)) { //Setup for Page 9 - Single Path

        createGrid(width, height, unit, height/2 - height/20 + unit, 15);
        gSpawn(1, 1);
        nSpawn();
      }

      if ((buttonList[16].buttonTrue() && stateOfMenu == 11) || (buttonList[17].buttonTrue() && stateOfMenu == 9)) { //Setup for Page 10 - Split Path

        createGrid(width, height, unit, height/4, 10);
        gSpawn(2, 2);
        nSpawn();
      }

      if ((buttonList[16].buttonTrue() && stateOfMenu == 13) || (buttonList[17].buttonTrue() && stateOfMenu == 11)) { //Setup for Page 12 - Boost Explaination
        
        
        boost Boost = new boost (width/3 - (1.5 * unit)/2, 0.6 * height, 1.5 * unit, 1, true);
        boosters.add(Boost);
        boost Boosts = new boost (width/2 - (1.5 * unit)/2, 0.6 * height, 1.5 * unit, 2, true);
        boosters.add(Boosts);
        boost Boostss = new boost (2 * width/3 - (1.5 * unit)/2, 0.6 * height, 1.5 * unit, 3, true);
        boosters.add(Boostss);
      }

      if ((buttonList[16].buttonTrue() && stateOfMenu == 14) || (buttonList[17].buttonTrue() && stateOfMenu == 12)) { //Setup for Page 13 - Boost Trial

        clearArrays();
        //createGrid(width, height/2, howtoPlaySize, int(0.6 * height) , 20);
        createGrid(width, int(0.9 * height), unit, height/4, 10);
        gSpawn(2, 2);
        nSpawn();
      }
    }
    }
    
////////////////////////////////////////////////////
// Function for How to Play display

void howToPlay(int stateOfMenu) {


  //int howtoPlaySize = 90;

  if (stateOfMenu == 7) {  //Into tile
    
    //fontSize("How to Play", width/2, height/2);
    //text("How To Play", width/2, height/10);
    menuText("How to Play", 0, width/2, height/10, width/4, height/12);

    //fontSize("Hello There! Welcome!", width, height);
    //text("Hello There! Welcome!", width/2, 0.2 * height);
    menuText("Hello There! Welcome!", 0, width/2, 0.2 * height, width/3, height/12);

    //fontSize("Your job is to maneuver this square", width, height);
    //text("Your job is to maneuver this square", width/2, height/4);
    menuText("Your job is to maneuver this square", 0, width/2 , 0.3 * height, width/2, height/14);

    fill(0);
    rect( width/2 - (1.5*unit)/2, 0.35 * height, 1.5 * unit, 1.5 * unit);

    //fontSize("To these squares", width/2, height);
    //text("to these squares", width/2, 0.55 * height);
    menuText("to these squares", 0, width/2, 0.55 * height, width/4, height/12);

    fill(255, 0, 0);
    rect(width/3 - (1.5 * unit)/2, 0.65 * height, 1.5 * unit, 1.5 * unit);
    rect(2 * width/3 - (1.5 * unit)/2, 0.65 * height, 1.5 * unit, 1.5 * unit);

    //fill(0);
    //fontSize("So that the Black Square arrives at the \n Red Squares at the same time!", 1.2 * width, height);
    //text("so that the black square arrives at the red squares at the same time!", width/2, 0.9 * height);
    menuText("so that the black square arrives at the red squares at the same time!", 0, width/2, 0.9 * height, 0.9 * width, height/10);
  }

  if (stateOfMenu == 8) { //Autonomous Tile

    //fontSize("How exactly do you do that?", width, height);
    //text("How exactly do you do that?", width/2, 0.15 * height);
    menuText("How exactly do you do that?", 0, width/2, 0.15 * height, 0.65 * width, 0.1 * height);

    //fontSize("Well, the Black squares moves \n along orange squares as a 'Path' ", width, height);
    //text("Well, the black squares moves along orange squares as a 'path' ", width/2, 0.3 * height);
    menuText("Well, the black square moves along orange squares as a 'path' ", 0, width/2, 0.3 * height, 0.8 * width, height/12);

    //fill(0);
    //fontSize("Once a path has been set, Double Tap to open the Popup Menu", 1.5 * width, height);
    //text("Once a path has been set, double tap to toggle the popup menu \n Try this now!", width/2, 0.9 * height);
    menuText("Once a path has been set, double tap to toggle the popup menu. Try this now!", 0, width/2, 0.9 * height, 0.8 * width, height/12);
    
    if (howToPlayWin()) {
      //fontSize("GOOD JOB", width/2, height/2);
      //text("GOOD JOB", width/2, height/2);
      menuText("GOOD JOB", 0, width/2, height/2, width/3, height/12);
    }
  }

  if (stateOfMenu == 9) { //Three Colour Square Tile

    fill(colours[5]); //Defult Baby Blue Square
    rect(width/5 - (1.5 * unit)/2, 0.1 * height, 1.5 * unit, 1.5 * unit);
    //fill(0);
    //fontSize("Press These To Set a New Path", 0.75 * width, height/3);
    //text("Press these to \nset a new path", 1.25 * width/6, height/3);
    menuText("Press these to set a new path", 0, 1.25 * width/6, height/3, 0.2 * width, 0.1 * height);

    fill(colours[6]); //Default Light Orange
    rect(width/2 - (1.5 * unit)/2, 0.1 * height, 1.5 * unit, 1.5 * unit);
    //fill(0);
    //fontSize("Press This Colour To Undo The Path You Just Placed", width, height/3);
    //text("Press this colour to undo \nthe path you just placed", width/2, height/3);
    menuText("Press this colour to undo the path you just placed", 0, width/2, height/3, 0.2 * width, 0.1 * height);


    fill(colours[7]); //Default Dark Orange
    rect( 4*width/5 - (1.5 * unit)/2, 0.1 * height, 1.5 * unit, 1.5 * unit);
    //fill(0);
    //fontSize("This Is The Colour Of The Path \n That You Have Set", 0.65 * width, height/3);
    //text("This is the colour of the path \n that you have set", 0.8*width, height/3 );
    menuText("This is the colour of the path that you have set", 0, 0.8 * width, height/3, 0.2 * width, 0.1 * height);

    //fontSize("This Is The Colour Of The Path \n That You Have Set", 0.75 * width, height/3);
    //text("Try setting a path right now! Don't forget to double tap to open the popup menu!", width/2, height/2);
    menuText("Try setting a path right now! Don't forget to double tap to open the popup menu!", 0, width/2, height/2, 0.8 * width, height/16);
    
    menuText("Note that the black square gets slower over time", 0, width/2, 0.95 * height, 0.85 * width, height/16);
    
    if (howToPlayWin()) {
      //fontSize("GOOD JOB", width/2, height/2);
      menuText("GOOD JOB", 0, width/2, 0.7 * height, width/3, height/12);
    }
  }

  if (stateOfMenu == 10) { //Split Path Tile

    //fontSize("Paths can split. Try creating a branching path!", 1.2 * width, height);
    //text("Paths can split. Try creating a branching path!", width/2, 0.1 * height);
    menuText("Paths can be split. Try creating a branching path!", 0, width/2, 0.1 * height, width/2, height/10);
    
    if (howToPlayWin()) {
      //fontSize("GOOD JOB", width/2, height/2);
      menuText("GOOD JOB", 0, width/2, height/2, width/3, height/12);
    }

    //Insert grid with two Red squares here
    //noFill();
    //rect( 0.1 * width, 0.3 * height, 0.8 * width, height/2);
  }

  if (stateOfMenu == 11) { //Score Description Tile

    //fontSize("When finished, a number will appear on the Black Squares labeling the distance traveled! \n" 
    //  + "Try and reduce the difference in distance between the first and last square to stop", 2.1 * width, height);

    //text("When finished, a number will appear on the black squares labeling the distance traveled! \n" 
    //  + "Try and reduce the difference in distance between the first and last square to stop!", width /2, 0.1 * height);
      
       menuText("When finished, a number will appear on the black squares labeling the distance traveled!" 
      + " Try to reduce the difference in distance traveled between the first square to stop and the last square to stop!" +
      " The best score is when the distance and time are both zero!", 0, width/2, 0.15 * height, 0.8 * width, 0.2 * height);


    
    float rect1Xpos = 0.3 * width;
    float rect2Xpos = 0.5 * width;
    float size = 1.5 * unit;
    
    fill(0);
    rect(rect1Xpos, 0.3 * height, size, size);
    rect(rect2Xpos, 0.3 * height, size, size);;
    
    fill(255);
    fontSize("99", width/5, height/5);
    text("6", rect1Xpos + size/2, 0.3 * height + 1.5*(1.5 * unit)/2);
    text("4", rect2Xpos + size/2, 0.3 * height + 1.5*(1.5 * unit)/2);

    
    
    //fontSize(" - ", width, height/4);
    //text(" - ", 0.3 * width, 0.2 * height + 1.5*(1.5*howtoPlaySize)/2); 
    menuText("-", 0, rect1Xpos + size/2 + (rect2Xpos - rect1Xpos)/2, 0.36 * height, 0.1 * width, 0.1 * height);
    //fontSize(" - ", width, height/4);
    //text(" =  2", 0.6 * width, 0.2 * height + 1.5*(1.5*howtoPlaySize)/2); 
    menuText(" = 2", 0, rect2Xpos + size/2 + (rect2Xpos - rect1Xpos)/2, 0.36 * height, 0.1 * width, 0.1 * height);

    strokeWeight(5);
    fill(0);
    stroke(0, 255, 0);
    rect(width/3 - (1.5 * unit)/2, 0.6 * height, 1.5 * unit, 1.5* unit);
    stroke(255, 0, 0);
    rect(2 * width/3 - (1.5 * unit)/2, 0.6 * height, 1.5 * unit, 1.5 * unit);
    stroke(0);
    strokeWeight(1);


    fill(0);
    //fontSize("A Green Boundary means that this Square stopped First, while a Red Boundary means that this Square stopped second", 2.6 * width, height);
    //text("A green boundary means that this square stopped first, \n while a Red Boundary means that this square stopped last!"
    //, width/2, height/2);
    menuText("A green boundary means that this square stopped first, while a red boundary means that this square stopped last!"
    , 0, width/2, 0.525 * height, 0.8 * width, height/10);
    
    menuText("The score will tally 4 things: Distance - the difference in distance mentioned above, " +
    "Time - the difference in time between the first and last squares, " +
    "Total distance - the maximum distance traveled, and Number of boosts - The number of boosts used.",
    0, width/2, 0.9 * height, 0.8 * width, 0.2 * height);
    
 
  }

  if ( stateOfMenu == 12) { //Boost Square Explination Tile

    //fontSize("This is a Boost square. When the Black Square encounters \n" +
    //  "a Boost Square, it will charge up then move faster! \n" +
    //  "Be Careful when using too many though, it may decrease your score!", 1.5 * width, height);

    //text( "These are boost squares. When the black square encounters \n" +
    //  "a boost square, it will charge up then move faster! \n" +
    //  "Boost squares comes in three different types! \n The longer the charge, the stronger the boost! \n" +
    //  "Be careful: \n" +
    //  "boost speed does not stack, and using too many may decrease your score!", 
    //  width/2, height/5);
      
      menuText( "These are boost squares. When the black square encounters " +
      "a boost square, it will charge up the boost then move faster! " +
      "Boost squares come in three different types! The longer the charge, the stronger the boost! " , 0, 
      width/2, height/5, 0.8 * width, 0.3 * height);
      
      menuText("Be careful: " +
      "boost speed does not stack, and using too many may decrease your score!", 0, width/2, 0.45 * height, width/2, 0.1 * height);
  }

  if (stateOfMenu == 13) { //Boost Square Test Tile

    //fontSize("Use the Boost Buttons below to choose what Boost to place! \n" +
    //  "This can be done by pressing the boost button for the type of boost, then pressing a Pathing Square", 2.5 * width, height);
    //text("Use the boost buttons below to choose what boost to place! \n" +
    //  "Press the boost button, then click part of the path to place a boost!", width/2, height/6);
      menuText("Use the boost buttons below to choose which boost to place! " +
      "Press the boost button, then click part of the path to place the boost!" +
      " Boosts can also be placed on the light blue squares. This is handy if you need a boost on a reversable square!"
      , 0, width/2, 0.1 * height, 0.8 * width, 0.2 * height);

    //fontSize("This Is The Colour Of The Path \n That You Have Set", 0.75 * width, height/3);
    //text("Try setting a path right now!", width/2, height/4 + howtoPlaySize);
    
    menuText("Try setting a path right now!", 0, width/2, 0.25 * height, width/3, 0.05 * height);
    
    if (howToPlayWin()) {
      //fontSize("GOOD JOB", width/2, height/2);
      //text("GOOD JOB", width/2, height/2);
      menuText("GOOD JOB", 0, width/2, height/2, width/3, height/12);
    }

    //fontSize("This Is The Colour Of The Path \n That You Have Set", 0.70 * width, height/3);
    //text("Don't forget to Double tap to open the Pop Up Menu!", width/2, 0.45 * height);
  }

  if (stateOfMenu == 14) { // Tips Tile

    //fontSize("Tips", width/4, height/5);
    //text("Tips", width/2, height/5);
    menuText("Tips", 0, width/2, 0.1 * height, width/3, 0.1 * height);

    //fontSize("Red Squares are terminal. \n The black Square cannot move past the Red Square", width, height/3);
    //text( "Red squares are terminal. \n The black square cannot move \n past the red square", 1.35 * width/6, height/3);
    menuText( "Red squares are terminal. The black squares cannot move past the red squares.", 0, 0.225 * width, height/3, 0.25 * width, 0.25 * height);

    //fontSize("Paths can split and can be \n advantagous when aiming for a lower time", width, height/3);
    //text( "Paths can split and can be advantagous when aiming for a lower time", width/2, height/3);
    menuText( "Paths can split and can be advantagous when aiming for a lower time.", 0, width/2, height/3, 0.25 * width, 0.25 * height);

    //fontSize("There is a Colour Selector \n in the options menu", 0.5*width, height/3);
    //text("There is a colour selector \n in the options menu :D", 0.8*width, height/3);
    menuText("There is a colour selector \n in the options menu :D", 0, 0.8*width, height/3, 0.25 * width, 0.25 * height);

    //fontSize("There is a Colour Selector \n in the options menu", 0.5*width, height/3);
    //text("Stay in school kids", 1.35 * width/6, 2 * height/3);
    menuText("Stay in school kids!", 0, 1.35 * width/6, 2 * height/3, 0.25 * width, 0.25 * height);

    //fontSize("There is a Colour Selector \n in the options menu", 0.5*width, height/3);
    //text("Tailing people will increase draft, \n and help you save gas", width/2, 2 * height/3);
    menuText("Tailing people will increase draft, and help you save gas", 0, width/2, 2 * height/3, 0.25 * width, 0.25 * height);

    //fontSize("There is a Colour Selector \n in the options menu", 0.5*width, height/3);
    //text("Check before and after flushing, \n just in case", 0.8*width, 2 * height/3);
    menuText("Check before and after flushing, just in case", 0, 0.8*width, 2 * height/3, 0.25 * width, 0.25 * height);

    //Rosemary is an excellent herb for Chicken
  }

  if (popUpMenu) { //Explinations for the Popup menu
    
    pushStyle();
    rectMode(CENTER);

    //Background box to add some shade
    fill( color(0, 100));
    rect(width/2, height/2, width, height);

    //Move button
    fill(255);
    rect(0.15 * width, height * 4/6,  0.3 * width, height /10);
    menuText("This button will cause the black square to move along the path you set!", 0, 0.15 * width, height * 4/6, 0.25 * width, height /10);
    
    //fill(0);
    //fontSize("This button will cause the black square to \n move along the path you set", 0.75 * width, height /5);
    //text("This button will cause the black square to \n move along the path you set!", 0.1689 * width, height * 4.25/6);
    
    

    //Reset Button
    fill(255);
    rect( 0.85 * width, height * 4/6, 0.3 * width, height /10);
    menuText("This button will reset the puzzle and erase the path you created!", 0, 0.85 * width, height * 4/6, 0.25 * width, height /10);
    
    //fill(0);
    //fontSize("This button will cause the Black Square to \n move along the path you set", 0.75 * width, height /5);
    //text("This button will reset the puzzle \n and erase the path you created!", 0.73 * width, height * 4.25/6);
    
    //Restore Button
    fill(255);
    rect(0.5 * width, height * 4/6, 0.3 * width, height /10);
    menuText("This button will reset the puzzle and restore your previous path!", 0, 0.5 * width, height * 4/6, 0.25 * width, height /10);
    
    //fill(0);
    //fontSize("This button will cause the Black Square to \n move along the path you set", 0.75 * width, height /5);
    //text("This button will reset the puzzle \n and restore your previous path!", 0.73 * width, height * 4.25/6);


    ////Boost Button
    //if (menuState >= 12) {
    //  fill(255);
    //  rect(2.5 * width/8, height * 1/6, 1.25 * width/3, height /5);
    //  fill(0);
    //  fontSize("This button will cause the Black Square to \n move along the path you set", 0.75 * width, height /5);
    //  text("Press This Button to toggle the Boost squares, \nas well as the type of Boost squares", 0.53 * width, height * 1.5/6);
    //}
    
    popStyle();
    
  }
}

////////////////////////////////////////////////////
// Function for the options menu
void optionsMenu(int stateOfMenu, boolean numAssist) {

  background(80);
  buttonList[11].displayTri();

  if (stateOfMenu == 4) { //Options Menu


    fill(255);
    fontSize("Options", width, height/6);
    //textSize(68);
    text("Options", width/2, height/10);
    buttonList[9].display();
    buttonList[10].display();
    buttonList[18].display(numAssist);
  }

  if (stateOfMenu == 5) { //Colour Selector Menu

    colourCalculationsDisplay();
  }

  if (stateOfMenu == 6) { //Credits Menu
    fill(255);
    fontSize(version, width/4, height/2);
    //textSize(25);
    text(version, 0.07 * width, height/36);

    fontSize("Created by Alex Mah         ", width, height/4);
    //textSize(69);
    text("Created by Alex Mah \n Special Thanks to: \n Dr. Laleh Bejat \n All of My Playtesters (You rock)", width/2, height/4);


    //fontSize("Patch notes  ", width/3, height/4);
    textSize(25);
    text("Patch notes \n" + 
      "Fixed some punctuation and how to play bugs\n" + 
      "Added a restore button\n" +
      "Number Assistant should drain less power \n"
      + "Added a difficulty setting \n" +
      "Improved score calculations \n" +
      "Do People actually read this? \n Type the code 7998 into your form response if you do", 
      width/2, 3*height/4);
      
  }
}




////////////////////////////////////////////////////
// Function that extends the functionality of the colour selector

void colourCalcs() {

  if (buttonList[12].buttonTrue() ) {  //Save button for colours
    colours[colourIndex] = colourPicker.colourGet();

    //Saves the colour for the Pop Up Menu
    if (colourIndex == 8) { 

      for (int i = 0; i < 4; i ++) {
        buttonList[i].buttonColour = colours[colourIndex];
      }
      buttonList[22].buttonColour = colours[colourIndex];
    }



    //Saves the colour for the Pop Up Menu Font
    if (colourIndex == 9) {

      for (int i = 0; i < 4; i ++) {
        buttonList[i].textColour = colours[colourIndex];
      }
      buttonList[22].textColour = colours[colourIndex];
    }

    // x1 Boost button Colour

    if (colourIndex == 13) {
      
        buttonList[19].buttonColour = colours[colourIndex];
        
    }
    
    // x2 Boost button Colour

    if (colourIndex == 14) {
      
        buttonList[20].buttonColour = colours[colourIndex];
        
    }
    
    // x3 Boost button Colour

    if (colourIndex == 4) {
      
        buttonList[21].buttonColour = colours[colourIndex];
        
    }

    if (colourIndex == 12) {
     for  (int i = 19; i < 22; i ++) {
        buttonList[i].textColour = colours[colourIndex];
        }
    }
  }

  if (buttonList[13].buttonTrue() ) { //Button pointing left
    colourIndex --;
  }

  if (buttonList[14].buttonTrue() ) { //Button pointing right
    colourIndex ++;
  }

  if (colourIndex > colours.length - 1) {
    colourIndex = 4; // x3 Boost colour
  }

  if (colourIndex < 4) {
    colourIndex = colours.length - 1; //Boost Font
  }

  //Default colour reset
  if (buttonList[15].buttonTrue()) {
    colourCreate();
    
    for (int i = 0; i < 4; i ++) {  //PopUpMenu colours
      buttonList[i].buttonColour = colours[8];
      buttonList[i].textColour = colours[9];
    }
   buttonList[22].buttonColour = colours[8];
   buttonList[22].textColour = colours[9];
  
   // x1 Boost button
   buttonList[19].buttonColour = colours[13];
   buttonList[19].textColour = colours[12];
   
   // x2 Boost button
   buttonList[20].buttonColour = colours[14];
   buttonList[20].textColour = colours[12];
   
   // x3 Boost button
   buttonList[21].buttonColour = colours[4];
   buttonList[21].textColour = colours[12];
   
   
  }
}

////////////////////////////////////////////////////
// Function that displays the colour selector

void colourCalculationsDisplay() {

  String words = "Hello";


  //Displays Buttons
  colourPicker.display();
  buttonList[12].display() ;
  buttonList[13].displayTri();
  buttonList[14].displayTri();
  buttonList[15].display();

  //Example Colour Square
  fill(colourPicker.colourGet());
  rect(5.72*width/7, height/3 - height/6, height/8, height/8);

  //Set Colour Square
  fill(colours[colourIndex]);
  rect(5.72*width/7, height/2 - height/6, height/8, height/8);

  fill(0);

  //Explaination Texts

  if (colourIndex == 3) {
    words = "Reversible Boost Square";
  }

  if (colourIndex == 4) {
    words = "x3 Boost Square";
  }

  if (colourIndex == 5) {
    words = "Pathing Squares";
  }

  if (colourIndex == 6) {
    words = "Reversible Normal Squares";
  }

  if (colourIndex == 7) {
    words = "Normal Squares";
  }

  if (colourIndex == 8) {
    words = "Pop Up Menu";
  }

  if (colourIndex == 9) {
    words = "Pop Up Menu Font";
  }

  if (colourIndex == 10) {
    words = "Ghost Path Colour";
  }
  
  if (colourIndex == 11) {
    words = "Starting Place Colour";
  }
  
  if (colourIndex == 12) {
    words = "Boost Button Font";
  }
  
  if (colourIndex == 13) {
    words = "x1 Boost Button Colour";
  }
  
  if (colourIndex == 14) {
    words = "x2 Boost Button Font";
  }

  fontSize(words, width/2, height/2);
  text(words, 6*width/7, height/2 + height/8);
}

////////////////////////////////////////////////////
// Function for displaying the diffuculty menu

void difficultyMenuDisplay() {
  
  background(colours[0]);
  menuText("Difficulty" , 255, width/2, 0.1 * height, width/4, height/6);
  
  for( int i = 23; i <= 25; i++ ) {
    buttonList[i].display();
  }
  
  buttonList[11].displayTri();
  
}



////////////////////////////////////////////////////
// Function that autosizes the text

void fontSize(String string, float rectWidth, float rectHeight) {

  textSize(12);

  float minSizeW = 5/textWidth(string) *rectWidth;

  float minSizeH = 5/(textDescent()+textAscent()) *rectHeight;

  textSize(min(minSizeW, minSizeH));
}

////////////////////////////////////////////////////////////
// Function that draws text within a box. Used for Menu Text
void menuText(String string, color fontColour, float xPos, float yPos, float rectWidth, float rectHeight) {
  
  pushStyle();
  
  textAlign(CENTER);
  rectMode(CENTER);
  
  
  float currentSize = 5;
  float bestSize = 5;
  float sizeIncrement = 0.5;
  
  boolean searching = true;  
  while(searching){
    if(testFontSize(currentSize, rectWidth, rectHeight, string)){
      bestSize = currentSize;
      currentSize += sizeIncrement;
    }else{
      searching = false;
    }
  }
  
  textSize(bestSize);
  fill(fontColour);
  text(string, xPos, yPos, rectWidth, rectHeight);
  
if(debug) {
  noFill();
  stroke(0);
  strokeWeight(1);
  rect(xPos, yPos, rectWidth, rectHeight);
}
  
  popStyle();
  
  
}

////////////////////////////////////////////////////////////
// Function that extends the function of menuText. Thanks to internet for this code.
boolean testFontSize(float s, float Width, float Height, String string) {
  textSize(s);
  // calculate max lines
  int currentLine = 1;
  int maxLines = floor( Height / g.textLeading);
  boolean fitHeight = true;
  int nextWord = 0;
  
  String[] words = string.split(" ");
 
  while (fitHeight) {
    if (currentLine > maxLines) {
      fitHeight = false;
    } else {
      String temp = words[nextWord];
      // check if single word is already too wide
      if (textWidth(temp) > Width)
        return false;
 
      boolean fitWidth = true;
      // add words until string is too wide  
      while (fitWidth) {
 
        if (textWidth(temp) > Width) {
          currentLine++;
          fitWidth = false;
        } else {
          if (nextWord < words.length -1) {
            nextWord++;
            temp += " "+ words[nextWord];
          } else
            return true;
        }
      }
    }
  }
 
  return false;
} 