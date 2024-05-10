// LossModule: mean-squared loss function

public class LossModule extends OpModule{
  public ArrayList<Num> inputYPred = new ArrayList<Num>();
  public ArrayList<Num> inputY = new ArrayList<Num>();
  public String funcName;
  public int batchSize;
  public boolean calculatingAll = false;
  
  public LossModule(PVector pos, int batchSize){
    super(pos);
    this.batchSize = batchSize;
    inputs.add(new InputPort(this, new PVector(-30, -30)));
    inputs.add(new InputPort(this, new PVector(-45, -5)));
    
    buttons.add(new Button(new PVector(-5, -25), new PVector(20, 20), ICON_FORWARD, this));
    buttons.add(new Button(new PVector(20, -25), new PVector(20, 20), ICON_REFRESH, this));
    
    output = new OutputPort(this, new PVector(55, 5));
    funcName = "μ²";
  }
  
  public void draw(){
    fill(0);
    strokeWeight(2);
    stroke(COLOR_NEURAL);
    rect(pos.x-45, pos.y-30, 90, 60);
    rect(pos.x-40, pos.y+15, 60, 10);
    //rect(this.pos.x-5, this.pos.y-13, 40, 17);
    fill(COLOR_NEURAL);
    textAlign(LEFT);
    textSize(11);
    text("ℓ(ŷ,y)=", pos.x-5, pos.y+8);
    /*textSize(14);
    textAlign(CENTER);
    text(funcName, this.pos.x+15, this.pos.y);*/
    textSize(12);
    textAlign(LEFT);
    text("ŷ", pos.x-37, pos.y-3);
    text("y", pos.x-30, pos.y-15);
    if (inputY.size() > 0){
      rect(pos.x-37, pos.y+18, 54*((float)inputY.size()/(float)this.batchSize), 4);
      
    }
    fill(0);
    drawAttachments(COLOR_NEURAL);
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-40, this.pos.y-30, 80, 60);
  }
  
  public Num _forward(){
    
    if (inputY.size() < this.batchSize){
      if (buttons.get(0).isOn()){
        calculateLoss();
        buttons.get(0).turnOff();
      }
      if (calculatingAll){
        calculateLoss();
      }
    } else {
      calculatingAll = false;
    }
    
    if (buttons.get(1).isOn() && !calculatingAll){
      buttons.get(1).turnOff();
      calculatingAll = true;
      if (inputY.size() >= this.batchSize){
        inputYPred.clear();
        inputY.clear();
      }
    } 
    
    return this.outputNum;
  }
  
  private void calculateLoss(){
    inputY.add(getInput(0));
    inputYPred.add(getInput(1));
    this.outputNum = meanSquaredError(inputYPred, inputY);
  }
  
  public Module createNew(){
    return new LossModule(this.pos, this.batchSize);
  }
  
  public void clearStorage(){
    inputYPred.clear();
    inputY.clear();
  }
}
