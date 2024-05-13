
public class ReaderModule extends Module{
  public ReaderModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, vec(-25, 0)));
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_READER);
    strokeWeight(2);
    rect(this.pos.x-25, this.pos.y-8, 50, 16);
    drawAttachments(COLOR_READER);
    fill(COLOR_READER);
    textAlign(LEFT);
    textSize(11);
    if (hasAllInputs()){
      text(processDouble(inputs.get(0).getOtherEnd().parent.outputNum.getValue()), this.pos.x-20, this.pos.y+4);
    }
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-22, this.pos.y-8, 44, 16);
  }
  
  public Num _forward(){
    return null;
  }
  
  public Module createNew(){
    return new ReaderModule(this.pos);
  }
}
