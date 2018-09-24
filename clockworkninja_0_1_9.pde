//Started on July 14th 2017
String version = "Alpha V 0.1.8"; //Version number
//Created by Alex Mah

/* Note to self: 
 
 - Uses Ketai Library - Might need to attach when adding to the app store?
 - Colour Picker from - https://forum.processing.org/one/topic/processing-color-picker.html
 - Clean up draw() and mousePressed functions. Getting Messy!! 
 
 
 */


////////////////////////////////////////////////////
// Imports
//import android.view.MotionEvent;
//import ketai.ui.*;

////////////////////////////////////////////////////
// Global Variables

//Uncomment for Android

//KetaiGesture gesture;

ArrayList <gBox> Grid;
ArrayList <Guard> security;
ArrayList <Ninja> clan;
ArrayList <Ninja> decoys;
ArrayList <boost> boosters = new ArrayList<boost>();



int unit = 90; //Unit size in pixels
Button[] buttonList;
color[] colours;

int menuState = 0; //Menu Stuff
boolean popUpMenu = false;
boolean numAssist = false;
//boolean move = false;
int boost = 0;
int colourIndex;
String difficulty;

gBox NspawnLoc; //Reset spawn
ColourPicker colourPicker;
scoreSaver score = new scoreSaver();
scoreSaver bestScore = new scoreSaver();

float doubleClickHelper = millis();
boolean debug = true;


