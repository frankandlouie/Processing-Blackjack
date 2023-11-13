class BlackJack
{
  private Deck sixDecks = new Deck();
  private int cardCount = 0;
  private int deckCount = 0;
  private int playerCardCount = 0;
  private int dealerCardCount = 0;

  private int buttonSize = 100;
  private float menuButtonWidth = 250;
  private float menuButtonHeight = 100;
  
  private color hitButtonColor = color (255, 0, 0);
  private color standButtonColor = color(255, 0, 0);
  private color nextHandButtonColor = color (255, 0, 0);
  private color endGameButtonColor = color(255, 0, 0);

  // Parallel Arrays: [0]=Stand, [1]=Hit, [2]=NextHand, [3]=EndGame, [4]=PLAY, [5]=QUIT
  private float [] buttonXCoords     = {640 - 110, 640 + 10, 1000, 1150, width/2 - menuButtonWidth/4 - menuButtonWidth, width/2 + menuButtonWidth/4};
  private float [] buttonYCoords     = {600, 600, 600, 600};
  private float [] buttonTextXCoords = {buttonXCoords[0] + 10, buttonXCoords[1] + 10, buttonXCoords[2] + 10, buttonXCoords[3] + 10};
  private float [] buttonTextYCoords = {buttonYCoords[0] + 40, buttonYCoords[1] + 40, buttonYCoords[2] + 30, buttonYCoords[3] + 30};
  
  private int dealerCardIndex;

  private int playerStartingCardsXpos = 535;
  private int playerStartingCardsYpos = 400;
  private int dealerStartingCardsXpos = 535;
  private int dealerStartingCardsYpos = 100;

  private int playerCardsXpos = playerStartingCardsXpos;
  private int playerCardsYpos = playerStartingCardsYpos;
  private int dealerCardsXpos = dealerStartingCardsXpos;
  private int dealerCardsYpos = dealerStartingCardsYpos;
  


  Player p1 = new Player();
  Dealer dealer = new Dealer();


  public BlackJack()
  {
    sixDecks.shuffleDeck();
  }

  public void burnFirstCard()
  {
    int burnCardXpos = (width/10);
    int burnCardYpos = ((height/2) - (150/2));
    image(loadImage(sixDecks.decks[0].getFrontSide()), burnCardXpos, burnCardYpos, 100, 150);
    textSize(25);
    text("Burn Card", burnCardXpos, burnCardYpos - 10);
    cardCount++;
  }

  public void dealCard(char upOrDown, char playerOrDealer) // 'u' or 'd' and 'P' or 'D'
  {
    if (playerOrDealer == 'D')
    {
      if (upOrDown == 'u')
      {
        sixDecks.decks[cardCount].displayCard(dealerCardsXpos, dealerCardsYpos, sixDecks.decks[cardCount].getFrontSide());
        storeCard(playerOrDealer);
        //dealer.setCardValue(sixDecks.decks[cardCount].getRank(), dealerCardCount);
      } else
      {
        sixDecks.decks[cardCount].displayCard(dealerCardsXpos, dealerCardsYpos, sixDecks.decks[cardCount].getBackSide());
        dealer.setHiddenCard(sixDecks.decks[cardCount].getFrontSide());
        storeCard(playerOrDealer);
        //dealer.setCardValue(sixDecks.decks[cardCount].getRank(), playerCardCount);
      }
      updateCardPosition(playerOrDealer);
      //cardXpos += 110;
      dealerCardCount++;
      cardCount++;
    } else
    {
      sixDecks.decks[cardCount].displayCard(playerCardsXpos, playerCardsYpos, sixDecks.decks[cardCount].getFrontSide());
      storeCard(playerOrDealer);
      //p1.setCardValue(sixDecks.decks[cardCount].getRank(), playerCardCount);
      //cardXpos += 110;
      updateCardPosition(playerOrDealer);
      playerCardCount++;
      cardCount++;
    }
  }

  public void storeCard(char playerOrDealer)
  {
    if (playerOrDealer == 'D')
    {
      dealer.setCardValue(sixDecks.decks[cardCount].getRank(), dealerCardCount);
    } else
    {
      p1.setCardValue(sixDecks.decks[cardCount].getRank(), playerCardCount);
    }
  }

  public void updateCardPosition(char playerOrDealer)
  {
    if (playerOrDealer == 'D')
    {
      dealerCardsXpos += 110;
    } else
    {
      playerCardsXpos += 110;
    }
  }

  public void insurance()
  {
    int rectX = width/16;
    int rectY = height/10;
    int rectWidth = width/5;
    int rectHeight = height/8;
    textSize(50);
    text("Insurance?", rectX, rectY - 10);
  }

  public void revealDealerCard()
  {
    image(loadImage(dealer.getHiddenCard()), 530, 100, 100, 150);
  }

  public void dealersTurn()
  {
    while (dealer.getTotal() < 17)
    {
      dealCard('u', 'D');
      dealer.aceValueSetter();
    }
  }

  public void displayHitButton()
  {
    fill(hitButtonColor);
    square(buttonXCoords[1], buttonYCoords[1], buttonSize);
    fill(0, 0, 0);
    textSize(30);
    text("Hit", buttonTextXCoords[1], buttonTextYCoords[1]);
    text("[H]", buttonTextXCoords[1], buttonTextYCoords[1] + 30);
  }

  public void displayStandButton()
  {
    fill(standButtonColor);
    square(buttonXCoords[0], buttonYCoords[0], buttonSize);
    fill(0, 0, 0);
    textSize(30);
    text("Stand", buttonTextXCoords[0], buttonTextYCoords[0]);
    text("[S]", buttonTextXCoords[0], buttonTextYCoords[0] + 30);
  }

  public void displayNextHandButton()
  {
    fill(nextHandButtonColor);
    square(buttonXCoords[2], buttonYCoords[2], buttonSize);
    fill(0, 0, 0);
    textSize(30);
    text("Next", buttonTextXCoords[2], buttonTextYCoords[2]);
    text("Hand", buttonTextXCoords[2], buttonTextYCoords[2] + 30);
    text("[N]", buttonTextXCoords[2], buttonTextYCoords[2] + 60);
  }

  public void displayEndGameButton()
  {
    fill(endGameButtonColor);
    square(buttonXCoords[3], buttonYCoords[3], buttonSize);
    fill(0, 0, 0);
    textSize(30);
    text("End", buttonTextXCoords[3], buttonTextYCoords[3]);
    text("Game", buttonTextXCoords[3], buttonTextYCoords[3] + 30);
    text("[Q]", buttonTextXCoords[3], buttonTextYCoords[3] + 60);
  }

  public boolean detectNextHandButtonClicked()
  {
    boolean clicked = false;
    if ((mouseX >= buttonXCoords[2] && mouseX <= buttonXCoords[2] + buttonSize && mouseY >= buttonYCoords[2] && mouseY <= buttonYCoords[2] + buttonSize && mousePressed) || (keyPressed && key == 'n'))
    {
      clicked = true;
    }

    return clicked;
  }

  public boolean detectEndGameButtonClicked()
  {
    boolean clicked = false;
    if ((mouseX >= buttonXCoords[3] && mouseX <= buttonXCoords[3] + buttonSize && mouseY >= buttonYCoords[3] && mouseY <= buttonYCoords[3] + buttonSize && mousePressed) || (keyPressed && key == 'q'))
    {
      clicked = true;
    }
    return clicked;
  }

  public void resetCardCoords()
  {
    playerCardsXpos = playerStartingCardsXpos;
    playerCardsYpos = playerStartingCardsYpos;
    dealerCardsXpos = dealerStartingCardsXpos;
    dealerCardsYpos = dealerStartingCardsYpos;
  }

  public void startMenu()
  {
    float imageWidth = 120;
    float imageHeight = 180;

    float buttonWidth = 250;
    float buttonHeight = 100;
    float buttonX1 = width/2 - buttonWidth/4 - buttonWidth;
    float buttonX2 = width/2 + buttonWidth/4;
    float buttonY = 7 * height/9;

    background(78, 106, 84);
    line(0, height/2, width, height/2);
    line(width/2, 0, width/2, height);
    textSize(100);
    textAlign(CENTER, BOTTOM);
    fill(255);
    text("BLACKJACK", width/2, height/4);
    image(loadImage("h14.png"), width/2 - imageWidth/4 - imageWidth, height/2 - imageHeight/2, imageWidth, imageHeight);
    image(loadImage("c13.png"), width/2 + imageWidth/4, height/2 - imageHeight/2, imageWidth, imageHeight);

    fill(255, 64, 32);
    rect(buttonXCoords[4], buttonY, buttonWidth, buttonHeight);
    rect(buttonXCoords[5], buttonY, buttonWidth, buttonHeight);
    
    fill(255);
    textSize(75);
    textAlign(BASELINE);
    text("PLAY", buttonX1, buttonY);
  }
  
  //runGame variables
  private boolean resumeGame = true;

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
  boolean playGame = false;

  Button hit = new Button(100, 100, 640 + 10, 600, "Hit\n[H]", 255, 0, 0);
  Button stand = new Button(100, 100, 640 - 110, 600, "Stand\n[S]", 255, 0, 0);

  public void runGame()
  {
    if (resumeGame)
    {
      if (!firstCardBurned)
      {
        burnFirstCard();
        //text("First Card Burned", 10, 60);
        firstCardBurned = true;
        resumeGame = true;
      }

      if (!initialCardsDealt)
      {
        dealCard('u', 'p');
        dealCard('d', 'D');
        dealCard('u', 'p');
        dealCard('u', 'D');
        initialCardsDealt = true;
        playersTurn = true;
      }

      if (game.p1.blackjack())
      {
        playersTurn = false;
        calculateStandings = true;
      }

      if (playersTurn)
      {
        hit.drawButton();
        stand.drawButton();
        //if (detectHitButtonClicked())
        if(hit.detectClicked())
        {
          dealCard('u', 'p');
          p1.aceValueSetter();
          if (game.p1.busted())
          {
            //greyOutHitAndStandButtons();
            stand.grayOutButton();
            hit.grayOutButton();
            stand.drawButton();
            hit.drawButton();
            playerBusts = true;
            playersTurn = false;
            dealersTurn = true;
          }
        }
        //if (detectStandButtonClicked())
        if(stand.detectClicked())
        {
          playersTurn = false;
          dealersTurn = true;
        }
      }

      if (dealersTurn)
      {
        revealDealerCard();
        dealersTurn();
        if (dealer.busted())
        {
          dealerBusts = true;
        }
        dealersTurn = false;
        calculateStandings = true;
        text("Dealer Total: "+game.dealer.getTotal(), 300, 175);
        text("Plater Total: "+game.p1.getTotal(), 300, 475);
      }

      if (calculateStandings)
      {
        /*
        Scenario 1: Dealer busts and player has not: Player wins
         Scenario 2: Nobody busts, player has greater sum than dealer: Player wins
         Scenario 3: Nodody busts, dealer has greater sum than player: Player loses
         Scenario 4: Nobody busts, dealer and player have equal sum: Push
         Scenario 5: Both dealer and player busts: Both lose
         */

        //Scenario 1
        if (dealerBusts && !playerBusts)
        {
          playerWins = true;
          pWins++;
        }
        //Scenario 2
        else if ((!dealerBusts && !playerBusts) && p1.getTotal() > dealer.getTotal())
        {
          playerWins = true;
          pWins++;
        }
        //Scenario 3
        else if ((!dealerBusts && !playerBusts) && dealer.getTotal() > p1.getTotal())
        {
          playerWins = false;
          dWins++;
        }
        //Scenario 4
        else if ((!dealerBusts && !playerBusts) && dealer.getTotal() == p1.getTotal())
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

      if (displayStandings)
      {
        if (push)
        {
          text("Push!", 640, height / 2);
        } else if (playerWins)
        {
          text("You win!", 640, height / 2);
        } else if (bothLose)
        {
          text("You both lose!", 640, height / 2);
        } else
        {
          text("You Lost! Dealer Wins!", 640, height / 2);
        }

        displayStandings = false;
        askNextRound = true;
      }

      if (askNextRound)
      {
        displayNextHandButton();
        displayEndGameButton();
        if (detectNextHandButtonClicked())
        {
          //Reset player and dealer card positions
          resetCardCoords();

          //Reset player and dealer hand total
          p1.resetHandTotal();
          dealer.resetHandTotal();

          //Set all initialCardsDealt phase to false
          initialCardsDealt = false;

          //Reset variables for who wins
          playerBusts = false;
          dealerBusts = false;
          playerWins = false;
          bothLose = false;
          push = false;

          //fill Hit and Stand buttons
          //fillOutHitAndStandButtons();
          stand.fillOutButton();
          hit.fillOutButton();
          stand.drawButton();
          hit.drawButton();
          askNextRound = false;

          //Reset background
          background(128, 192, 255);
        }
        if (detectEndGameButtonClicked())
        {
          resumeGame = false;
        }
      }
    }
  }
  
}
