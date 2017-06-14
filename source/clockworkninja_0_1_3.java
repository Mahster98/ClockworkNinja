import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class clockworkninja_0_1_3 extends PApplet {

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
int[] colours;

int menuState = 0; //Menu Stuff
boolean popUpMenu = false;
boolean boost = false;
int colourIndex;

gBox NspawnLoc; //Temporary Reset spawn
ColourPicker colourPicker;
//int debug = 0;


public void setup() {


  //size(1000, 1000);
  
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
public void draw() {

  //background(148);

  algorithms(menuState);
  display(menuState);



  //Debugger
  //deBugger();
  //println(menuState);
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
public void mousePressed() {

  mouseCalcs(menuState);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////

public void algorithms(int stateOfMenu) {

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
public void mouseCalcs( int stateOfMenu) {

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
        Ninja Genji = new Ninja (PApplet.parseInt(NspawnLoc.box.getParam(0)), PApplet.parseInt(NspawnLoc.box.getParam(1)), 0, 0, 0, 1, unit);
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
public void display(int stateOfMenu) {

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
////////////////////////////////////////////////////
// Function that is the Double Click/Tap Functionality

public void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2) {
    doubleClick();
  }
}

public void onDoubleTap(float x, float y)
{
  doubleClick();
}



////////////////////////////////////////////////////
// A Function that builds a grid!

public void createGrid( int Width, int Height, int size) {

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

public void createGrid (int Width, int Height, int size, int yPos){
  
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

public void createButtons() { 

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
  buttonList[4] = new Button(width/4, height/3, width/2, height/4, color(0xff1d3461), 255, 72, "Clockwork Ninja");

  //Play Button
  buttonList[5] = new Button(0, 0, width/2, height/2, color(0xffbb0a21), 0, 68, "Play");

  //How to Play button

  buttonList[6] = new Button(width/2, 0, width/2, height/2, color(0xff252627), 255, 68, "How to Play");

  //Options Buttons

  buttonList[7] = new Button(0, height/2, width/2, height/2, color(0xff4b88a2), 0, 68, "Options");

  //Exit Button

  buttonList[8] = new Button(width/2, height/2, width/2, height/2, color(0xff318240), 0, 68, "Exit");
  
  ////////////////////////////////////////////////////////////////////////////////
  
  //Boost Button
  
  buttonList[9] = new Button(width/4, 0, width/2, height/5, colours[4], colours[10], 68, "Boost"); 
  
  /////////////////////////////////
  //Some Options Buttons
  
  //Color Selector Menu Button
  
  buttonList[10] = new Button( 1.25f*width/5, height/4, width/2, height/5, color(0xff318240), 255, 68, "Colour Selector");
  
  //Credits Button
  
  buttonList[11] = new Button( 1.25f*width/5, height/2, width/2, height/5, color(0xff318240), 255, 68, "Credits");
  
  //Back Button
  
  buttonList[12] = new Button(0, 5*height/6, width/10, height/6, color(0xff318240), 255, 68, "Left");
  
  //Colour Selector Save Button
  
  buttonList[13] = new Button( width/3, 5*height/6, width/3, height/6, color(0xffbb0a21), 0, 68, "Save");
  
  //Colour Selector Left Button
  
  buttonList[14] = new Button( width - width/4, height/2 - height/6, width/25, height/8, color(0xff318240), 255, 68, "Left");
  
  //Colour Selector Right Button
  
  buttonList[15] = new Button( width - width/12, height/2 - height/6, width/25, height/8, color(0xff318240), 255, 68, "Right");
  
  //Default Colours Button
  
  buttonList[16] = new Button (3 *width/4, 5*height/6, width/4, height/6, color(0xff4b88a2), 0, 68, "Default Settings");
  
}

////////////////////////////////////////////////////
// A Function for intial colours and storage of colours
public void colourCreate() {

  colours = new int[11];
  
   //Almost Black
  colours[0] = color(0xff252627);
  
  //Light Blue
  colours[1] = color(0xff4b88a2);
  
  //Moss Green
  colours[2] = color(0xff318240);
  
  //Light Purple - Squares
  colours[3] = color(0xff565Cf2);
  
  //Deep blue color - The one for the Boost Square
  colours[4] = color(0xff1d3461);
  
  //Baby Blue - Squares
  colours[5] = color(0xff14EBFC);
  
  //Light Orange - Squares
  colours[6] = color(0xffFFA20A);
  
  //Dark Orange - Squares
  colours[7] = color(0xffFF7C0F);
  
  //Red colour
  colours[8] = color(0xffbb0a21);
  
  //Font colour for Pop Up Menu Button
  colours[9] = color(0);
  
  //Font colour for Boost Button
  colours[10] = color(255);
  
  
}

////////////////////////////////////////////////////
// A Function for displaying Background Images

public void displayBackground(PImage background) {

  //Draws image into background
  for (int x = 0; x < width; x += background.width) {
    for (int y = 0; y < height; y += background.height) {
      image(background, x, y);
    }
  }
}

////////////////////////////////////////////////////
// A Function that returns true if on a certain part of the grid

public boolean mouseWithinGrid(PShape node, float size) {


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
public int isAdj(gBox center, gBox adjacent) {


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

public int isPermissable(gBox i) {

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
public void gridToggle(gBox center, gBox adj) {

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

public void autonomousGrid(Ninja Genji) {

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
public void displayGrid(gBox i) {


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
public void gSpawn() {

  boolean reset;
  

do {
  reset = false;
  security = new ArrayList<Guard>(); //Creating the ArrayList
  int numSpawn = PApplet.parseInt(random(2, 6));  //Controls the amount of enemies in total 

  for ( int i = 0; i <= numSpawn - 1; i++) {

    while (true) {                                //Loop to prevent double spawnings
      int index = PApplet.parseInt(random(Grid.size()));
      gBox spawnLoc = Grid.get(index);

      if ( spawnLoc.nSpawn == false && spawnLoc.gSpawn == false) {
        spawnLoc.gSpawn = true;
        Guard guard = new Guard (PApplet.parseInt(spawnLoc.box.getParam(0)), PApplet.parseInt(spawnLoc.box.getParam(1)), unit);
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

public void nSpawn() {

  boolean reset;
  
  do {
  reset = false;
  clan = new ArrayList<Ninja>(); //Creating the ArrayList for Actual ninjas
  decoys = new ArrayList<Ninja>(); //Creates an Arraylist to Save Decoy data

  while (true) {                            //Same algorithm to spawn in the Ninja as the guards
    int index = PApplet.parseInt(random(Grid.size()));
    gBox spawnLoc = Grid.get(index);
    NspawnLoc = spawnLoc; //Temp Respawn Stuff

    if ( spawnLoc.nSpawn == false && spawnLoc.gSpawn == false) {
      spawnLoc.nSpawn = true;
      Ninja Genji = new Ninja (PApplet.parseInt(spawnLoc.box.getParam(0)), PApplet.parseInt(spawnLoc.box.getParam(1)), 0, 0, 0, 1, unit);
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

public void nPathSpawn() {
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

public void textFunc(PShape button, String text, int fontSize, int fontcolour) {

  fill(fontcolour);                                            //Puts the text in the center of the rectangular button, with the specified colour and size
  textSize(fontSize);
  float xCord = button.getParam(0) + button.getParam(2)/2;
  float yCord = button.getParam(1) + button.getParam(3)/2;
  text(text, xCord, yCord);
}


////////////////////////////////////////////////////
// Function that Calculates the scores

public void scoreFunc() {
  
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
    
    text("Distance: " + PApplet.parseInt(distance), width/4, height/15);
    text("Time: " + time, 3*width/4, height/15);
    }
    
    else {
      
      text("Score", width/2, height/15);
    }
  
  
}

////////////////////////////////////////////////////
// Function that activates when double clicked/tapped

public void howToPlay() {
  
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

public void colourCalcs() {
  
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

public void colourCalculationsDisplay() {
  
  String words = "Hello";
  
  
  //Displays Buttons
  colourPicker.display();
  buttonList[13].display() ;
  buttonList[14].displayTri();
  buttonList[15].displayTri();
  buttonList[16].display();

  //Example Colour Square
  fill(colourPicker.colourGet());
  rect(5.72f*width/7, height/3 - height/6, height/8, height/8);
  
  //Set Colour Square
  fill(colours[colourIndex]);
  rect(5.72f*width/7, height/2 - height/6, height/8, height/8);
  
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
public void doubleClick () {

  if (popUpMenu) {
    popUpMenu = false;
  } else {
    popUpMenu = true;
  }
}

////////////////////////////////////////////////////
// Function that prints debugging information

public void deBugger() {

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
////////////////////////////////////////////////////
// Class for Ninja player object

class Ninja {

  int xPos, yPos;
  int dx, dy;
  float size, time;
  boolean move, stop;
  int speed, strokeWeight, ninPath;
  int strokeColour;

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

  public void direction(gBox center, gBox adj) {


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

  public void splitPath( gBox center, gBox adj) {

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


      Ninja substitute = new Ninja(PApplet.parseInt(center.box.getParam(0)), PApplet.parseInt(center.box.getParam(1)), Dx, Dy, ninPath + add, speed, unit);  //Creates a new "Ninja" Substitute
      substitute.move = true;


      decoys.add(substitute); //Saves copy to the storage array.

      if (adj.gSpawn) {
        ninPath --;
      }
    }
  }


  public boolean endPathCheck(gBox center) {    //Checks if the Ninja is at a Dead End
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

  public void endSave() { //Saves when all Stop?

    if (stop == false) {

      time = millis();
      stop = true;
    }
  }


  public void display(int i) {
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

  public void display() {
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
  int buttonColour, textColour;
  int textSize;

  Button(float txPos, float tyPos, float txSize, float tySize, int tButtonC, int tTextC, int tTextS, String tLabel) {


    buttonColour = tButtonC;
    box = createShape(RECT, txPos, tyPos, txSize, tySize);
    textColour = tTextC;
    textSize = tTextS;
    label = tLabel ;
  }

  public void display() {

   //box.setTint(false);
    box.setFill(buttonColour);
    shape(box);
    fill(textColour);                                            //Puts the text in the center of the rectangular button, with the specified colour and size
    textSize(textSize);
    float xCord = box.getParam(0) + box.getParam(2)/2;
    float yCord = box.getParam(1) + box.getParam(3)/2;
    text(label, xCord, yCord);
  }
  
  public void display(boolean boost) {
    
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
  
  public void displayTri() {
    
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

  public boolean buttonTrue() {

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
  
  public void init ()
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

 public void setGradient(int x, int y, float Height, int c1, int c2 )
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
  
  public void drawRect( int rx, int ry, int rw, int rh, int rc )
  {
    for(int i=rx; i<rx+rw; i++) 
    {
      for(int j=ry; j<ry+rh; j++) 
      {
        cpImage.set( i, j, rc );
      }
    }
  }
  
  public int colourGet ()
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
  
  public void display() {
     image( cpImage, x, y );
  }
}
  public void settings() {  fullScreen(2); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "clockworkninja_0_1_3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
