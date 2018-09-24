////////////////////////////////////////////////////
// Function that is the Double Click/Tap Functionality

void mouseClicked(MouseEvent evt) {

  float clickTimer = millis() - doubleClickHelper;
  //println(millis(), doubleClickHelper, clickTimer);

  if (evt.getCount() == 2 && clickTimer > 140 && clickTimer < 350) {
    doubleClick();
  }

  doubleClickHelper = millis();
}

void onDoubleTap(float x, float y)
{
  doubleClick();
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
// A Function that returns true if Ninja is on the same gBox
boolean boxCheck(Ninja Genji, gBox i) {

  int speed = Genji.speed;


  if (Genji.xPos < i.box.getParam(0) + speed && Genji.xPos > i.box.getParam(0) - speed && 
    Genji.yPos > i.box.getParam(1) - speed && Genji.yPos < i.box.getParam(1) + speed) {
    return true;
  } else
  {
    return false;
  }
}

////////////////////////////////////////////////////
// A Function that returns true if Ninjas are on the same square. Basically for organisation
boolean sameNinja(Ninja Genji, Ninja Greninja) {

  boolean result = false;

  int speed;

  if (Genji.speed > Greninja.speed) {
    speed = Genji.speed + Genji.deaccel;
  } else if (Greninja.speed > Genji.speed) {
    speed = Greninja.speed + Genji.deaccel;
  } else {
    speed = Genji.speed + Genji.deaccel;
  }

  if ( Genji.xPos > Greninja.xPos - speed && Genji.xPos < Greninja.xPos + speed) {
    if (Genji.yPos > Greninja.yPos - speed && Genji.yPos < Greninja.yPos + speed) {
      if (Genji.dx == Greninja.dx || Genji.speed == Greninja.speed - Greninja.deaccel) {
        if (Genji.dy == Greninja.dy || Genji.speed == Greninja.speed - Greninja.deaccel) {

          result = true;
        }
      }
    }
  }



  //println(Genji.speed, Greninja.speed, speed);

  //if ( Genji.xPos >= Greninja.xPos - speed && Genji.xPos <= Greninja.xPos + speed) {
  //  if (Genji.yPos >= Greninja.yPos - speed && Genji.yPos <= Greninja.yPos + speed) {
  //    if ((Genji.dx >= 0 && Greninja.dx >= 0) || (Genji.dx <= 0 && Greninja.dx <= 0)) {
  //      if ((Genji.dy >= 0 && Greninja.dy >= 0) || (Genji.dy <= 0 && Greninja.dy <= 0)) {

  //        result = true;
  //      }
  //    }
  //  }
  //}

  return result;
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


      if ((adj.on == true || adj.nSpawn == true) && center.gSpawn == false) {  //Checks if any of the surrounding boxes is pretoggled or the starting piece, and is Adjacent
        //If true, then goes through


        if (center.on == false) {
          center.on = true;
          center.ghostBoost = 0;
        } else if (center.on == true) {
          center.on = false;
          center.ghostBoost = -1;
        }
      }
    }
  }

}
////////////////////////////////////////////////////
// A Function that toggles the boosts

void boostToggle(gBox center) {

  if (mouseWithinGrid(center.box, unit)) {

    if (center.on) {

      if (center.boost && boost == 0) {
        center.boost = false;
        center.ghostBoost = 0;
      }

      if (boost != 0) {
        if (center.boost == false) {
          center.boost = true;
          boost Boost = new boost(center.box.getParam(0), center.box.getParam(1), unit, boost);
          boosters.add(Boost);
          center.ghostBoost = boost;
        }
      }
    }

    //if (center.on == false) {
    //   center.boost = false;
    //   center.ghostBoost = -1;
    //  }
  }
}

////////////////////////////////////////////////////
// A Function that does grid calculations in draw instead of mousePressed

