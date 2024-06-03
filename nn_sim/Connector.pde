
class Connector{
  Port port1, port2;
  public Connector(Port port){
    this.port1 = port;
    this.port2 = null;
  }
  
  public void show(){
    
    stroke(255);
    if (port2 != null && port2.parent instanceof ReaderModule){
      stroke(255/2);
    }
    strokeWeight(3);
    if (this.port2 == null){
      dottedLine(mouseX, mouseY, port1.getAbsX(), port1.getAbsY());
    }else{
      flowingLine(port1.getAbsX(), port1.getAbsY(), port2.getAbsX(), port2.getAbsY());
    }
  }
  
  public boolean connect(Port otherPort){
    if (this.port1.isInput != otherPort.isInput && this.port1.parent != otherPort.parent){
      this.port2 = otherPort;
      this.port1.connect(this);
      this.port2.connect(this);
      
      if (this.port2 instanceof OutputPort){
        
        Port temp = this.port1;
        this.port1 = this.port2;
        this.port2 = temp;
      }
      println(port1.connectors.size(), port2.connectors.size());
      
      return true;
    }else{
      return false;
    }
  }
  
  public Port getOtherEnd(Port aPort){
    if (this.port1 == aPort){
      return this.port2;
    }else if (this.port2 == aPort){
      return this.port1;
    }else{
      println(CATASTROPHIC_LETHAL_ERROR_MESSAGE);
      exit();
    } 
    return null;
  }
  
  public boolean isFullyConnected(){
    return port1 != null && port2 != null;
  }
  
  public void delete(){
    removeItem(connectors, this);
    port1.delete(this);
    port2.delete(this);
    port1 = null;
    port2 = null;
  }
}
