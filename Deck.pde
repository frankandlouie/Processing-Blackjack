import java.util.*;
 
class Deck
{
  final private int deckAmount = 6;
  final private int cardAmount = deckAmount * 52;
  
  final private int minValue = (int)(cardAmount * 0.75);
  final private int maxValue = (int)(cardAmount * 0.80);
  private int plasticCardIndex = 0;
  
  private Card[] decks = new Card[cardAmount + 1]; // The plus one is for the plastic-card cutoff.
  
  public Deck()
  {
    int deckIndex = 0;
    int rank, currentSuit;
    char [] cardSuits = {'h', 's', 'c', 'd'};
    
    for(int i = 0; i < deckAmount; i++)
    {
      for(currentSuit = 0; currentSuit < 4; currentSuit++)
      {
        for(rank = 2; rank <= 14; rank++)
        {
          decks[deckIndex] = new Card(cardSuits[currentSuit], rank, ""+cardSuits[currentSuit]+rank+".png");
          deckIndex++;
        }
      }
    }
  }
  
  public void shuffleDeck()
  {
    Random r = new Random();
    
    for(int i = cardAmount - 1; i > 0; i--)
    {
      int j = r.nextInt(i+1);
      
      Card tempCard = decks[i];
      decks[i] = decks[j];
      decks[j] = tempCard;
    }
  }
  
  public void insertPlasticCard()
  {
    //Random r = new Random();
    plasticCardIndex = (int) (Math.random() * (maxValue - minValue + 1)) + minValue;
    
    for(int i = cardAmount; i > plasticCardIndex; i--)
    {
      decks[i] = decks[i - 1];
    }
    
    decks[plasticCardIndex] = new Card("bc.png");
  }
  
  public void displayDeck()
  {
    float cardX = width/32;
    float cardY = height/12;
    float xPos = 0;
    float yPos = 0;
  
    for(int i = 0; i <= cardAmount; i++)
    {
      System.out.println(decks[i].getFrontSide());
      image(loadImage(decks[i].getFrontSide()), xPos, yPos, cardX, cardY);
      xPos += cardX;
    
      if(xPos % width == 0)
      {
        xPos = 0;
        yPos += cardY;
      }
    }
  }
}
