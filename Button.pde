import java.util.*;

class Button
{
  private float longSide = 0;
  private float shortSide = 0;
  private float xPos = 0;
  private float yPos = 0;
  private String text = " ";
  private int textSize = 30;
  private int colorR = 0;
  private int colorG = 0;
  private int colorB = 0;
  private color butColor;
  private color gray = color(128);
  private color currentColor; 
  
  public Button(float length, float width, float xPos, float yPos, String text, int R, int G, int B)
  {
    longSide = length;
    shortSide = width;
    this.xPos = xPos;
    this.yPos = yPos;
    this.text = text;
    colorR = R;
    colorG = G;
    colorB = B;
    butColor = color(R, G, B);
    currentColor = butColor;
  }
  
  public void drawButton()
  {
    fill(currentColor);
    rect(xPos, yPos, longSide, shortSide);
    fill(0);
    textSize(textSize);
    text(text, xPos + longSide/6, yPos + shortSide / 3);
  }
  
  public void grayOutButton()
  {
    currentColor = color(96);
  }
  
  public void fillOutButton()
  {
    currentColor = butColor;
  }
  
  public boolean detectClicked()
  {
    return ((mouseX >= xPos && mouseX <= xPos + longSide && mouseY >= yPos && mouseY <= yPos + shortSide) && mousePressed) ? true : false;
  }
}
