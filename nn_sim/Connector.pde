
class Connector{
  Port port1, port2;
  public Connector(Port port){
    this.port1 = port;
    this.port2 = null;
  }
  
  public void update(){
    stroke(255);
    strokeWeight(3);
    if (this.port2 == null){
      line(port1.getAbsX(), port1.getAbsY(), mouseX, mouseY);
    }else{
      line(port1.getAbsX(), port1.getAbsY(), port2.getAbsX(), port2.getAbsY());
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
}