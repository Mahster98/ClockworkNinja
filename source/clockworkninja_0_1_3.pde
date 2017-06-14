//Started on June 8th 2017
String version = "Alpha V 0.1.3"; //Version number
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

//KetaiGesture gesture;

ArrayList <gBox> Grid;
ArrayList <Guard> security;
ArrayList <Ninja> clan;
ArrayList <Ninja> decoys;


int unit = 90; //Unit size in pixels
Button[] buttonList;
color[] colours;

int menuState = 0; //Menu Stuff
boolean popUpMenu = false;
boolean boost = false;
int colourIndex;

gBox NspawnLoc; //Temporary Reset spawn
ColourPicker colourPicker;
//int debug = 0;


void setup() {


  //size(1000, 1000);
  fullScreen(2);
  textAlign(CENTER);
  orientation(LANDSCAPE);


  //Ketai Touch Gestures
  //gesture = new KetaiGesture(this);

  colourCreate();
  createGrid(width, height, unit);
  createButtons();
  

  //noLoop();
  //frameRate(10);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {

  //background(148);

  algorithms(menuState);
  display(menuState);



  //Debugger
  //deBugger();
  //println(menuState);
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
void mousePressed() {

  mouseCalcs(menuState);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////

void algorithms(int stateOfMenu) {

  if (stateOfMenu == 0) { //Main Menu State
  }

  if (stateOfMenu == 1 || stateOfMenu == 3) { //Play State and How to Play Menu


    for (Ninja Genji : clan) {    

      autonomousGrid(Genji);

      for (gBox i : Grid) {

        if (Genji.xPos == i.box.getParam(0) && Genji.yPos == i.box.getParam(1)) {
          for (gBox j : Grid) {
            Genji.direction(i, j);
            Genji.splitPath(i, j);
          }
        }
      }
    }


    nPathSpawn();
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void mouseCalcs( int stateOfMenu) {

  if (stateOfMenu == 0) { //Main Menu State
     popUpMenu = false;

    if (buttonList[4].buttonTrue() != true) { //Prevents Menu Clicking

      if (buttonList[5].buttonTrue()) { //Play Button
        menuState = 1;
        createGrid(width, height, unit);
        gSpawn();
        nSpawn();
      }

      if (buttonList[6].buttonTrue()) { //How to Play Button
        menuState = 3;
        createGrid(width, height , unit, height/2);
        gSpawn();
        nSpawn();
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

  if (stateOfMenu == 1 || stateOfMenu == 3) {//Play State

    if (popUpMenu == false && clan.get(0).move == false) {
      for (gBox i : Grid) {
        for (int j = Grid.size() -1; j >= 0; j--) {
          gridToggle(i, Grid.get(j));
        }
      }
    }

    if (popUpMenu) {

      //Adds button functionality - Moves the ninja
      if (buttonList[0].buttonTrue()) {
        for (Ninja Genji : clan) {
          Genji.move = true;
        }
        popUpMenu = false;
      }
      
      //Adds functionality for the boost button
      if(buttonList[9].buttonTrue()) {
        
        if(boost) {
          boost = false;
        }
        else {
          boost = true;
        }
        
      }

      //Adds Button functionality for Reseting the game
      if (buttonList[1].buttonTrue()) {

        for ( int k = clan.size() -1; k >= 0; k--) {  //Wipes the Main array for the Ninjas
          clan.remove(k);
        }

        for ( int k = decoys.size() -1; k >= 0; k--) {  //Wipes the Storage array for the Ninjas
          decoys.remove(k);
        }

        //Turns the spawn Location back on, and respawns a Ninja at that location.
        NspawnLoc.nSpawn = true; 
        Ninja Genji = new Ninja (int(NspawnLoc.box.getParam(0)), int(NspawnLoc.box.getParam(1)), 0, 0, 0, 1, unit);
        clan.add(Genji);

        for (gBox i : Grid) {
          i.on = false;
          i.boost = false;
        }
        popUpMenu = false;
      }

      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

      //Adds Button functionality for Creating a new puzzle
      if ((buttonList[2].buttonTrue() && menuState !=3) || buttonList[3].buttonTrue()) {

        for ( gBox i : Grid) { //Resets the grid
          i.on=false;
          i.gSpawn= false;
          i.nSpawn = false;
          i.boost = false;
        }
        
        gSpawn();
        nSpawn();
        boost = false;
        popUpMenu = false;
 

        if (buttonList[3].buttonTrue() ) {
          menuState = 0;
        }
      }

    }
    //redraw();
  }
  
  if (stateOfMenu == 4) { //Options menu
  
  if(buttonList[10].buttonTrue()) {//Colour Selector
  menuState = 5;
  colourPicker = new ColourPicker( width/15, height/8, 2*width/3, 3*height/4 - height/20, 255);
  colourIndex = 6;
  }
  
  if(buttonList[11].buttonTrue()) { // Credits
  menuState = 6;
  }
  
  if(buttonList[12].buttonTrue()) { //Back button - Main Menu
    menuState = 0;
  }
  
  } 
  
  if (stateOfMenu == 5 || stateOfMenu == 6) {
    
    if(buttonList[12].buttonTrue()) { //Back button - Options Menu
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
void display(int stateOfMenu) {

  background(148);

  if (stateOfMenu == 0) { //Main Menu State

    // displayBackground(background[0]);

    for (int i = 8; i > 3; i--) {
      buttonList[i].display();
    }
  }

  if (stateOfMenu == 1) { //Play state

    // displayBackground(background[1]);

    for (gBox i : Grid) {
      displayGrid(i);
    }

    for (Guard i : security) {
      i.display();
    }

    //for (Ninja Naruto : clan){
    //Naruto.display(); //Movement and Display
    //}

    for (int i = clan.size() - 1; i >=0; i--) {
      clan.get(i).display(i);
    }

scoreFunc();

    //Displays button
    if (popUpMenu) {
      for (int i = 0; i < 4; i++) {
        buttonList[i].display();
      }
      buttonList[9].display(boost);
    }

    
  }

  if (stateOfMenu == 3) {
    
    howToPlay();
    
    for (gBox i : Grid) {
      displayGrid(i);
    }
    
    for (Guard i : security) {
      i.display();
    }

    for (int i = clan.size() - 1; i >=0; i--) {
      clan.get(i).display(i);
    }


    if (popUpMenu) {
      buttonList[0].display();
      buttonList[1].display();
      buttonList[3].display();
      buttonList[9].display(boost);
    }
  }
  
  if (stateOfMenu == 4 || stateOfMenu == 5 || stateOfMenu == 6) {
    
    background(80);
    buttonList[12].displayTri();
  
  if (stateOfMenu == 4) { //Options Menu
    
    
    fill(255);
    textSize(68);
    text("Options", width/2, height/10);
    buttonList[10].display();
    buttonList[11].display();
  }
  
  if (stateOfMenu == 5) { //Colour Selector Menu
  
  colourCalculationsDisplay();
  
  }
  
  if (stateOfMenu == 6) { //Credits Menu
    fill(255);
    textSize(25);
    text(version, width/25, height/36);
    
    textSize(69);
    text("Created by Alex Mah \n Special Thanks to: \n Dr. Laleh Bejat \n All of My Playtesters (You rock)", width/2, height/4);
    
    textSize(48);
    text("Patch notes \n" + 
    "New Feature: Boost Square \n" +
    "Added a Colour Selector to Dynamically Change Colours" +
    "\n Score now features difference in time between first and last squares", 
    width/2, 3*height/4);
    
  }
  
    
  
  }
    
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Check for Gestures

//public boolean surfaceTouchEvent(MotionEvent event) {

//  //call to keep mouseX, mouseY, etc updated
//  super.surfaceTouchEvent(event);

//  //forward event to class for processing
//  return gesture.surfaceTouchEvent(event);
//}