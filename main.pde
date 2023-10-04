void setup() 
{
  background(128, 192, 255);
  size(1280, 720);
  //surface.setResizable(true);
  frameRate(30);
}

BlackJack game = new BlackJack();

private boolean resumeGame = false;

//Temp variables
private int pWins = 0;
private int dWins = 0;

//Game phases
private boolean firstCardBurned = false;
private boolean initialCardsDealt = false;
private boolean playersTurn = false;
private boolean dealersTurn = false;
private boolean calculateStandings = false;
private boolean displayStandings = false;
private boolean askNextRound = false;

//Player variables
private boolean playerBusts = false;
private boolean dealerBusts = false;
private boolean playerWins = false;
private boolean bothLose = false;
private boolean push = false;

void draw()
{
  //line(0, height/2, width, height/2);
  //line(width/2, 0, width/2, height);
  
  //Displays Player v. Dealer wins, just to show how BS this game is
  textSize(25);
  text("Player Wins: "+pWins, 300, 600);
  text("Dealer Wins: "+dWins, 300, 625);
  
  if(!firstCardBurned)
  {
    game.burnFirstCard();
    //text("First Card Burned", 10, 60);
    firstCardBurned = true;
    resumeGame = true;
  }
  
  if(!initialCardsDealt)
  {
    game.dealCard('u', 'p');
    game.dealCard('d', 'D');
    game.dealCard('u', 'p');
    game.dealCard('u', 'D');
    initialCardsDealt = true;
    playersTurn = true;
  }
  
  if(game.p1.blackjack())
  {
    playersTurn = false;
    calculateStandings = true;
  }

  //if(game.dealer.dealerHasAce())
  //{
  //  game.insurance();
  //}
  
  game.displayHitButton();
  game.displayStandButton();
  
  if(playersTurn)
  {
    if(game.detectHitButtonClicked())
    {
      game.dealCard('u','p');
      game.p1.aceValueSetter();
      if(game.p1.busted())
      {
        game.greyOutHitAndStandButtons();
        playerBusts = true;
        playersTurn = false;
        dealersTurn = true;
      }
    }
    if(game.detectStandButtonClicked())
    {
      playersTurn = false;
      dealersTurn = true;
    }
  }
  
  if(dealersTurn)
  {
    game.revealDealerCard();
    game.dealersTurn();
    if(game.dealer.busted())
    {
      dealerBusts = true;
    }
    dealersTurn = false;
    calculateStandings = true;
    text("Dealer Total: "+game.dealer.getTotal(), 300, 175);
    text("Plater Total: "+game.p1.getTotal(), 300, 475);
  }
  
  if(calculateStandings)
  {
    /*
    Scenario 1: Dealer busts and player has not: Player wins
    Scenario 2: Nobody busts, player has greater sum than dealer: Player wins
    Scenario 3: Nodody busts, dealer has greater sum than player: Player loses
    Scenario 4: Nobody busts, dealer and player have equal sum: Push
    Scenario 5: Both dealer and player busts: Both lose
    */
    
    //Scenario 1
    if(dealerBusts && !playerBusts)
    {
      playerWins = true;
      pWins++;
    }
    //Scenario 2
    else if((!dealerBusts && !playerBusts) && game.p1.getTotal() > game.dealer.getTotal())
    {
      playerWins = true;
      pWins++;
    }
    //Scenario 3
    else if((!dealerBusts && !playerBusts) && game.dealer.getTotal() > game.p1.getTotal())
    {
      playerWins = false;
      dWins++;
    }
    //Scenario 4
    else if((!dealerBusts && !playerBusts) && game.dealer.getTotal() == game.p1.getTotal())
    {
      push = true;
    }
    //Scenario 5
    else if (dealerBusts && playerBusts)
    {
      bothLose = true;
    }
    
    calculateStandings = false;
    displayStandings = true;
  }
  
  if(displayStandings)
  {
    if(push)
    {
      text("Push!", 640, height / 2);
    }
    else if(playerWins)
    {
      text("You win!", 640, height / 2);
    }
    else if(bothLose)
    {
      text("You both lose!", 640, height / 2);
    }
    else
    {
      text("You Lost! Dealer Wins!", 640, height / 2);
    }
    
    displayStandings = false;
    askNextRound = true;
  }
  
  if(askNextRound)
  {
    game.displayNextHandButton();
    game.displayEndGameButton();
    if(game.detectNextHandButtonClicked())
    {
      //Reset player and dealer card positions
      game.resetCardCoords();
      
      //Reset player and dealer hand total 
      game.p1.resetHandTotal();
      game.dealer.resetHandTotal();
      
      //Set all initialCardsDealt phase to false
      initialCardsDealt = false;
      
      //Reset variables for who wins
      playerBusts = false;
      dealerBusts = false;
      playerWins = false;
      bothLose = false;
      push = false;
      
      //fill Hit and Stand buttons
      game.fillOutHitAndStandButtons();
      
      askNextRound = false;
      
      //Reset background
      background(128, 192, 255);
    }
    if(game.detectEndGameButtonClicked())
    {
      
    }
  }
}
