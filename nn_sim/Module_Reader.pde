
public abstract class ReadOnlyModule extends Module{
  public ReadOnlyModule(PVector pos){
    super(pos);
  }
}

public class ReaderModule extends ReadOnlyModule{
  public ReaderModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, vec(-25, 0)));
    name = "Number Reader";
    shortDesc = "Reads the output of a module";
    longDesc = new String[]{
      "Given a number as an input,",
      "displays the number."
    };
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
    if (hasAllInputs() && getInput(0).forward() != null){
      text(processDouble(getInput(0).forward().getValue()), this.pos.x-20, this.pos.y+4);
    }
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-22, this.pos.y-8, 44, 16);
  }
  
  public Num _forward(){
    return null;
  }
  
  public Module createNew(PVector pos){
    return new ReaderModule(pos);
  }
}



public class GraphModule extends ReadOnlyModule{
  ArrayList<Num> values = new ArrayList<Num>();
  Double min = null;
  Double max = null;
  public GraphModule(PVector pos){
    super(pos);
    inputs.add(new InputPort(this, vec(-65, -70)));
    name = "Line Graph";
    shortDesc = "Graphs a module's output over time";
    longDesc = new String[]{
      "Given a number as an input,",
      "tracks the number's changes",
      "over time and produces a",
      "line graph for the value.",
      "",
      "Connect a loss function",
      "to this module to see the",
      "improvement of your model."
    };
    buttons.add(new Button(new PVector(50, -65), new PVector(20, 20), ICON_DELETE, this));
    
    println(min, max);
  }
  
  public void draw(){
    fill(0);
    stroke(COLOR_READER);
    strokeWeight(2);
    rect(this.pos.x-75, this.pos.y-70, 150, 140);
    
    rect(this.pos.x-70, this.pos.y-40, 140, 105);
    fill(COLOR_READER);
    textAlign(LEFT);
    textSize(11);
    String text = (hasAllInputs() && getInput(0).forward() != null) ? processDouble(getInput(0).forward().getValue(), 8, false) : "???";
    
    text("y = "+text, this.pos.x-55, this.pos.y-57);
    
    text("n = "+values.size(), this.pos.x-55, this.pos.y-45);
    drawAttachments(COLOR_READER);
    stroke(COLOR_READER);
    if (min != null && max != null && values.size() > 0){
      for (int i=0; i<values.size(); i++){
        circle(xPos(i, values.size()), yPos(values.get(i)), 2);
      }
      
      if (values.size() > 1){
        for (int i=0; i<values.size()-1; i++){
          line(xPos(i, values.size()), yPos(values.get(i)), xPos(i+1, values.size()), yPos(values.get(i+1)));
        }
      }
    }
    
  }
  
  public void update(){
    if (hasAllInputs() && getInput(0).forward() != null){
      if (!(getInput(0) instanceof LossModule) || ((LossModule)getInput(0)).isDone()){
        addValue(getInput(0).forward());
      }
    }
    
    if (buttons.get(0).isOn()){
      buttons.get(0).turnOff();
      values.clear();
      min = null;
      max = null;
    }
  }
  
  public void addValue(Num inNum){
    if (values.size() == 0 || inNum != values.get(values.size()-1)){
      double num = inNum.getValue();
      values.add(inNum);
      if (min == null || num < min){
        min = new Double(num);
      }
      if (max == null || num > max){
        max = new Double(num);
      }
    }
    
  }
  
  public float yPos(Num y){
    double MARGIN = 5;
    double MIN = -40+MARGIN;
    double MAX = 65-MARGIN; 
    if (max-min == 0){
      return this.pos.y+(float)(MIN + MAX)/2;
    }
    return (float)(this.pos.y+MAX - (MAX-MIN)*((y.getValue()-min)/(max-min)));
  }
  
  public float xPos(int x, int xMax){
    double MARGIN = 5;
    double MIN = -70+MARGIN;
    double MAX = 70-MARGIN; 
    return (float)(this.pos.x+(MIN) + (MAX-MIN)*((double)x/(double)(xMax-1)));
  }
  
  public boolean mouseIsIn(){
    return mouseInRect(this.pos.x-75, this.pos.y-70, 150, 140);
  }
  
  
  public Num _forward(){
    return null;
  }
  
  public Module createNew(PVector pos){
    return new GraphModule(pos);
  }
}
