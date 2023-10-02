class BlackJack
{
  private Deck sixDecks = new Deck();
  private int cardCount = 0;
  private int deckCount = 0;
  private int playerCardCount = 0;
  private int dealerCardCount = 0;
  
  private color hitButtonCol = color (255, 0, 0);
  private color standButtonCol = color(255, 0 ,0);
  private color nextHandButtonCol = color (255, 0, 0);
  private color endGameButtonCol = color(255, 0 ,0);
  
  private int dealerCardIndex;
  
  //private int cardXpos = 530;
  int playerCardsXpos = 530;
  private int playerCardsYpos = 400;
  int dealerCardsXpos = 530; // width/2 - cardWidth - 10
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


  //public void dealAndSetPlayerCard()
  //{
  //  sixDecks.decks[cardCount].displayCard(playerCardsXpos, 450, sixDecks.decks[cardCount].getFrontSide());
  //  p1.setCardValue(sixDecks.decks[cardCount].getRank(), playerCardCount);
  //  cardCount++;
  //  playerCardCount++;
  //  playerCardsXpos += 110;
  //}
  
  ////public void setPlayerCard()
  ////{
    
  ////}
  
  ////public void updatePlayersCardsPosition()
  ////{
    
  ////}
  
  //public void dealAndSetDealerCard(int i)
  //{
  //  if(i == 0)
  //  {
  //    dealer.setHiddenCard(sixDecks.decks[cardCount].getFrontSide());
  //    sixDecks.decks[cardCount].displayCard(dealerCardsXpos, 100, sixDecks.decks[cardCount].getBackSide());
  //  }
  //  else
  //    sixDecks.decks[cardCount].displayCard(dealerCardsXpos, 100, sixDecks.decks[cardCount].getFrontSide());
  //  dealer.setCardValue(sixDecks.decks[cardCount].getRank(), dealerCardCount);
  //  cardCount++;
  //  dealerCardCount++;
  //  dealerCardsXpos += 110;
  //}
  
  //public void revealDealerCard()
  //{
  //  image(loadImage(dealer.getHiddenCard()), 530, 100, 100, 150);
  //}
  
  //// public boolean dealerLosesToBust()
  //// {
  ////   boolean dealerBusted = false;
  ////   if(dealer.checkDealerBust())
  ////   {
  ////     dealerBusted = true;
  ////     text(game.dealer.getTotal(), 900, 200);
  ////     text("Dealer busted", 640, height/2);
  ////   }
  ////   return dealerBusted;
  //// }
  
  //public void playerWins()
  //{
  //  if(p1.getTotal() > dealer.getTotal())
  //  {
  //    text(game.dealer.getTotal(), 900, 200);
  //    text("You Won!", 640, height/2);
  //  }
  //}
  
  //public void playerLoses()
  //{
  //  if(dealer.getTotal() > p1.getTotal());
  //  {
  //    text(game.dealer.getTotal(), 900, 200);
  //    text("You Lost! Poopoo", 640, height/2);
  //  }
  //}
  
  public void displayHitButton()
  {
    fill(hitButtonCol);
    square(1000.0, 600.0, 100);
    fill(0, 0, 0);
    textSize(30);
    text("Hit", 1025, 660);
  }
  
  public void displayStandButton()
  {
    fill(standButtonCol);
    square(800.0, 600.0, 100);
    fill(0, 0, 0);
    textSize(30);
    text("Stand", 810, 660);
  }
  
  public void displayNextHandButton()
  {
    fill(nextHandButtonCol);
    square(1000.0, 100.0, 100);
    fill(0, 0, 0);
    textSize(30);
    text("Next\nHand", 1015, 150);
  }
  
  public void displayEndGameButton()
  {
    fill(endGameButtonCol);
    square(1130.0, 100.0, 100);
    fill(0, 0, 0);
    textSize(30);
    text("End\nGame", 1145, 150);
  }
  
  public void setHitButCol(int x, int y, int z)
  {
    hitButtonCol = color(x, y, z);
  }
  
  public void setStandButCol(int x, int y, int z)
  {
    standButtonCol = color(x, y, z);
  }
  
  public boolean detectHitButtonClicked()
  {
    boolean clicked = false;
    if((mouseX >= 1000 && mouseX <= 1100 && mouseY >= 600 && mouseY <= 700 && mousePressed) || (keyPressed && key == 'h'))
    {
      clicked = true;
    }    
    return clicked;
  }
  
  public boolean detectStandButtonClicked()
  {
    boolean clicked = false; 
    if((mouseX >= 800 && mouseX <= 900 && mouseY >= 600 && mouseY <= 700 && mousePressed) || (keyPressed && key == 's'))
    {
      greyOutButtons();
      clicked = true;
    }
    
    return clicked;
  }
  
  public void greyOutButtons()
  {
    setHitButCol(128, 128, 128);
    setStandButCol(128, 128, 128);
  }
  
  //public void dealersTurn()
  //{    
  //  while(dealer.getTotal() < 17)
  //  {
  //    dealAndSetDealerCard(1);
  //    dealer.aceValueSetter();
  //  }
  //}
  
  //public boolean detectBust(char t)
  //{
  //  boolean busted = false;
  //  if(t == 'p')
  //  {
  //    if (p1.getTotal() > 21)
  //    {
  //      busted = true;
  //    }
  //    else if(t == 'd')
  //    {
  //      if (dealer.getTotal() > 21)
  //      {
  //        busted = true;
  //      }
  //    }
  //    // fill(255, 255, 255);
  //    // textSize(100);
  //    // text("You lost", width/2, height/2);
  //  }
  //  return busted;
  //}
  
  //public boolean blackjack()
  //{
  //  boolean blackjack = false;
  //  if(p1.getTotal() == 21)// && p1.getCardRanksSize() == 2)
  //  {
  //    blackjack = true;
  //  }
  //  return blackjack;
  //}
  
  
}
