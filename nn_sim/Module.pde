
public abstract class Module{
  public ArrayList<InputPort> inputs = new ArrayList<InputPort>();
  public Port output;
  public Num outputNum;
  public PVector pos, mousePos;
  public abstract Num forward();
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
  
  public Num getInput(int idx){
    return this.inputs.get(idx).getOtherEnd().parent.outputNum;
  }
  
  public ArrayList<Num> getInputs(){
    ArrayList<Num> results = new ArrayList<Num>();
    for (int i=0; i<this.inputs.size(); i++){
      results.add(getInput(i));
    }
    return results;
  }
  public Module grab(){
    this.mousePos = new PVector(mouseX-pos.x, mouseY-pos.y);
    return this;
  }
  public void followMouse(){
    this.pos = new PVector(mouseX, mouseY).sub(this.mousePos);
  }
}

public abstract class BasicOpModule extends Module{
  public abstract Module createNew();
  public BasicOpModule(){
    super();
  }
  public BasicOpModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-20, -10)));
    inputs.add(new InputPort(this, new PVector(-20, 10)));
    output = new OutputPort(this, new PVector(30, 0));
  }
  public boolean mouseIsIn(){
    return dist(mouseX, mouseY, this.pos.x, this.pos.y) < 20;
  }
  public void draw(){
    fill(0);
    stroke(0, 255, 0);
    strokeWeight(2);
    circle(this.pos.x, this.pos.y, 40);
    for (int i=0; i<this.inputs.size(); i++){
      Port aPort = this.inputs.get(i);
      circle(aPort.getAbsX(), aPort.getAbsY(), 10);
    }
    pushMatrix();
    translate(output.getAbsX(), output.getAbsY());
    triangle(-4, 6, -4, -6, 4, 0);
    popMatrix();
  }
}

public class MultModule extends BasicOpModule{
  public MultModule(){
    super();
  }
  public MultModule(PVector pos){
    super(pos);
  }
  
  public void draw(){
    super.draw();
    fill(0, 255, 0);
    textSize(32);
    textAlign(CENTER);
    text("×", this.pos.x, this.pos.y+12);
  }
  
  public Num forward(){
    this.outputNum = getInput(0).mult(getInput(1));
    return this.outputNum;
  }
  
  public Module createNew(){
    return new MultModule(this.pos);
  }
  
}


public class NeuronModule extends Module{
  public NeuronModule(){
    super();
  }
  public NeuronModule(PVector pos){
    super(pos);
  }
  
  public boolean mouseIsIn(){
    return dist(mouseX, mouseY, this.pos.x, this.pos.y) < 30;
  }
  
  public void draw(){
    fill(0);
    stroke(0, 255, 255);
    strokeWeight(2);
    circle(this.pos.x, this.pos.y, 60);
    fill(0, 255, 255);
    textSize(32);
    text("N", this.pos.x, this.pos.y+8);
  }
  
  public Num forward(){
    this.outputNum = sum(getInputs());
    return this.outputNum;
  }
  
  public Module createNew(){
    return new NeuronModule(this.pos);
  }
}
