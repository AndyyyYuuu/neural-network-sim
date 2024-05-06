// InputModule: includes all modules with only outputs
public abstract class InputModule extends Module{
  
  public InputModule(PVector pos){
    
    super(pos);
    
  }
  
  public InputModule(){
  }
}

public class NumModule extends InputModule{
  public NumModule(PVector pos){
    super(pos);
    output = new OutputPort(this, vec(30, 0));
  }
  
  public NumModule(){
  }
  
  public void setNum(double num){
    this.outputNum = new Num(num);
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_DATA);
    strokeWeight(2);
    rect(this.pos.x-22, this.pos.y-8, 44, 16);
    drawPorts();
    fill(COLOR_DATA);
    textAlign(LEFT);
    textSize(11);
    text(processDouble(this.outputNum.value), this.pos.x-20, this.pos.y+4);
    
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-22, this.pos.y-8, 44, 16);
  }
  
  public Num forward(){
    return this.outputNum;
  }
  
  public Module createNew(){
    return new NumModule(this.pos);
  }
  
}

public class ParamModule extends NumModule{
  public ParamModule(PVector pos){
    super(pos);
  }
  
  public ParamModule(){
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_OPTIM);
    strokeWeight(2);
    rect(this.pos.x-22, this.pos.y-8, 44, 16);
    drawPorts();
    fill(COLOR_OPTIM);
    textAlign(LEFT);
    textSize(11);
    text(processDouble(this.outputNum.value), this.pos.x-20, this.pos.y+4);
  }
  
  public Module createNew(){
    return new ParamModule(this.pos);
  }
  
}



public class DataModule extends InputModule{
  Dataset data;
  PVector x1Pos, x2Pos, yPos;
  
  NumModule x1, x2, y;
  public DataModule(PVector pos){
    super(pos);
    data = circleData;
    x1Pos = new PVector(8, 35);
    x2Pos = new PVector(8, 10);
    yPos = new PVector(8, -35);
    x1 = new NumModule(pos);
    x2 = new NumModule(pos);
    y = new NumModule(pos);
    updatePositions();
    x1.setNum(data.getTrain().inputs[0]);
    x2.setNum(data.getTrain().inputs[1]);
    y.setNum(data.getTrain().output);
  }
  
  public DataModule(){
    super();
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
  
  public Num forward(){
    
    return new Num(1);
  }
  
  public Module createNew(){
    return new DataModule(this.pos);
  }
  
}
