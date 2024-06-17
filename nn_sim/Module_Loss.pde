// LossModule: mean-squared loss function

public class MeanModule extends Module{
  public ArrayList<Num> inputY = new ArrayList<Num>();
  public int batchSize;
  public boolean calculatingAll = false;
  
  public MeanModule(PVector pos, int batchSize){
    super(pos);
    this.batchSize = batchSize;
    inputs.add(new InputPort(this, new PVector(-45, -5)));
    
    buttons.add(new Button(new PVector(-5, -25), new PVector(20, 20), ICON_FORWARD, this));
    buttons.add(new Button(new PVector(20, -25), new PVector(20, 20), ICON_REFRESH, this));
    
    output = new OutputPort(this, new PVector(55, 5));
    name = "Cumulative Mean";
    shortDesc = "Takes the mean of "+batchSize+" values";
    longDesc = new String[]{
      "Given a value as input, ",
      "cumulatively takes the mean of",
      "the values across " + batchSize + " input runs."
    };
  }
  
  public void draw(){
    fill(0);
    strokeWeight(2);
    stroke(COLOR_NEURAL);
    rect(pos.x-45, pos.y-30, 90, 60);
    rect(pos.x-40, pos.y+15, 60, 10);

    fill(COLOR_NEURAL);
    textAlign(LEFT);
    textSize(11);
    text("̄x = ", pos.x+20, pos.y+8);

    textSize(12);
    textAlign(LEFT);
    text("x", pos.x-37, pos.y-3);
    if (inputY.size() > 0){
      rect(pos.x-37, pos.y+18, 54*((float)inputY.size()/(float)this.batchSize), 4);
      
    }
    fill(0);
    drawAttachments(COLOR_NEURAL);
    
  }
  
  public void update(){
    if (hasAllInputs()){
      if (inputY.size() < this.batchSize){
        
        if (buttons.get(0).isOn()){
          calculate();
          buttons.get(0).turnOff();
        }
        if (calculatingAll){
          calculate();
          
        }
      } else {
        calculatingAll = false;
      }
      
      if (buttons.get(1).isOn() && !calculatingAll){
        buttons.get(1).turnOff();
        calculatingAll = true;
        if (inputY.size() >= this.batchSize){
          clearAll();
        }
      }
    }
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-40, this.pos.y-30, 80, 60);
  }
  
  public Num _forward(){
    return this.outputNum;
  }
  
  public boolean isDone(){
    return inputY.size() >= this.batchSize;
  }
  
  public void clearAll(){
    inputY.clear();
  }

  private void calculate(){
    inputY.add(getInput(0).forward());
    next();
    this.outputNum = mean(inputY);
  }
  
  public Module createNew(PVector pos){
    return new MeanModule(pos, this.batchSize);
  }
  
  public void clearStorage(){
    inputY.clear();
  }
}



public class LossModule extends MeanModule{
  public ArrayList<Num> inputYPred = new ArrayList<Num>();
  public String funcName;
  
  public LossModule(PVector pos, int batchSize){
    super(pos, batchSize);
    inputs.add(new InputPort(this, new PVector(-30, -30)));
    
    funcName = "μ²";
    name = "MSE Loss Function";
    shortDesc = "Compares "+batchSize+" predicted outputs to truth";
    longDesc = new String[]{
      "Given predicted values and",
      "expected values, outputs the",
      "mean-squared error loss across",
      ""+batchSize+" input runs.",
      "",
      "The mean-squared error computes",
      "a value for the difference",
      "of predicted values from true",
      "values. Feed its output to",
      "an optimizer to optimize a",
      "neural network."
    };
  }
  
  public void draw(){
    fill(0);
    strokeWeight(2);
    stroke(COLOR_NEURAL);
    rect(pos.x-45, pos.y-30, 90, 60);
    rect(pos.x-40, pos.y+15, 60, 10);

    fill(COLOR_NEURAL);
    textAlign(LEFT);
    textSize(11);
    text("ℓ(ŷ,y)=", pos.x-5, pos.y+8);

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
  
  private void calculate(){
    inputY.add(getInput(0).forward());
    inputYPred.add(getInput(1).forward());
    next();
    this.outputNum = meanSquaredError(inputYPred, inputY);
  }
  
  public void clearAll(){
    inputY.clear();
    inputYPred.clear();
  }
  
  public Module createNew(PVector pos){
    return new LossModule(pos, this.batchSize);
  }
  
  public void clearStorage(){
    inputYPred.clear();
    inputY.clear();
  }
}
