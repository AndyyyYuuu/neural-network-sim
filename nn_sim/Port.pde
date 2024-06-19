
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
  
  public abstract boolean canConnect();
  public abstract void draw();
  
  // Get all ports opposite to this port across connectors
  public ArrayList<Port> getOtherEnds(){
    ArrayList<Port> ends = new ArrayList<Port>();
    for (Connector c : this.connectors){
      if (c.isFullyConnected()){
        ends.add(c.getOtherEnd(this));
      }
    }
    return ends;
  }
  
  // Get the port opposite to this port across a connector
  public Port getOtherEnd(){
    if (this.getOtherEnds().size() == 0){
      return null;
    }
    return this.getOtherEnds().get(0);
  }
  
  // Absolute coordinates (on screen)
  public float getAbsX(){
    return pos.x + parent.pos.x;
  }
  
  public float getAbsY(){
    return pos.y + parent.pos.y;
  }
  
  // Coordinates relative to parent module
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
  
  public void delete(Connector connector){
    removeItem(connectors, connector);
  }

}

// Circular input port
public class InputPort extends Port{
  public boolean multi;
  public InputPort(Module parent, PVector pos, boolean multi){
    super(parent, pos);
    this.isInput = true;
    this.multi = multi;
  }
  
  public InputPort(Module parent, PVector pos){
    this(parent, pos, false);
    
  }
  
  public boolean canConnect(){
    return multi || connectors.size() == 0;
  }
  
  public void draw(){
    if (multi){
      ellipse(getAbsX(), getAbsY(), 10, 15);
    }else{
      circle(getAbsX(), getAbsY(), 10);
    }
  }
}

// Triangular output port
public class OutputPort extends Port{
  public OutputPort(Module parent, PVector pos){
    super(parent, pos);
    isInput = false;
  }
  
  public boolean canConnect(){
    return true;
  }
  
  public void draw(){
    pushMatrix();
    translate(getAbsX(), getAbsY());
    triangle(-4, 6, -4, -6, 4, 0);
    popMatrix();
  }
}
