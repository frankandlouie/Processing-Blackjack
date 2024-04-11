void setup() 
{
  background(128, 192, 255);
  size(1280, 720);
  //fullScreen();
  //surface.setResizable(true);
  frameRate(30);
}

BlackJack game = new BlackJack();


void draw()
{
  //game.startMenu();
  game.runGame();
  //game.displayAllCards();
}
