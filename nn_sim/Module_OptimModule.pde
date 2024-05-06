
public class OptimModule extends Module{
  public Num inputLoss = null;
  public OptimModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-50, -45)));
  }
  
  public void setNum(double num){
    this.outputNum = new Num(num);
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_OPTIM);
    strokeWeight(2);
    rect(this.pos.x-50, this.pos.y-60, 100, 120);
    drawAttachments();
    fill(COLOR_OPTIM);
    textAlign(LEFT);
    textSize(12);
    String lossText;
    forward();
    if (this.hasAllInputs() && inputLoss != null){
      lossText = "ℓ = "+processDouble(inputLoss.value, 8, false);
    }else{
      lossText = "ℓ = ???";
    }
    text(lossText, this.pos.x-40, this.pos.y-41);
    
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-50, this.pos.y-60, 100, 120);
  }
  
  public Num _forward(){
    inputLoss = this.getInput(0);
    return this.outputNum;
  }
  
  public Module createNew(){
    return new OptimModule(this.pos);
  }
}
