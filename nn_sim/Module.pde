
public abstract class Module{
  public abstract Num _forward();
  public PVector pos, mousePos;
  public abstract void draw();
  public abstract boolean mouseIsIn();
  public abstract Module createNew(PVector pos);
  
  
  public boolean calledNext = false;
  public ArrayList<Button> buttons = new ArrayList<Button>();
  public ArrayList<Slider> sliders = new ArrayList<Slider>();
  public ArrayList<InputPort> inputs = new ArrayList<InputPort>();
  public OutputPort output;
  
  public String name;
  
  public Num outputNum = new Num(0);
  
  public Module(){
  }
  
  public Module getInput(int idx){
    return this.inputs.get(idx).getOtherEnd().parent;
    
  }
  
  public ArrayList<Num> getInputs(){
    ArrayList<Num> results = new ArrayList<Num>();
    for (int i=0; i<this.inputs.size(); i++){
      results.add(getInput(i).forward());
    }
    return results;
  }
  
  public void update(){
  }
  
  // Next all leaf nodes from root
  public void next(){
    clearNext();
    _next();
  }
  
  public void clearNext(){
    calledNext = false;
    if (hasAllInputs()){
      for (int i=0; i<this.inputs.size(); i++){
        Module input = this.inputs.get(i).getOtherEnd().parent;
        input.clearNext();
      }
    }
  }
  
  public void _next(){
    calledNext = true;
    if (hasAllInputs()){
      for (int i=0; i<this.inputs.size(); i++){
        Module input = this.inputs.get(i).getOtherEnd().parent;
        if (!input.calledNext){
          input._next();
        }
      }
    }
    /*
    if (output != null && output.getOtherEnd() != null){
      Module outModule = output.getOtherEnd().parent;
      if (outModule instanceof GraphModule){
        ((GraphModule)outModule).addValue(forward().getValue());
      }
    }*/
  }
  
  public Module(PVector pos){
    this.pos = pos;
  }
  
  public Num forward(){
    if (!hasAllInputs()){
      return null;
    }
    
    return _forward();
  }
  
  public boolean hasAllInputs(){
    for (InputPort p: inputs){
      if (p.getOtherEnd() == null || p.getOtherEnd().parent.outputNum == null){
        return false;
      }
    }
    return true;
  }
  
  public void show(){
    this.draw();
    this.update();
  }
  
  
  public Module grab(){
    this.mousePos = new PVector(mouseX-pos.x, mouseY-pos.y);
    return this;
  }
  public void followMouse(){
    this.pos = new PVector(mouseX, mouseY).sub(this.mousePos);
  }
  public void drawAttachments(color c){
    fill(0);
    for (int i=0; i<this.inputs.size(); i++){
      Port aPort = this.inputs.get(i);
      circle(aPort.getAbsX(), aPort.getAbsY(), 10);
    }
    if (output != null){
      pushMatrix();
      translate(output.getAbsX(), output.getAbsY());
      triangle(-4, 6, -4, -6, 4, 0);
      popMatrix();
    }
    
    for (Button b: this.buttons){
      b.draw(c);
    }
    for (Slider s: this.sliders){
      s.draw(c);
    }
  }
  
}
