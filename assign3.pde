/* please implement your assign1 code in this file. */
  final int GAME_START = 0;
  final int GAME_RUN = 1;
  final int GAME_LOSE = 2;
  final int PART1 = 0;
  final int PART2 = 1;
  final int PART3 = 2;

  float x=0, y=0, x1=width-250, x2=width-250, x3=width-250;
  float treasureX, treasureY;
  float percentage, hpWeightX, hpWeightY; 
  float enemyX, enemyY, enemyY2, enemyY3;
  float spacingX = 60, spacingY = 50;
  float indexOne, indexTwo;
  float enemyDist, treasureDist;
  int gameState;
  int enemyPart;
  
  // key press moving for jet flying
  float speed = 5;
  float jetX = 580; 
  float jetY = 240;
  float jetH = 51;
  float jetW = 51;
  boolean upPressed = false;
  boolean downPressed = false;
  boolean leftPressed = false;
  boolean rightPressed = false;

  PImage jet, hpBar, treasure, bgOne, bgTwo, enemy, end, endHover, start, startHover; 
  
  
void setup () {
  size(640,480) ;  
  background(255);
  
  //loading images
  bgOne = loadImage("img/bg1.png");
  bgTwo = loadImage("img/bg2.png");
  jet = loadImage("img/fighter.png");
  hpBar = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  enemy = loadImage("img/enemy.png");
  end = loadImage("img/end2.png");
  endHover = loadImage("img/end1.png");
  start = loadImage("img/start2.png");
  startHover = loadImage("img/start1.png");
  
  //X, Y setting for background
  indexOne = width;
  indexTwo = 0;
  
  //give enemy a random y position from 40 to 450 pixel;
  enemyX = 0;
  enemyY = floor(random(40, 219));
  enemyY2 = floor(random(40, 219));
  enemyY3 = floor(random(40, 219));
  
  //set HP Bar percentage
  percentage = 200/100;
  hpWeightX = percentage * 20;
  hpWeightY = 30;
  
  //set initial gameState in start;
  gameState = GAME_START;
  enemyPart = PART1;
}


void draw() {
  background(255);
  
  switch (gameState){
    
    case GAME_START:
      //reset HP bar
      hpWeightX = percentage * 20;
      image(start, x, y);
      
      //reset jet x y position
      jetX = 580; 
      jetY = 240;
      
      //reset treasure position in random X asix and Y asix
      treasureX = floor(random(200,550));
      treasureY = floor(random(40,430));
      //mouse action and hover on start background
      
      if (mouseY > 370 && mouseY < 420){
        if(mouseX > 200 && mouseX < 470)
        //start button hovered
          image(startHover, x, y);
            if (mousePressed){
            //click to start
            gameState = GAME_RUN;        
            }
        }
       
      
      
      break;
      
    case GAME_RUN:
     
      
      
      //infinite looping background
      image(bgOne, indexOne - width, 0);
      image(bgTwo, indexTwo - width, 0);
      indexOne++;
      indexTwo++;
      indexOne %= width*2;
      indexTwo %= width*2;

      //jet moving
       if (upPressed) {
         jetY -= speed;
       }
       if (downPressed) {
         jetY += speed;
       }
       if (leftPressed) {
         jetX -= speed;
       }
       if (rightPressed) {
         jetX += speed;
       }
       
      //boundary detection
      if( jetX > width - jetW){
       jetX  = width - jetW;
      }
  
      if( jetX < 0 ){
       jetX = 0 ;
      }

      if( jetY > height - jetH){
       jetY = height - jetH;
      }
 
      if( jetY < 0){
       jetY = 0;
      }
      
      //enemy

      switch(enemyPart){
      
      case PART1:
      
      //part 1: a line of 5 enemys 
      for(int i=0; i<5; i++){
        float part1_x = x1+spacingX*i;
        image(enemy, part1_x, enemyY);
        //println("X position = "+x);
      } 
      
      if(x1 >= width){
        enemyPart = PART2;
        x2=-250;
        enemyY2 = random(40, 219);
      }
      
       x1+=speed;
       break;
      
      //part 2: lineslash enemys
    
      case PART2:
      for(int j=0; j<5; j++){
        
        int lineCount = 4-j;
        float part2_x = x2+spacingX*j;
        float part2_y = enemyY2+spacingY*lineCount;
        image(enemy, part2_x, part2_y);
      }
      
      if(x2 >= width){
        enemyPart = PART3;
        x3=-250;
        enemyY3 = random(40, 219);
      }
      
      x2+=speed;
      
      break;
      
      //part 3: a square enemys
      case PART3:
      for(int g=0; g<5; g++){
        
        int Count = abs(2-g);
        
        //upperEnemys
        float part3_x = x3+spacingX*g;
        float part3_y = enemyY3+spacingY*Count;
        image(enemy, part3_x, part3_y);
        
        //downEnemeys
        float enemyY4 = enemyY3+spacingY*4;
        float part3_x2 = x3+spacingX*g;
        float part3_y2 = enemyY4-spacingY*Count; 
        image(enemy, part3_x2, part3_y2);
      }
      
      if(x3 >= width){
        enemyPart = PART1;
        x1=-250;
        enemyY = random(40, 219);
      }
      
      x3+=speed;
      break;
      }
      

      //treasure
      //when jet attach treasure
      treasureDist = dist(jetX, jetY, treasureX, treasureY);
      if (treasureDist <= 41){
        
      //hp bar up 10 point
      hpWeightX += (percentage*10); 
        
      //set HP bar maximus 
      if(hpWeightX >= 200){
      hpWeightX = 200;
      }
        
      //reset treasure random X, Y-axis
      treasureX = floor(random(200,550));
      treasureY = floor(random(40,430));
      }
      
      //show treasure
      image(treasure, treasureX, treasureY);
      
      //show jet
      image(jet, jetX, jetY);
      
      //show HP bar
      scale(1,1);
      fill(#FF0000);
      noStroke();
      rect(x+5, y, hpWeightX, hpWeightY);
      image(hpBar, x, y);
     
      
      break;
      

  }//switch()
}//draw()

//setting keypress boolean action

void keyPressed(){
  if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
    if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
