
public class Button{
  public Module parent;
  private PVector pos, size, relPos;
  private int status = 0;
  public String txt = null;
  private Icon icon = null;
  //
  public Button(PVector pos, PVector size, Module parent){
    this.parent = parent;
    this.pos = pos;
    this.size = size;
    
    buttons.add(this);
  }
  
  public Button(PVector pos, PVector size, Icon icon, Module parent){
    
    this(pos, size, parent);
    this.icon = icon;
    if (!this.icon.isLoaded()){
      this.icon.load();
    }
  }
  public Button(PVector pos, PVector size, String txt, Module parent){
    this(pos, size, parent);
    this.txt = txt;
  }
  
  public boolean mouseDown(){
    if (mouseIn()){
      this.status = 30;
      return true;
    }
    return false;
  }
  public boolean mouseIn(){
    return mouseInRect(parent.pos.x+pos.x, parent.pos.y+pos.y, size.x, size.y);
  }
  
  public boolean isOn(){
    return status > 0;
  }
  
  public void turnOff(){
    status = 0;
  }
  
  public void tick(){
    if (status > 0){
      this.status --;
    }
  }
  
  public void draw(color c){
    pushMatrix();
    translate(parent.pos.x, parent.pos.y);
    stroke(c);
    if (mouseIn()){
      fill(c);
    }else{
      fill(0);
    }
    rect(pos.x, pos.y, size.x, size.y);
    if (icon != null){
      
      if (mouseIn()){
        icon.draw(pos.x+size.x/2, pos.y+size.y/2, color(0));
      }else{
        icon.draw(pos.x+size.x/2, pos.y+size.y/2, c);
      }
    } else if (txt != null){
      if (mouseIn()){
        fill(0);
      }else{
        fill(c);
      }
      text(txt, 0, 0);
    }
    
    
    popMatrix();
  }
}
