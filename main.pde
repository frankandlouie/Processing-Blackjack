void setup() 
{
  background(128, 192, 255);
  size(1280, 720);

}

BlackJack game = new BlackJack();

private boolean resumeGame = false;

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
  textSize(25);
  
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
    //text("Initial deal phase complete.", 10, 120);
    //text(game.dealer.getTotal(), 400, 200);
    //text(game.p1.getTotal(), 400, 500);
  }
  
  if(game.p1.blackjack())
  {
    playersTurn = false;
    calculateStandings = true;
  }

  if(game.dealer.dealerHasAce())
  {
    game.insurance();
  }
  
  game.displayHitButton();
  game.displayStandButton();
  
  if(playersTurn)
  {
    //text("Now players turn.", 10, 180);
    if(game.detectHitButtonClicked())
    {
      //text("You hit.", 10, 300);
      game.dealCard('u','p');
      game.p1.aceValueSetter();
      if(game.p1.busted())
      {
        game.greyOutButtons();
        playerBusts = true;
        playersTurn = false;
        dealersTurn = true;
      }
    }
    if(game.detectStandButtonClicked())
    {
      //text("You stand.", 10, 360);
      playersTurn = false;
      dealersTurn = true;
    }
  }
  
  if(dealersTurn)
  {
    //text("Dealers Turn.", 10, 480);
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
    }
    //Scenario 2
    else if((!dealerBusts && !playerBusts) && game.p1.getTotal() > game.dealer.getTotal())
    {
      playerWins = true;
    }
    //Scenario 3
    else if((!dealerBusts && !playerBusts) && game.dealer.getTotal() > game.p1.getTotal())
    {
      playerWins = false;
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
    
    askNextRound = true;
  }
  
  if(askNextRound)
  {
    game.displayNextHandButton();
    game.displayEndGameButton();
  }
  
  
  
  
   
}


//  private boolean firstCardBurned = false;
//  private boolean firstWaveOfCardsDealt = false;
//  private boolean playersTurn = false;
//  private boolean dealersTurn = false;
//  private boolean displayFinalStandings = false;
//  private boolean playerBlackJack = false;
//  private boolean playerLoss = false;
//  private boolean dealerLoss = false;
//  private boolean push = false;
  
//void draw()
//{
//  //game.dealPlayerCardsAndSetPlayerRank();
//  //game.dealDealerCardsAndSetDealerRank();
//  //game.dealPlayerCardsAndSetPlayerRank();
    
//  if(!firstCardBurned)
//  {
//    game.burnFirstCard();
//  }
    
//  if (!firstWaveOfCardsDealt) 
//  {
//    game.dealAndSetPlayerCard();
//    game.dealAndSetDealerCard(0);
//    game.dealAndSetPlayerCard();
//    game.dealAndSetDealerCard(1);
//    textSize(100);
//    //text(game.dealer.getTotal(), 900, 200);
//    firstWaveOfCardsDealt = true;
//    playersTurn = true;
//  }
    
//  game.displayHitButton();
//  game.displayStandButton();
    
//  if (game.p1.blackjack())
//  {
//    playerBlackJack = true;
//    if(game.dealer.getTotal() == 21)
//    {
//      playerBlackJack = false;
//      push = true;
//    }
//    playersTurn = false;
//    dealersTurn = true;
//  }
    
//  if (playersTurn)
//  {
//    if (game.detectHitButtonClicked()) 
//    {
//      game.dealAndSetPlayerCard();
//    }
//    game.p1.aceValueSetter();
//    if (game.detectBust('p'))
//    {
//      playersTurn = false;
//      dealersTurn = true;
//      playerLoss = true;
//    }
//    if (game.detectStandButtonClicked())
//    {
//      playersTurn = false;
//      dealersTurn = true;
//    }
//  }
    
//  if (dealersTurn)
//  {
//    game.revealDealerCard();
//    game.dealersTurn();
//    if (game.detectBust('d')) 
//    { 
//      // text("You Lost!", 640, height / 2);
//      dealerLoss = true;
//    }
//      dealersTurn = false;
//      displayFinalStandings = true;
//  }
    
//  if (game.dealer.getTotal() < game.p1.getTotal())
//  {
//    dealerLoss = true;
//  }
    
//  if (displayFinalStandings)
//  {
//    if (playerLoss)
//    {
//      // text(game.dealer.getTotal(), 900, 200);
//      text("You Lost!", 640, height / 2);
//    }
//    if (dealerLoss)
//    {
//      text("You Won!", 640, height / 2);
//    }
//    if (playerBlackJack)
//    {
//      text("Blackjack! You won!", 640, height / 2);
//    }
//    if(push)
//    {
//      text("Push!", 640, height / 2);
//    }

//        // game.dealerLosesToBust();
//        // game.playerWins();
//  }
    
    
    
    
    
    
//    //work on next hand
    
//    //work on game reset(just create autocfg basically)
    
//    //work on playing multiple hands(timer between each hand)
    
//    //work on multiple players. 
//}
