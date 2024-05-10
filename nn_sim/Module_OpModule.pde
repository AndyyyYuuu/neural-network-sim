// OpModule: includes all modules with input(s) and output(s)
public abstract class OpModule extends Module{
  
  public OpModule(PVector pos){
    super(pos);
    
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
  public BasicOpModule(PVector pos){
    super(pos);
    output = new OutputPort(this, new PVector(23, 0));
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_OP);
    strokeWeight(2);
    circle(this.pos.x, this.pos.y, 30);
    drawAttachments(COLOR_OPTIM);
  }
  public boolean mouseIsIn(){
    return dist(mouseX, mouseY, this.pos.x, this.pos.y) < 15;
  }
}

public abstract class BinaryOpModule extends BasicOpModule{
  public abstract Module createNew();
  
  public BinaryOpModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-15, -10)));
    inputs.add(new InputPort(this, new PVector(-15, 10)));
  }
}

public class MultModule extends BinaryOpModule{

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
  
  public Num _forward(){
    this.outputNum = getInput(0).mult(getInput(1));
    return this.outputNum;
  }
  
  public Module createNew(){
    return new MultModule(this.pos);
  }
  
}

public class AddModule extends BinaryOpModule{
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
  
  public Num _forward(){
    this.outputNum = getInput(0).add(getInput(1));
    return this.outputNum;
  }
  
  public Module createNew(){
    return new AddModule(this.pos);
  }
  
}

public abstract class UnaryOpModule extends BasicOpModule{
  //public abstract Module createNew();

  public UnaryOpModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-15, 0)));
  }
}

public class TanhModule extends UnaryOpModule{
  
  public TanhModule(PVector pos){
    super(pos);
  }
  
  public void draw(){
    super.draw();
    fill(COLOR_OP);
    textSize(9);
    textAlign(CENTER);
    text("tanh", this.pos.x+2, this.pos.y+3);
  }
  
  public Num _forward(){
    this.outputNum = getInput(0).tanh();
    return this.outputNum;
  }
  
  
  
  public Module createNew(){
    return new TanhModule(this.pos);
  }
}


public class NeuronModule extends OpModule{

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
  
  public Num _forward(){
    this.outputNum = sum(getInputs());
    return this.outputNum;
  }
  
  public Module createNew(){
    return new NeuronModule(this.pos);
  }
}
