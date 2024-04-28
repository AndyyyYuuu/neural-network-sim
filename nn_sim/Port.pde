
public abstract class Port{
  public Module parent;
  public boolean occupied = false;
  private PVector pos;
  public boolean isInput;
  public ArrayList<Connector> connectors = new ArrayList<Connector>();
  public Port(Module parent, PVector pos){
    this.parent = parent;
    this.pos = pos;
    ports.add(this);
  }
  
  public ArrayList<Port> getOtherEnds(){
    ArrayList<Port> ends = new ArrayList<Port>();
    for (Connector c : this.connectors){
      if (c.isFullyConnected()){
        ends.add(c.getOtherEnd(this));
      }
    }
    return ends;
  }
  
  public Port getOtherEnd(){
    return this.getOtherEnds().get(0);
  }
  
  public float getAbsX(){
    return pos.x + parent.pos.x;
  }
  
  public float getAbsY(){
    return pos.y + parent.pos.y;
  }
  
  public float getRelX(){
    return pos.x;
  }
  
  public float getRelY(){
    return pos.y;
  }
  
  public boolean mouseIsIn(){
    return dist(getAbsX(), getAbsY(), mouseX, mouseY) < 5;
  }
  
  public Port connect(Connector connector){
    this.connectors.add(connector);
    return this;
  }
  
  
  
  
}

public class InputPort extends Port{
  
  public InputPort(Module parent, PVector pos){
    super(parent, pos);
    isInput = true;
  }
}

public class OutputPort extends Port{
  public OutputPort(Module parent, PVector pos){
    super(parent, pos);
    isInput = false;
  }
}