void autonomousGrid(Ninja Genji) {



  for (gBox center : Grid) {   //Basically Locks in the Grid if the Ninjas are in motion

    if (center.gSpawn) {

      boolean side = false;

      for (gBox adj : Grid) {


        if (isAdj(center, adj) != 0 && adj.on == true) {

          if (Genji.move) {
            side = true;
          }

          if (side) {
            center.on = true;
          }

          if (center.gSpawn && adj.numAssist != 0 && (center.numAssist > adj.numAssist || center.numAssist == 0) && allNinjasStop() == false) { 
            //This adds numbers to the Guards when there is a nearby on block

            center.numAssist = adj.numAssist + 1;
          }
        
      }
      
    }
    
  }



    if (center.on == false && center.boost == true) { //Turns off the booster squares
      center.boost = false;
    }
    
     if (isPermissable(center) == 0 || (center.on == false && isPermissable(center) == 1 && center.gSpawn == false)) {  //Resets all the numAssist numbers
     center.numAssist = 0;
    }
    
  }
  //}

  //if (numAssist) { //For the Number Assistant

  //  for (gBox center : Grid) {
  //    for (gBox adj : Grid) {
  //      if (isAdj(center, adj) != 0 && adj.gSpawn && center.on && (center.numAssist < adj.numAssist || adj.numAssist == 0) && clan.get(clan.size()-1).move == false) { 

  //        adj.numAssist = center.numAssist + 1;
  //      }
  //    }
  //  }
  //}
  
  
}



