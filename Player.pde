import java.util.ArrayList;

class Player
{
  ArrayList<Integer> playerHand = new ArrayList<Integer>();
  
  public int getCardVal(int i)
  {
    return playerHand.get(i);
  }
  
  public void setCardValue(int cardRank, int i)
  {
    //if(cardRank > 10 && cardRank < 14)
    //{
    //  cardRanks[i] = 10;
    //}
    //else if(cardRank == 14)
    //{
    //  if(getTotal() > 21)
    //  {
    //    cardRanks[i] = 1;
    //  }
    //  else
    //  {
    //    cardRanks[i] = 11;
    //  }
    //}
    //else
    //{
    //  cardRanks[i] = cardRank;
    //}
    
    if(cardRank > 9 && cardRank < 14)
    {
      playerHand.add(10);
    }
    else if(cardRank < 10)
    {
      playerHand.add(cardRank);
    }
    else 
    {
      playerHand.add(11);
    }
    //playerCardAmount++;
  }
  
  public int getTotal()
  {
    int total = 0;

    for(int ranks : playerHand)
    {
      total += ranks;
    }
    
    return total;
  }
  
   public void aceValueSetter()
   {
     for(int i = 0; i < playerHand.size(); i++)
     {
       if(playerHand.get(i).equals(11) && getTotal() > 21)
       {
         playerHand.set(i, 1);
       }
     }
   }
   
   public boolean busted()
   {
     boolean busted = false;
     if(getTotal() > 21)
     {
       busted = true;
     }
     return busted;
   }
   
   public boolean blackjack()
   {
     boolean blackjack = false;
     if(getTotal() == 21 && playerHand.size() == 2)
     {
       blackjack = true;
     }
     return blackjack;
   }
  
   public int getHandSize()
   {
     return playerHand.size();
   }
   
   public void resetHandTotal()
   {
     playerHand.clear();
   }
}

class Dealer extends Player
{
  private String hiddenCardFrontSide;
  
  public void setHiddenCard(String imageName)
  {
    hiddenCardFrontSide = imageName;
  }
  
  public String getHiddenCard()
  {
    return hiddenCardFrontSide;
  }
  
  boolean checkDealerBust()
  {
    return getTotal() > 21 ? true : false;
  }
  
  boolean dealerHasAce()
  {
    boolean dealerHasAce = false;
    if(getHandSize() == 2)
    {
      if(playerHand.get(1) == 11)
        dealerHasAce = true;
    }
    return dealerHasAce;
  }
}
