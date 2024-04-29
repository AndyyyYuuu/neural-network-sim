// InputModule: includes all modules with only outputs
public abstract class InputModule extends Module{
  
  public InputModule(PVector pos){
    
    super(pos);
    
  }
  
  public InputModule(){
  }
}

public class ParamModule extends InputModule{
  public ParamModule(PVector pos){
    super(pos);
    output = new OutputPort(this, vec(30, 0));
  }
  
  public ParamModule(){
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_OPTIM);
    strokeWeight(2);
    rect(this.pos.x-20, this.pos.y-10, 40, 20);
    drawPorts();
    fill(COLOR_OPTIM);
    textAlign(LEFT);
    textSize(16);
    text(Double.toString(this.outputNum.value), this.pos.x-17, this.pos.y+5);
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-20, this.pos.y-10, 40, 20);
  }
  
  public Num forward(){
    return new Num(1);
  }
  
  public Module createNew(){
    return new ParamModule(this.pos);
  }
  
}

