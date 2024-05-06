// LossModule: mean-squared loss function

public class LossModule extends OpModule{
  public ArrayList<Num> inputYPred = new ArrayList<Num>();
  public ArrayList<Num> inputY = new ArrayList<Num>();
  public String funcName;
  public int batchSize;
  
  public LossModule(PVector pos, int batchSize){
    super(pos);
    this.batchSize = batchSize;
    inputs.add(new InputPort(this, new PVector(-30, -30)));
    inputs.add(new InputPort(this, new PVector(-45, -5)));
    buttons.add(new Button(new PVector(-5, -9), new PVector(40, 18), this));
    output = new OutputPort(this, new PVector(55, 0));
    funcName = "μ²";
  }
  
  public void draw(){
    fill(0);
    strokeWeight(2);
    stroke(COLOR_NEURAL);
    rect(this.pos.x-45, this.pos.y-30, 90, 60);
    rect(this.pos.x-40, this.pos.y+15, 60, 10);
    //rect(this.pos.x-5, this.pos.y-13, 40, 17);
    fill(COLOR_NEURAL);
    textAlign(LEFT);
    textSize(11);
    text("ℓ(ŷ,y)=", this.pos.x-5, this.pos.y-17);
    /*textSize(14);
    textAlign(CENTER);
    text(funcName, this.pos.x+15, this.pos.y);*/
    textSize(12);
    textAlign(LEFT);
    text("ŷ", this.pos.x-37, this.pos.y-3);
    text("y", this.pos.x-30, this.pos.y-15);
    if (inputY.size() > 0){
      rect(this.pos.x-37, this.pos.y+18, 54*((float)inputY.size()/(float)this.batchSize), 4);
    }
    fill(0);
    drawAttachments();
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-40, this.pos.y-30, 80, 60);
  }
  
  public Num _forward(){
    if (inputY.size() < this.batchSize){
      inputY.add(getInput(0));
      inputYPred.add(getInput(1));
      this.outputNum = meanSquaredError(inputYPred, inputY);
    } else {
      if (buttons.get(0).isOn()){
        buttons.get(0).turnOff();
        inputYPred.clear();
        inputY.clear();
      }
    }
    return this.outputNum;
  }
  
  public Module createNew(){
    return new LossModule(this.pos, this.batchSize);
  }
  
  public void clearStorage(){
    inputYPred.clear();
    inputY.clear();
  }
}
