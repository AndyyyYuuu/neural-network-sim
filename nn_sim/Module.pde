
public abstract class Module{
  public abstract Num forward();
  public PVector pos, mousePos;
  public abstract void draw();
  public abstract boolean mouseIsIn();
  public abstract Module createNew();
  
  
  public ArrayList<InputPort> inputs = new ArrayList<InputPort>();
  public OutputPort output;
  
  public Num outputNum = new Num(0);
  
  public Module(){
  }
  
  public Num getInput(int idx){
    return this.inputs.get(idx).getOtherEnd().parent.forward();
  }
  
  
  
  public Module(PVector pos){
    this.pos = pos;
    
  }
  
  public Num attemptForward(){
    if (!hasAllInputs()){
      return null;
    }
    return forward();
  }
  
  public boolean hasAllInputs(){
    for (InputPort p: inputs){
      if (p.getOtherEnd() == null){
        return false;
      }
    }
    return true;
  }
  
  public void show(){
    this.draw();
  }
  
  
  public Module grab(){
    this.mousePos = new PVector(mouseX-pos.x, mouseY-pos.y);
    return this;
  }
  public void followMouse(){
    this.pos = new PVector(mouseX, mouseY).sub(this.mousePos);
  }
  public void drawPorts(){
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
    
  }
}
