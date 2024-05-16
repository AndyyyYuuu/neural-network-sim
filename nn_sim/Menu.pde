float MENU_X = 50;
float MENU_ITEM_H = 40;
float MENU_FOLDER_H = 30;
public class MenuFolder{
  private Module[] contents;
  private color c;
  private String name;
  private boolean isOpen = false;
  private float startY;
  public MenuFolder(String name, Module[] contents, color c){
    this.contents = contents;
    this.c = c;
    this.name = name;
  }
  
  public float draw(float startY){
    this.startY = startY;
    
    textAlign(LEFT);
    strokeWeight(2);
    
    stroke(c);
    fill(0);
    rect(MENU_X, startY, 200, MENU_FOLDER_H - 5);
    fill(c);
    textSize(14);
    text(name, MENU_X+5, startY+18);
    if (isOpen){
      ICON_OPEN.draw(MENU_X+184, startY+12.5, c, 20);
      float x = MENU_X + 20;
      for (int i=0; i<contents.length; i++){
        
        float y = MENU_FOLDER_H + startY + i*MENU_ITEM_H;
        stroke(c);
        fill(0);
        rect(x, y, 200, MENU_ITEM_H - 5);
        fill(c);
        textSize(12);
        text(contents[i].name, x + 5, y + 15);
        
        // Fancy folder lines
        if (i == contents.length-1){
          line(MENU_X + 5, y, MENU_X + 5, y+MENU_ITEM_H/2);
        }else{
          line(MENU_X + 5, y, MENU_X + 5, y+MENU_ITEM_H);
        }
        line(MENU_X + 5, y+MENU_ITEM_H/2, x, y+MENU_ITEM_H/2);
        
        
      }
      return 35 + contents.length*MENU_ITEM_H;
    }else{
      ICON_CLOSED.draw(MENU_X+184, startY+12.5, c, 20);
      return 35;
    }
    
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(MENU_X, startY, 200, 25);
  }
  
  public Module click(){
    if (mouseIsIn()){
      isOpen = !isOpen;
      return null;
    }else if (isOpen){
      for (int i=0; i<contents.length; i++){
        float x = MENU_X + 20;
        float y = MENU_FOLDER_H + startY + i*MENU_ITEM_H;
        if (mouseInRect(x, y, 200, MENU_ITEM_H - 5)){
          return contents[i].createNew(new PVector(mouseX, mouseY));
        }
        
      }
    }
    return null;
  }
  
}

public class MenuItem{
  public Module module;
  
}
