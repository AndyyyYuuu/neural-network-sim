
public class Button{
  public Module parent;
  private PVector pos, size, relPos;
  private int status = 0;
  public Button(PVector pos, PVector size, Module parent){
    this.parent = parent;
    this.pos = pos;
    this.size = size;
    
    buttons.add(this);
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
    stroke(c);
    if (mouseIn()){
      fill(c);
    }else{
      fill(0);
    }
    rect(parent.pos.x+pos.x, parent.pos.y+pos.y, size.x, size.y);
  }
}