////////////////////////////////////////////////////
// A Function that Displays the Grid. Also includes toggle functionality
void displayGrid(gBox i) {


  if (i.on == false || isPermissable(i) >= 3 ) {

    i.box.setFill(color(255));     //Returns it to White
  }

  if (i.ghostBoost == 0) {   //Ghost Path for Normal Squares
    i.box.setFill(colours[10]);
  }

  if (i.ghostBoost == 1) {  //Ghost Path for Level 1 Boost
    i.box.setFill(colours[13]);
  }

  if (i.ghostBoost == 2) {  //Ghost Path for level 2 Boosts
    i.box.setFill(colours[14]);
  }

  if (i.ghostBoost == 3) {  //Ghost Path for Level 3 Boosts
    i.box.setFill(colours[4]);
  }

  if (i.ghostBoost == 4) {  //Original Square Boosts
    i.box.setFill(colours[11]);
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
  
  if (i.gSpawn) {
    i.box.setFill(color(255, 0, 0));
  }
  
  if (i.blockage) {
    i.box.setFill(color(0, 0, 255));
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
// Function Spawns the Ninja on Paths

void nPathSpawn() {
  boolean spawn = false;

  for ( Ninja Genji : clan) {
    for (gBox grid : Grid) {

      if (boxCheck(Genji, grid) && isPermissable(grid) >=1) { //Checks if the Ninja location is the same as the Grid
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
  }

  for (int i = clan.size() - 1; i >= 0; i --) { //Removes Duplicates from Main array
    for (int j = clan.size() - 1; j >= 0; j --) {
      if (i != j && sameNinja(clan.get(i), clan.get(j))) {

        if ( clan.get(i).time > clan.get(j).time && clan.get(j).time != 0) {
          clan.get(i).time = clan.get(j).time;
          clan.get(i).ninPath = clan.get(j).ninPath;
        }

        clan.remove(j);
        break;
      }
    }
  }

  for ( int i = boosters.size() - 1; i >= 0; i--) { //Removes boosters
    if (boosters.get(i).remove) {
      boosters.remove(i);
    }
  }
}


////////////////////////////////////////////////////
// Function to put all the clearing of the arrays

void clearArrays() {

  //Essentially creates more arrays to "wipe" the previous ones. Dunno if uses more memory but hey
  clan = new ArrayList<Ninja>();
  decoys = new ArrayList<Ninja>();
  boosters = new ArrayList<boost>();
}



////////////////////////////////////////////////////
// Function that calculates the scores

void scoreFunc() {

  float distance = 0, time = 0;
  String endMessage = "Score";
  //boolean winCondition = false;


  //if (clan.size() == 1 && clan.get(0).stop && winCondition() ) { //This is the score for when only one square reaches the end point

  //  endMessage = "Failure = Don't forget you can split paths" ;
  //}

  if (clan.size() > 1) { //For when the Path split



    int counter = 0;

    //if ( winCondition() ) { //When the last one in the array stops moving. Typically the last one but sometimes not

    //  for (int i = clan.size() - 1; i >= 0; i--) {
    //    for (int j = security.size() - 1; j >= 0; j--) {

    //      if (clan.get(i).xPos == security.get(j).xPos && clan.get(i).yPos == security.get(j).yPos) { //If on a Guard square

    //        counter ++;
    //      }
    //    }
    //  }
    //}


    //if (counter != security.size() && winCondition() == false ) { //Calculates error of missing
    //  int squareNum = abs(counter - security.size());
    //  endMessage = "You are off by " + squareNum + " squares.";
    //}


    if (counter == security.size()) { //If all are on the Guard Squares

      float minTime = clan.get(0).time;
      float maxTime = clan.get(0).time;
      int minPath = clan.get(0).ninPath, maxPath = clan.get(0).ninPath;

      for (int i = clan.size() - 1; i >= 0; i--) {  //Calculates the Minimum and Maximum time it took to get there


        if (clan.get(i).time < minTime) {


          minTime = clan.get(i).time;
          minPath = clan.get(i).ninPath;
        } else if (clan.get(i).time > maxTime) {


          maxTime = clan.get(i).time;
          maxPath = clan.get(i).ninPath;
        }
      }



      for (int i = clan.size() - 1; i >= 0; i--) { //Bit of QOL asthetic to the squares. The Green square is the first Square to Stop, while the Red square is last to stop.

        if (clan.get(i).time == minTime) {
          clan.get(i).strokeWeight = 5;
          clan.get(i).strokeColour = color(0, 255, 0);
        } else if (clan.get(i).time == maxTime) {

          clan.get(i).strokeWeight = 5;
          clan.get(i).strokeColour = color(255, 0, 0);
        } else {
          clan.get(i).strokeWeight = 1;
          clan.get(i).strokeColour = color(0);
        }

        //fill(255);
        //fontSize("99", width/8, height/8);
        //text(clan.get(i).ninPath, clan.get(i).xPos + unit/2, clan.get(i).yPos + 6*unit/8);
        menuText(str(clan.get(i).ninPath), 255, clan.get(i).xPos + unit/2, clan.get(i).yPos + unit/2, unit, unit);
      }

      //winCondition = true;
      distance = abs(maxPath - minPath);
      time = (maxTime - minTime)/1000;
    }
  }

  //fill(0);
  //if ( winCondition() ) {

  //  fontSize("Score", width/6, height/6);
  //  text("Distance: " + int(distance), width/4, height/15);
  //  text("Time: " + time + " sec", 3*width/4, height/15);
  //}

  //if (winCondition() == false) {
  //  fontSize("Score", width/4, height/6);
  //  text(endMessage, width/2, height/15);
  //}
}

////////////////////////////////////////////////////
// Function that Calculates if you have won

int winCondition() {
  

  // 0 is the in transist state. Nothing should happen
  // 1 is True win
  // 2 is when they almost have completed the puzzle
  // -1 is for the lazy failure
  

  
  int counter = 0;
  
  for (Ninja Genji : clan) {
    for ( Guard Guy : security) {

      if (Genji.xPos == Guy.xPos && Genji.yPos == Guy.yPos) {
        counter ++;
      }
    }
  }
  
  

  if (counter == clan.size() && counter == security.size() ) {
    return 1;
  } 
  
  if (counter != clan.size() || counter != security.size() ){
    
    int dif;
    
    if( clan.size() < security.size() ){
      dif = security.size();
    }
    
    else {
      dif = clan.size();
    }
    
    score.offBy = abs(counter - dif);
    return 2;
  }


if (clan.size() == 1) { //Lazy failure
  
  return -1;
  
}

return 0;


}

////////////////////////////////////////////////////
// Function that Calculates if you have Won on the How To Play Menu

boolean howToPlayWin() {
  
  if (allNinjasStop() ) {
  
  int counter = 0;
  
  if (clan.get(clan.size() -1).move == false) {
  
  for (Ninja Genji : clan) {
    for ( Guard Guy : security) {
      
      if (Genji.xPos == Guy.xPos && Genji.yPos == Guy.yPos){
        counter ++;
      }
    }
  }
  }
  

  
    if ( menuState == 13 ) { //For the how to Play Menu with the Boosts

    boolean howtoPlayBoostWin = false;

    for (gBox i : Grid) {

      if ( i.ghostBoost > 0 && i.ghostBoost < 4) {
        howtoPlayBoostWin = true;
      }
    }

    if (howtoPlayBoostWin && counter == clan.size() && counter == security.size()) {
      return true;
    } else {
      return false;
    }
  }
  
  
  if (counter == clan.size() && counter == security.size() ) {
    return true;
  }
    else {
      return false;
    }
  }
  
  else {
    return false;
  }
  
}

////////////////////////////////////////////////////
// Function that finds if all the Ninjas have stopped moving

boolean allNinjasStop() {
  
  if (clan.get(0).ninPath != 1) {
  
  int counter = 0;
  
  for (Ninja Genji : clan) {
    
    if(Genji.move == false) {
      counter++;
    }
  }
  
  if ( counter == clan.size() ) {
    return true;
  }

  
  }
  
  return false;
  
}


////////////////////////////////////////////////////
// Function that finds path from one Ninja to a Guard Square
void pathFinder() {

  float centerXPos = 0;
  float centerYPos = 0;
  float gXpos = 0;
  float gYpos = 0;
  boolean reset = true;

  for ( gBox i : Grid) { //Inital saving of location

    if ( i.nSpawn ) {

      centerXPos = i.box.getParam(0);
      centerYPos = i.box.getParam(1);
    }

    if (i.gSpawn) {
      gXpos = i.box.getParam(0);
      gYpos = i.box.getParam(1);
    }
  }

  while (reset) {

    for ( gBox i : Grid) { 

      if (i.box.getParam(0) == centerXPos && i.box.getParam(1) == centerYPos) { //Checks for Position

        for ( gBox j : Grid) {

          if ( isAdj(i, j) != 0 && j.on != true) {

            float adjXPos = j.box.getParam(0);
            float adjYPos = j.box.getParam(1);

            float centerDisX = abs(gXpos - centerXPos);
            float centerDisY = abs(gYpos - centerYPos);

            float adjDisX = abs(gXpos - adjXPos);
            float adjDisY = abs(gYpos - adjYPos);

            if ( adjDisX < centerDisX || adjDisY < centerDisY) { //If the Adjacent Square is closer to the Center Square

              j.on = true;
              j.ghostBoost = 0;

              centerXPos = j.box.getParam(0);                    //Saves the square that is closer as the Center Square
              centerYPos = j.box.getParam(1);

              break;
            }
          }
        }
      }
    }

    if (centerXPos == gXpos  && centerYPos == gYpos) { //Keeps Loop going until the path is complete
      reset = false;
    }
  }
}


////////////////////////////////////////////////////
// Function that resets the Game

void reset() {
  clearArrays();

  //Turns the spawn Location back on, and respawns a Ninja at that location.
  NspawnLoc.nSpawn = true; 
  Ninja Genji = new Ninja (int(NspawnLoc.box.getParam(0)), int(NspawnLoc.box.getParam(1)), unit);
  clan.add(Genji);

  for (gBox i : Grid) {
    i.on = false;
    i.boost = false;
    i.numAssist = 0;

    if (buttonList[1].buttonTrue()) {
      i.ghostBoost = -1;
      i.ghostNum = 0;
    }
  }

  NspawnLoc.ghostBoost = 4;
  popUpMenu = false;
  
  bestScore.saveLastPuzzle(score);
  score = new scoreSaver();
  
}
/////////////////////////////////////////////////////////////////////
//Function for Creating a new puzzle
void newPuzzle() {

  //clearArrays();
  // for ( gBox i : Grid) { //Resets the grid
  //   i.on = false;
  //   i.gSpawn= false;
  //   i.nSpawn = false;
  //   i.boost = false;
  //   i.numAssist = 0;
  //   i.ghostPath = false;
  //   i.ghostBoost = -1;


  //}

  // gSpawn();
  // nSpawn();

  difficultySpawn(difficulty);
  boost = 0;
  popUpMenu = false;
}

////////////////////////////////////////////////////
// Function for restoring the path

void restore() {
  reset();
  for (gBox i : Grid) {
    i.numAssist = i.ghostNum;
    if (i.ghostBoost >= 0) {
      i.on = true;
    }
    if (i.ghostBoost > 0 && i.ghostBoost < 4) {
      i.boost = true;
      boost booster = new boost (i.box.getParam(0), i.box.getParam(1), unit, i.ghostBoost);
      boosters.add(booster);
    }
  }
  
  
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

  if (menuState == 1) {
    for (gBox i : Grid) {
      if (mouseWithinGrid(i.box, unit)) { //Check Which box the mouse is inside

        println("The X Co-ordinate is " + i.box.getParam(0));
        println("The Y Co-ordinate is " + i.box.getParam(1));
        println("On is " + i.on);
        println("Boost is " + i.boost);
        println("nSpawn is " + i.nSpawn);
        println("gSpawn is " + i.gSpawn);
        println("numAssist is " + i.numAssist);
        println("ghostNum is " + i.ghostNum);
        println("isPermissable value: " + isPermissable(i));
        println("ghostBoost is " + i.ghostBoost);
        println("*****************************************");
      }
    }
  }
}