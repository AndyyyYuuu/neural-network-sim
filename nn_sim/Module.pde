
public abstract class Module{
  public abstract Num forward();
  public PVector pos, mousePos;
  public abstract void draw();
  public abstract boolean mouseIsIn();
  public abstract Module createNew();
  
  public Module(){
  }
  
  public Module(PVector pos){
    this.pos = pos;
    
  }
  
  public void show(){
    this.draw();
  }
  
  
  public Module grab(){
    this.mousePos = new PVector(mouseX-pos.x, mouseY-pos.y);
    return this;
  }
  public void followMouse(){
    this.pos = new PVector(mouseX, mouseY).sub(this.mousePos);
  }
}
