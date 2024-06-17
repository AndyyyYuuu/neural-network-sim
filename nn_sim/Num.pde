/* Object-oriented autograd algorithm
 * originally written in Python by Andrej Karpathy.
 * Translated to Java Processing by: me
 */

public class Num{
  private double value;
  private double grad = 0;
  private String operator;
  private Num[] children = new Num[0];
  public boolean isParam = false;
  public Function backward = () -> {
    ;
  }; 
  
  public Num(double value, Num[] children, String operator){
    this(value);
    this.children = children; 
    this.operator = operator;
  }
  
  public Num(double value){
    this.value = value; 
  }
  
  public void makeParam(){
    this.isParam = true;
  }
  
  public Num add(Num other){
    Num out = new Num(this.getValue() + other.getValue(),
                      new Num[]{this, other},
                      "+");
    Function backward = () -> {
      this.grad += 1.0 * out.grad;
      other.grad += 1.0 * out.grad; 
    };
    out.setBackward(backward);
    return out; 
  }
  
  public Num sub(Num other){
    return this.add(other.mult(new Num(-1)));
  }
  
  public Num mult(Num other){
    Num out = new Num(this.getValue() * other.getValue(),
                      new Num[]{this, other},
                      "*");
    Function backward = () -> {
      this.grad += other.value * out.grad;
      other.grad += this.value * out.grad; 
    };
    out.setBackward(backward);
    return out; 
  }
  
  public Num pow(double other){
    Num out = new Num(Math.pow(this.getValue(), other),
                      new Num[]{this},
                      "^"+Double.toString(other));
    Function backward = () -> {
      this.grad += other * Math.pow(this.value, other-1) * out.grad;
    };
    out.setBackward(backward);
    return out; 
  }
  
  public Num div(Num other){
    return this.mult(other.pow(-1));
  }
  
  public Num tanh(){
    Num out = new Num(Math.tanh(this.getValue()), new Num[]{this}, "tanh");
    Function backward = () -> {
      this.grad += (1 - Math.pow(out.getValue(), 2.0)) * out.grad;
    };
    out.setBackward(backward);
    return out; 
  }
  
  public Num sin(){
    Num out = new Num(Math.sin(this.getValue()), new Num[]{this}, "sin");
    Function backward = () -> {
      this.grad += Math.cos(out.getValue()) * out.grad;
    };
    out.setBackward(backward);
    return out; 
  }
  
  public double getValue(){
    return this.value;
  }
  
  public void setValue(double v){
    this.value = v;
  }
  
  public void setBackward(Function backward){
    this.backward = backward; 
  }
  
  public void backward(){
    this.grad = 1.0; 
    
    // Backpropagates all previous nodes in order of depth
    for (Num node: (topologicalSort(this))){
      node.backward.run();
    }
    
  }

  public void _descend(double stepSize){
    if (this.isParam){
      this.value -= stepSize * this.grad;
    }
  }
  
  public void descend(double stepSize){
    // Gradient descent on all nodes
    for (Num node: (topologicalSort(this))){
      node._descend(stepSize);
    }
  }
  
  public void _zeroGrad(){
    this.grad = 0;
  }
  
  public void zeroGrad(){
    for (Num node: (topologicalSort(this))){
      node._zeroGrad();
    }
  }
  
  public String toString(){
    return "Num{\n\tvalue = " + value + 
           ";\n\tgrad = " + grad +
           ";\n\tchildren = " + numArrToStr(children) + " (" + operator + ")" + 
           ";\n}";
  }
}
