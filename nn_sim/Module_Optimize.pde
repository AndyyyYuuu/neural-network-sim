
public class OptimModule extends Module{
  public Num inputLoss = null;
  public double stepSize = 0;
  public OptimModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-50, -45)));
    buttons.add(new Button(new PVector(-40, -30), new PVector(20, 20), ICON_BACKWARD, this));
    buttons.add(new Button(new PVector(-10, -30), new PVector(20, 20), ICON_DESCEND, this));
    buttons.add(new Button(new PVector(20, -30), new PVector(20, 20), ICON_ZERO, this));
    sliders.add(new Slider(new PVector(-40, 20), 80, 0.3, this));
    
  }
  /*
  public void setNum(double num){
    this.outputNum = new Num(num);
  }*/
  
  public void draw(){
    fill(0);
    stroke(COLOR_OPTIM);
    strokeWeight(2);
    rect(this.pos.x-50, this.pos.y-60, 100, 120);
    drawAttachments(COLOR_OPTIM);
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
    textSize(10);
    text("Step:", this.pos.x-40, this.pos.y+10);
    textSize(11);
    text(processDouble(stepSize, 7, false), this.pos.x-10, this.pos.y+10);
    
    drawAttachments(COLOR_OPTIM);
    
    if (buttons.get(0).isOn()){
      buttons.get(0).turnOff();
      if (this.hasAllInputs()){
        inputLoss.zeroGrad();
        inputLoss.backward();
      }
    }
    
    if (buttons.get(1).isOn()){
      buttons.get(1).turnOff();
      inputLoss.descend(stepSize);
      
    }
    
    if (buttons.get(2).isOn()){
      buttons.get(2).turnOff();
      inputLoss.zeroGrad();
      
    }
    stepSize = Math.pow(10, -((double)sliders.get(0).getStatus()*5));
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
