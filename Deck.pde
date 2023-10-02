import java.util.*;
 
class Deck
{
  final private int deckAmount = 6;
  final private int cardAmount = deckAmount * 52;
  private Card[] decks = new Card[cardAmount];
  
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
    
    for(int i = 51 * this.deckAmount; i > 0; i--)
    {
      int j = r.nextInt(i+1);
      
      Card tempCard = decks[i];
      decks[i] = decks[j];
      decks[j] = tempCard;
    }
  }
}
