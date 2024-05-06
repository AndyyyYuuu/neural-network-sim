// OpModule: includes all modules with input(s) and output(s)
public abstract class OpModule extends Module{

  
  
  public OpModule(PVector pos){
    super(pos);
    
  }
  
  public OpModule(){
  }
  
  
  
  public ArrayList<Num> getInputs(){
    ArrayList<Num> results = new ArrayList<Num>();
    for (int i=0; i<this.inputs.size(); i++){
      results.add(getInput(i));
    }
    return results;
  }
}

public abstract class BasicOpModule extends OpModule{
  public abstract Module createNew();
  public BasicOpModule(){
    super();
  }
  public BasicOpModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-15, -10)));
    inputs.add(new InputPort(this, new PVector(-15, 10)));
    output = new OutputPort(this, new PVector(23, 0));
  }
  public boolean mouseIsIn(){
    return dist(mouseX, mouseY, this.pos.x, this.pos.y) < 15;
  }
  public void draw(){
    fill(0);
    stroke(COLOR_OP);
    strokeWeight(2);
    circle(this.pos.x, this.pos.y, 30);
    drawPorts();
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
    fill(COLOR_OP);
    textSize(32);
    textAlign(CENTER);
    text("×", this.pos.x, this.pos.y+11);
  }
  
  public Num forward(){
    this.outputNum = getInput(0).mult(getInput(1));
    return this.outputNum;
  }
  
  public Module createNew(){
    return new MultModule(this.pos);
  }
  
}

public class AddModule extends BasicOpModule{
  public AddModule(){
    super();
  }
  public AddModule(PVector pos){
    super(pos);
  }
  
  public void draw(){
    super.draw();
    fill(COLOR_OP);
    textSize(32);
    textAlign(CENTER);
    text("+", this.pos.x, this.pos.y+11);
  }
  
  public Num forward(){
    this.outputNum = getInput(0).add(getInput(1));
    return this.outputNum;
  }
  
  public Module createNew(){
    return new AddModule(this.pos);
  }
  
}


public class NeuronModule extends OpModule{
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
    stroke(COLOR_NEURAL);
    strokeWeight(2);
    circle(this.pos.x, this.pos.y, 60);
    fill(COLOR_NEURAL);
    textSize(32);
    textAlign(CENTER);
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
