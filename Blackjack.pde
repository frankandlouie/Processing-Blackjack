class BlackJack
{
  private Deck sixDecks = new Deck();
  private int cardCount = 0;
  private int deckCount = 0;
  private int playerCardCount = 0;
  private int dealerCardCount = 0;
  
  private int buttonSize = 100;
  private color hitButtonCol = color (255, 0, 0);
  private color standButtonCol = color(255, 0 ,0);
  private color nextHandButtonCol = color (255, 0, 0);
  private color endGameButtonCol = color(255, 0 ,0);
 
  // Parallel Arrays: [0]=Stand, [1]=Hit, [2]=NextHand, [3]=EndGame
  private int [] buttonXCoords     = {850, 1000, 1000, 1150};
  private int [] buttonYCoords     = {600, 600,  100,  100 };
  private int [] buttonTextXCoords = {860, 1025, 1015, 1165};
  private int [] buttonTextYCoords = {660, 660,  140,   140};
  
  private int dealerCardIndex;
  
  private int playerStartingCardsXpos = 530;
  private int playerStartingCardsYpos = 400;
  private int dealerStartingCardsXpos = 530;
  private int dealerStartingCardsYpos = 100;
  
  private int playerCardsXpos = 530;
  private int playerCardsYpos = 400;
  private int dealerCardsXpos = 530;
  private int dealerCardsYpos = 100;
  
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
    text("Burn Card", burnCardXpos, burnCardYpos - 10);    
    cardCount++;
  }

  public void dealCard(char upOrDown, char playerOrDealer) // 'u' or 'd' and 'P' or 'D'
  {
    if(playerOrDealer == 'D')
    {
      if(upOrDown == 'u')
      {
        sixDecks.decks[cardCount].displayCard(dealerCardsXpos, dealerCardsYpos, sixDecks.decks[cardCount].getFrontSide());
        storeCard(playerOrDealer);
        //dealer.setCardValue(sixDecks.decks[cardCount].getRank(), dealerCardCount);
      }
      else
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
    }
    else
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
    if(playerOrDealer == 'D')
    {
      dealer.setCardValue(sixDecks.decks[cardCount].getRank(), dealerCardCount);
    }
    else
    {
      p1.setCardValue(sixDecks.decks[cardCount].getRank(), playerCardCount);
    }
  }
  
  public void updateCardPosition(char playerOrDealer)
  {
    if(playerOrDealer == 'D')
    {
      dealerCardsXpos += 110;
    }
    else
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
  
  public void resumeGame()
  {
    int rectX = width - (width/4);
    int rectY = height/10;
    int rectWidth = width/5;
    int rectHeight = height/8;
    textSize(50);
    text("Next Hand?", rectX, rectY - 10);
  }
  
  public void revealDealerCard()
  {
    image(loadImage(dealer.getHiddenCard()), 530, 100, 100, 150);
  }
  
  public void dealersTurn()
  {
    while(dealer.getTotal() < 17)
    {
      dealCard('u', 'D');
      dealer.aceValueSetter();
    }
  }
  
  public void displayHitButton()
  {
    fill(hitButtonCol);
    square(buttonXCoords[1], buttonYCoords[1], buttonSize);
    fill(0, 0, 0);
    textSize(30);
    text("Hit", buttonTextXCoords[1], buttonTextYCoords[1]);
  }
  
  public void displayStandButton()
  {
    fill(standButtonCol);
    square(buttonXCoords[0], buttonYCoords[0], buttonSize);
    fill(0, 0, 0);
    textSize(30);
    text("Stand", buttonTextXCoords[0], buttonTextYCoords[0]);
  }
  
  public void displayNextHandButton()
  {
    fill(nextHandButtonCol);
    square(buttonXCoords[2], buttonYCoords[2], buttonSize);
    fill(0, 0, 0);
    textSize(30);
    text("Next\nHand", buttonTextXCoords[2], buttonTextYCoords[2]);
  }
  
  public void displayEndGameButton()
  {
    fill(endGameButtonCol);
    square(buttonXCoords[3], buttonYCoords[3], buttonSize);
    fill(0, 0, 0);
    textSize(30);
    text("End\nGame", buttonTextXCoords[3], buttonTextYCoords[3]);
  }
  
  public void setHitButCol(int r, int g, int b)
  {
    hitButtonCol = color(r, g, b);
  }
  
  public void setStandButCol(int r, int g, int b)
  {
    standButtonCol = color(r, g, b);
  }
  
  public boolean detectHitButtonClicked()
  {
    boolean clicked = false;
    if((mouseX >= buttonXCoords[1] && mouseX <= buttonXCoords[1] + buttonSize && mouseY >= buttonYCoords[1] && mouseY <= buttonYCoords[1] + buttonSize && mousePressed) || (keyPressed && key == 'h'))
    {
      clicked = true;
    }    
    return clicked;
  }
  
  public boolean detectStandButtonClicked()
  {
    boolean clicked = false; 
    if((mouseX >= buttonXCoords[0] && mouseX <= buttonXCoords[0] + buttonSize && mouseY >= buttonYCoords[0] && mouseY <= buttonYCoords[0] + buttonSize && mousePressed) || (keyPressed && key == 's'))
    {
      greyOutButtons();
      clicked = true;
    }
    
    return clicked;
  }
  
  public boolean detectNextHandButtonClicked()
  {
    boolean clicked = false; 
    if((mouseX >= buttonXCoords[2] && mouseX <= buttonXCoords[2] + buttonSize && mouseY >= buttonYCoords[2] && mouseY <= buttonYCoords[2] + buttonSize && mousePressed) || (keyPressed && key == 'n'))
    {
      clicked = true;
    }
    
    return clicked;
  }
  
  public boolean detectEndGameButtonClicked()
  {
    boolean clicked = false; 
    if((mouseX >= buttonXCoords[3] && mouseX <= buttonXCoords[3] + buttonSize && mouseY >= buttonYCoords[3] && mouseY <= buttonYCoords[3] + buttonSize && mousePressed) || (keyPressed && key == 'q'))
    {
      clicked = true;
    }
    return clicked;
  }
  
  public void greyOutButtons()
  {
    setHitButCol(128, 128, 128);
    setStandButCol(128, 128, 128);
  }
}
