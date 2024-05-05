
public class OptimModule extends Module{
  public OptimModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-50, 0)));
  }
  
  public void setNum(double num){
    this.outputNum = new Num(num);
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_OPTIM);
    strokeWeight(2);
    rect(this.pos.x-50, this.pos.y-60, 100, 120);
    drawPorts();
    fill(COLOR_OPTIM);
    textAlign(LEFT);
    textSize(12);
    text("ℓ", this.pos.x-40, this.pos.y+4);
    
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-50, this.pos.y-60, 100, 120);
  }
  
  public Num forward(){
    return this.outputNum;
  }
  
  public Module createNew(){
    return new OptimModule(this.pos);
  }
}
