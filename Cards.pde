class Card
{   
  private char suit;
  private int rank;
  private int cardImageStatus;
  private String frontSide;
  private String backSide;
  //private String currentCardImage;
  private float xPos;
  private float yPos;
  //private float cardX = width;
  //private float cardY = height; //<>// //<>// //<>// //<>// //<>//
  
  public Card(char s, int r, String cI)
  {
    suit = s;
    rank = r;
    frontSide = cI;
    backSide = "backSide.png";
    //currentCardImage = cI;
  }
  
  public Card(String cI)
  {
    frontSide = cI;
    backSide = cI;
  }
  
  public int getRank()
  {
    return rank;
  }
  
  public String getBackSide()
  {
    return backSide; 
  }
  
  public String getFrontSide()
  {
    return frontSide; 
  }
  
  //public String getCurrentCardImage()
  //{
  //  return currentCardImage;
  //}
  
  //public void setCurrentCardFace(int i)
  //{
  //  currentCardImage = i == 0 ? backSide : frontSide;
  //  cardImageStatus = i;
  //}
  
  public int getCardImageStatus()
  {
    return cardImageStatus;
  }
  
  public float getXpos()
  {
    return xPos;
  }
  
  public float getYpos()
  {
    return yPos;
  }
  
  public void setXpos(int x)
  {
    xPos = x;
  }
  
  public void getYpos(int y)
  {
    yPos = y;
  }
  
  public void displayCard(int xPos, int yPos, String cardImage)
  {
    image(loadImage(cardImage), xPos, yPos, 100, 150);
  }
    
}