void setup() {


  //size(1000, 1000);
  fullScreen(2);
  textAlign(CENTER);
  orientation(LANDSCAPE);


  //Ketai Touch Gestures
  //gesture = new KetaiGesture(this);

  colourCreate();
  //createGrid(width, height, unit);
  createButtons();


  //noLoop();
  //frameRate(5);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {

  //background(148);

  algorithms(menuState);
  display(menuState);



  //Debugger
  
  if(debug) {
  //deBugger();
  //score.getProperties();
  }
  
  //println(boosters.size());
  //println(" ");
  //println("*****************");
  //println(" ");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void mousePressed() {

  mouseCalcs(menuState);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void algorithms(int stateOfMenu) {

  if (stateOfMenu == 0) { //Main Menu State
  }

  if (stateOfMenu == 1 || stateOfMenu == 8 || stateOfMenu == 9 || stateOfMenu == 10 || stateOfMenu == 12 || stateOfMenu == 13) { //Play State and certain how to play Menus


    for (Ninja Genji : clan) {    

      autonomousGrid(Genji);



      for (gBox i : Grid) {

        for ( boost boo : boosters) {
          boo.charging(i, Genji);
        }

        if (boxCheck(Genji, i)) {

          Genji.counterChecker(i);

          for (gBox j : Grid) {
            Genji.direction(i, j);
            Genji.splitPath(i, j);
          }
        }
      }
    }


    nPathSpawn();
    for( boost ugh : boosters) {
      ugh.chargeAssist();
    }
    
    if ( allNinjasStop() ) {
    score.scoreCalculator();
    }
    
  }

  if (stateOfMenu == 8) { //Autonomous Start

    if (millis() - clan.get(0).time > 1500) {

      clan.get(0).move = true;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void mouseCalcs( int stateOfMenu) {

  if (stateOfMenu == 0) { //Main Menu State
    popUpMenu = false;
    difficulty = "";

    if (buttonList[4].buttonTrue() != true) { //Prevents Menu Clicking

      if (buttonList[5].buttonTrue()) { //Play Button
        
        menuState = 2;
        
        //unit = 50;
        //clearArrays();
        //menuState = 1;
        //createGrid(width, height, unit);
        //gSpawn();
        //nSpawn();
      }

      if (buttonList[6].buttonTrue()) { //How to Play Button
        unit = 90;
        menuState = 7;
      }

      if (buttonList[7].buttonTrue()) { //Options Button
        menuState = 4;
      }

      if (buttonList[8].buttonTrue()) { //Exit Button
        System.exit(0);
      }
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  if (stateOfMenu == 2) { //Difficulty Menu Calculations
    
    
    if ( buttonList[23].buttonTrue()|| buttonList[24].buttonTrue() || buttonList[25].buttonTrue() ){
    
      
    
  
    if (buttonList[23].buttonTrue() ) {  //Easy Button
       
        difficulty = "Easy";
    
    }
    
    if (buttonList[24].buttonTrue() ) { //Medium Difficulty
        difficulty = "Medium";
    }
    
    if (buttonList[25].buttonTrue() ) { //Hard Difficulty
        difficulty = "Hard";
    }
    
    
    //if (Impossible) {
      
    //  unit = 30;
    //  lower = 40;
    //  upper = 60;
      
    //}
    
    difficultySpawn(difficulty);
  
  }
  
  if ( buttonList[11].buttonTrue() ) {
    menuState = 0;
  }
  
  
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if (stateOfMenu == 1 || stateOfMenu == 9 || stateOfMenu == 10 || stateOfMenu == 13) { //Play State && Certain How to Play States

    if (popUpMenu == false && clan.get(clan.size() - 1).move == false) {

      for (gBox i : Grid) {  //Grid toggling
        for (int j = Grid.size() -1; j >= 0; j--) {

          gridToggle(i, Grid.get(j)); 

          if (numAssist) {
            i.numberAssistant(Grid.get(j));
          }
        }
        boostToggle(i);
      }
    }

    if ((stateOfMenu == 1 || stateOfMenu == 13) && popUpMenu == false ) { //Boost Buttons Functionality

      if (buttonList[19].buttonTrue()) { // x1 Boost

        boost = 1;
      } else if (buttonList[20].buttonTrue()) {  // x2 Boost

        boost = 2;
      } else if (buttonList[21].buttonTrue()) { // x3 Boost

        boost = 3;
      } else {
        boost = 0;
      }
    }

    if (popUpMenu) {

      //Adds button functionality - Moves the ninja
      if (buttonList[0].buttonTrue()) {
        //move = true;
        for (Ninja Genji : clan) {
          Genji.move = true;
        }

        if ( numAssist) {

          for (gBox i : Grid) { //Clears the Number Assistant
            i.ghostNum = i.numAssist;
            i.numAssist = 0;
          }
        }

        popUpMenu = false;
      }

      //Adds functionality for the boost button
      //if (buttonList[19].buttonTrue() && (stateOfMenu == 1 || stateOfMenu == 13) ) {

      //  boost++;
      //  if (boost > 3) {
      //    boost = 0;
      //  }
      //}

      //Adds Button functionality for Reseting the game
      if (buttonList[1].buttonTrue()) {
        reset();
      }
      if ((buttonList[2].buttonTrue() && stateOfMenu == 1) || buttonList[3].buttonTrue()) {
        newPuzzle();
      }

      if (buttonList[3].buttonTrue() ) {
        menuState = 0;
      }

      if (buttonList[22].buttonTrue() ) {
        restore();
      }
    }
  }


  ////////////////////////////////////////////
  // How to play buttons

  if (stateOfMenu >= 7) {

    howToPlayMouseCalcs(stateOfMenu);
  }


  if (stateOfMenu == 4) { //Options menu

    if (buttonList[9].buttonTrue()) {//Colour Selector
      menuState = 5;
      colourPicker = new ColourPicker( width/15, height/8, 2*width/3, 3*height/4 - height/20, 255);
      colourIndex = 6;
    }

    if (buttonList[10].buttonTrue()) { // Credits
      menuState = 6;
    }

    if (buttonList[11].buttonTrue()) { //Back button - Main Menu
      menuState = 0;
    }

    if (buttonList[18].buttonTrue()) { //Number Assistant Button
      if (numAssist) {
        numAssist = false;
      } else {
        numAssist = true;
      }
    }
  } 

  if (stateOfMenu == 5 || stateOfMenu == 6) {

    if (buttonList[11].buttonTrue()) { //Back button - Options Menu
      menuState = 4;
    }

    if (stateOfMenu == 5) { //Colour selector

      colourCalcs();
    }

    if (stateOfMenu == 6) { //Credits Menu
      //Good Place to hide some easter eggs :)
    }
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void display(int stateOfMenu) {


  if (stateOfMenu == 0) { //Main Menu State

    // displayBackground(background[0]);

    for (int i = 8; i > 3; i--) {
      buttonList[i].display();
    }
  }
  
 if (stateOfMenu == 2) { //Difficulty Menu
   
   difficultyMenuDisplay();
   
 }

  if (stateOfMenu == 1) { //Play state

    background(148);

    for (gBox i : Grid) {
      displayGrid(i);
    }

    //for (Guard i : security) {
    //  i.display();
    //}

    //for (Ninja Naruto : clan){
    //Naruto.display(); //Movement and Display
    //}

    for (int i = clan.size() - 1; i >=0; i--) {
      clan.get(i).display(i);
    }

    if (numAssist) { //Number Assistant
      for (gBox i : Grid) {
        i.numberDisplay();
      }
    }

    for (boost i : boosters) {
      i.display();
    }

    for (int i  = 19; i < 22; i++) {
      buttonList[i].display(boost);
    }

    /////////////////////////////////////////////////////////////
    //Score Functionality
    //scoreFunc();
    
    if( allNinjasStop () ) {
    score.displayScore(bestScore);
    }

    //Displays button
    if (popUpMenu) {

      for (int i = 0; i < 4; i++) {
        buttonList[i].display();
      }

      buttonList[22].display();
    }
  }

  if (stateOfMenu >= 7) { //How to Play Menu

    background(255);

    if ( stateOfMenu == 8 || stateOfMenu == 9 || stateOfMenu == 10 || stateOfMenu == 13) { //Displays for anything involving a grid

      for (gBox i : Grid) {
        displayGrid(i);
      }

      //for (Guard i : security) {
      //  i.display();
      //}

      for (int i = clan.size() - 1; i >=0; i--) {
        clan.get(i).display(i);
      }


      if (menuState >= 12) { //Boost button Display

        for  (int i = 19; i < 22; i ++) {
          buttonList[i].display(boost);
        }
      }

      if (numAssist) { //Number Assistant
        for (gBox i : Grid) {
          i.numberDisplay();
        }
      }
    }

    if (stateOfMenu == 12 || stateOfMenu == 13) { //These menus involve the booster squares

      for (boost i : boosters) {
        i.display();
      }
    }


    if (stateOfMenu != 7) {   //Back button
      buttonList[16].displayTri();
    }

    if (stateOfMenu != 14) { //Forward button
      buttonList[17].displayTri();
    }

    howToPlay(stateOfMenu);


    if (popUpMenu) {
      buttonList[0].display();
      buttonList[1].display();
      buttonList[3].display();
      buttonList[22].display();
    }
  }

  if (stateOfMenu >= 4 && stateOfMenu <= 6) {
    optionsMenu(menuState, numAssist);
  }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Check for Gestures

//boolean surfaceTouchEvent(MotionEvent event) {

//  //call to keep mouseX, mouseY, etc updated
//  super.surfaceTouchEvent(event);

//  //Forward event to class for processing
//  return gesture.surfaceTouchEvent(event);
//}