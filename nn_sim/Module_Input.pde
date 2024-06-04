// InputModule: includes all modules with only outputs
public abstract class InputModule extends Module{
  
  public InputModule(PVector pos){
    
    super(pos);
    
  }
  
  public InputModule(){
  }
}

public class NumModule extends InputModule{
  public NumModule(PVector pos, double num){
    super(pos);
    output = new OutputPort(this, vec(30, 0));
    name = "Constant: "+num;
    shortDesc = "Outputs the number "+num+" constantly";
    outputNum = new Num(num);
  }
  
  public void setNum(double num){
    this.outputNum = new Num(num);
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_DATA);
    strokeWeight(2);
    rect(this.pos.x-22, this.pos.y-8, 44, 16);
    drawAttachments(COLOR_DATA);
    fill(COLOR_DATA);
    textAlign(LEFT);
    textSize(11);
    text(processDouble(this.outputNum.value), this.pos.x-20, this.pos.y+4);
    
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-22, this.pos.y-8, 44, 16);
  }
  
  public Num _forward(){
    return this.outputNum;
  }
  
  public Module createNew(PVector pos){
    return new NumModule(pos, outputNum.getValue());
  }
  
}

public class DataValueModule extends NumModule{
  public DataModule dataModule;
  public DataValueModule(PVector pos, DataModule dataModule){
    super(pos, 0);
    this.dataModule = dataModule;
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-22, this.pos.y-8, 44, 16);
  }
  
  public Num _forward(){
    return this.outputNum;
  }
  
  public void _next(){
    calledNext = true;
    this.dataModule._next();
  }
  
  public void clearNext(){
    calledNext = false;
    this.dataModule.clearNext();
  }
  
  public Module createNew(PVector pos){
    return new DataValueModule(pos, this.dataModule);
  }
  
}

public class ParamModule extends NumModule{
  public ParamModule(PVector pos){
    super(pos, 0);
    this.outputNum.makeParam();
    name = "Optimizable Parameter";
    shortDesc = "A value changeable by the optimizer";
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_OPTIM);
    strokeWeight(2);
    rect(this.pos.x-22, this.pos.y-8, 44, 16);
    drawAttachments(COLOR_OPTIM);
    fill(COLOR_OPTIM);
    textAlign(LEFT);
    textSize(11);
    text(processDouble(this.outputNum.value), this.pos.x-20, this.pos.y+4);
    textSize(8);
    text(processDouble(this.outputNum.grad), this.pos.x-20, this.pos.y+18);
  }
  
  public Module createNew(PVector pos){
    return new ParamModule(pos);
    
  }
  
}



public class DataModule extends InputModule{
  Dataset data;
  PVector x1Pos, x2Pos, yPos;
  
  DataValueModule x1, x2, y;
  public DataModule(PVector pos){
    super(pos);
    data = circleData;
    x1Pos = new PVector(8, 35);
    x2Pos = new PVector(8, 10);
    yPos = new PVector(8, -35);
    x1 = new DataValueModule(pos, this);
    x2 = new DataValueModule(pos, this);
    y = new DataValueModule(pos, this);
    updatePositions();
    x1.setNum(data.getTrain().inputs[0]);
    x2.setNum(data.getTrain().inputs[1]);
    y.setNum(data.getTrain().output);
    name = "Dataset Loader";
    shortDesc = "Loads a dataset by input-output pairs";
    longDesc = new String[]{
      "Iterates through new data. Data",
      "is loaded with two inputs (x)",
      "and one expected output (ŷ). "
    };
  }
  
  public void draw(){
    fill(0);
    strokeWeight(2);
    stroke(COLOR_DATA);
    rect(this.pos.x-20, this.pos.y-50, 40, 100);
    x1.draw();
    x2.draw();
    y.draw();
  }
  
  public void updatePositions(){
    x1.pos = PVector.add(this.pos, x1Pos);
    x2.pos = PVector.add(this.pos, x2Pos);
    y.pos = PVector.add(this.pos, yPos);
  }
  
  public void followMouse(){
    super.followMouse();
    updatePositions();
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-20, this.pos.y-50, 40, 100);
  }
  
  public void _next(){
    if (!calledNext){
      data.next();
      x1.setNum(data.getTrain().inputs[0]);
      x2.setNum(data.getTrain().inputs[1]);
      y.setNum(data.getTrain().output);
      calledNext = true;
    }
  }
  
  public Num _forward(){
    
    return new Num(1);
  }
  
  public Module createNew(PVector pos){
    return new DataModule(pos);
  }
  
}
