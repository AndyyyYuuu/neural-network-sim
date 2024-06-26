// OpModule: includes all modules with input(s) and output(s)
public abstract class OpModule extends Module{
  public OpModule(PVector pos){
    super(pos);
  }
}



public abstract class BasicOpModule extends OpModule{
  public abstract Module createNew(PVector pos);
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
  public abstract Module createNew(PVector pos);
  
  public BinaryOpModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-15, -10)));
    inputs.add(new InputPort(this, new PVector(-15, 10)));
  }
}



public class MultModule extends BinaryOpModule{

  public MultModule(PVector pos){
    super(pos);
    name = "Multiplication";
    shortDesc = "Multiplies two numbers";
    longDesc = new String[]{
      "Given two numerical inputs,",
      "outputs their product."
    };
  }
  
  public void draw(){
    super.draw();
    fill(COLOR_OP);
    textSize(32);
    textAlign(CENTER);
    text("×", this.pos.x, this.pos.y+11);
  }
  
  public Num _forward(){
    this.outputNum = getInput(0).forward().mult(getInput(1).forward());
    return this.outputNum;
  }
  
  public Module createNew(PVector pos){
    return new MultModule(pos);
  }
  
}



public class AddModule extends BinaryOpModule{
  public AddModule(PVector pos){
    super(pos);
    name = "Addition";
    shortDesc = "Adds two numbers";
    longDesc = new String[]{
      "Given two numerical inputs,",
      "outputs their sum."
    };
  }
  
  public void draw(){
    super.draw();
    fill(COLOR_OP);
    textSize(32);
    textAlign(CENTER);
    text("+", this.pos.x, this.pos.y+11);
  }
  
  public Num _forward(){
    this.outputNum = getInput(0).forward().add(getInput(1).forward());
    return this.outputNum;
  }
  
  public Module createNew(PVector pos){
    return new AddModule(pos);
  }
  
}



public abstract class UnaryOpModule extends BasicOpModule{
  public UnaryOpModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, new PVector(-15, 0)));
  }
}


public class TanhModule extends UnaryOpModule{
  public TanhModule(PVector pos){
    super(pos);
    name = "Hyperbolic Tangent";
    shortDesc = "Sigmoid with outputs between -1 and 1";
    longDesc = new String[]{
      "Given one numerical input,",
      "outputs its tanh().",
      "",
      "The tanh is an S-shaped function",
      "that takes any real number as",
      "input and outputs a value",
      "between -1 and 1.",
      "",
      "tanh(x) = (e^x-e^-x)/(e^x+e^-x)"
    };
  }
  
  public void draw(){
    super.draw();
    fill(COLOR_OP);
    textSize(9);
    textAlign(CENTER);
    text("tanh", this.pos.x+2, this.pos.y+3);
  }
  
  public Num _forward(){
    this.outputNum = getInput(0).forward().tanh();
    return this.outputNum;
  }
  
  public Module createNew(PVector pos){
    return new TanhModule(pos);
  }
}



public class SinModule extends UnaryOpModule{
  
  public SinModule(PVector pos){
    super(pos);
    name = "Trigonometric Sine";
    shortDesc = "Periodic trigonometric function";
    longDesc = new String[]{
      "Given one numerical input,",
      "outputs its sine.",
      "",
      "The sinusoidal is a repeating",
      "function that takes any number",
      "as input and outputs a value",
      "between -1 and 1."
    };
  }
  
  public void draw(){
    super.draw();
    fill(COLOR_OP);
    textSize(9);
    textAlign(CENTER);
    text("sin", this.pos.x+2, this.pos.y+3);
  }
  
  public Num _forward(){
    this.outputNum = getInput(0).forward().sin();
    return this.outputNum;
  }

  public Module createNew(PVector pos){
    return new SinModule(pos);
  }
}


public class ReciprocalModule extends UnaryOpModule{
  
  public ReciprocalModule(PVector pos){
    super(pos);
    name = "Reciprocal";
    shortDesc = "Raise input to the -1 power";
    longDesc = new String[]{
      "Given one numerical input,",
      "outputs its reciprocal.",
      "",
      "The reciprocal of an input is",
      "obtained by dividing 1 by that",
      "number."
    };
  }
  
  public void draw(){
    super.draw();
    fill(COLOR_OP);
    textSize(14);
    textAlign(CENTER);
    text("1/", this.pos.x+2, this.pos.y+6);
  }
  
  public Num _forward(){
    this.outputNum = getInput(0).forward().pow(-1);
    return this.outputNum;
  }

  public Module createNew(PVector pos){
    return new ReciprocalModule(pos);
  }
}


public class NeuronModule extends OpModule{
  public ArrayList<Num> weights = new ArrayList<Num>();
  public Num bias = new Num(0);
  public NeuronModule(PVector pos){
    super(pos);
    inputs.add(new MultiInputPort(this, new PVector(-25, 0)));
    output = new OutputPort(this, new PVector(35, 0));
    bias.makeParam();
    name = "Linear Neuron";
    shortDesc = "Neuron complete with weights and biases";
    longDesc = new String[]{
      "Given multiple numerical,",
      "inputs, outputs the result",
      "of a linear fully-connected",
      "neuron.",
      "",
      "The neuron takes multiple",
      "inputs, multiplies a weight",
      "for each one, sums them, and",
      "adds a bias. Weights and",
      "biases are optimizable",
      "parameters.",
      "",
      "  N({x₀, x₁ ... xn})",
      "= Σ(xi × wi) + bi",
    };
  }
  
  public boolean mouseIsIn(){
    return dist(mouseX, mouseY, this.pos.x, this.pos.y) < 25;
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_NEURAL);
    strokeWeight(2);
    circle(this.pos.x, this.pos.y, 50);
    fill(COLOR_NEURAL);
    textSize(32);
    textAlign(CENTER);
    text("N", this.pos.x, this.pos.y+12);
    drawAttachments(COLOR_NEURAL);
  }
  
  public Num _forward(){
    while (weights.size() < getInputs().size()){
      Num n = new Num(Math.random()*2-1);
      n.makeParam();
      weights.add(n);
    }
    Num sum = new Num(0);
    for (int i=0; i<weights.size(); i++){
      sum = sum.add(getInput(i).forward().mult(weights.get(i)));
    }
    this.outputNum = sum.add(bias); 
    return this.outputNum;
  }
  
  public Module createNew(PVector pos){
    return new NeuronModule(pos);
  }
}
