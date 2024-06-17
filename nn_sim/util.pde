
// Function wrapper
interface Function{
  public void run();
}

// Shortened `new PVector()`
public PVector vec(float x, float y){
  return new PVector(x, y);
}

// Double to string processors
public String processDouble(double n){
  return processDouble(n, 6, true);
}

public String processDouble(double n, int chars, boolean alwaysShowSign){
  
  String result = doubleToString(Math.round(n * Math.pow(10, chars-2))/Math.pow(10, chars-2));
  if (n >= 0){
    result = (alwaysShowSign?"+":"") + result;
  }
  if (result.length() > chars){
    result = result.substring(0, chars);
  }
  //return result.substring(0, chars).replace(" ", "0");
  return String.format("%-"+chars+"s", result).replace(" ", "0");
}

public String doubleToString(double n){
  return String.format("%.9f", n);
}


public String numArrToStr(Num[] arr){
  String result = "[ ";
  for (int i=0; i<arr.length; i++){
    result += "Num(" + arr[i].value + ")";
    if (i < arr.length-1){
      result += ", ";
    }
  }
  result += " ]";
  return result;
}


// Topological sort algorithm from GPT-3.5-Turbo (sry im tired)
public static List<Num> topologicalSort(Num node) {
    Set<Num> visited = new HashSet<>();
    Stack<Num> stack = new Stack<>();

    topologicalSortUtil(node, visited, stack);

    List<Num> sorted = new ArrayList<>();
    while (!stack.isEmpty()) {
        sorted.add(stack.pop());
    }
    return sorted;
}

private static void topologicalSortUtil(Num node, Set<Num> visited, Stack<Num> stack) {
    visited.add(node);

    for (Num child : node.children) {
        if (!visited.contains(child)) {
            topologicalSortUtil(child, visited, stack);
        }
    }

    stack.push(node);
}


public List<Num> reversed(List<Num> l){
  List<Num> result = new ArrayList<Num>();
  for (Num n : l){
    result.add(0, n);
  }
  return result;
}


// Mathematical functions
public Num meanSquaredError(ArrayList<Num> yPred, ArrayList<Num> y){
  if (yPred.size() != y.size()){
    println(CATASTROPHIC_LETHAL_ERROR_MESSAGE);
    exit();
  }
  Num sum = new Num(0);
  for (int i=0; i<yPred.size(); i++){
    sum = sum.add((yPred.get(i).sub(y.get(i))).pow(2));
  }
  return sum.div(new Num(yPred.size()));
}

public Num mean(ArrayList<Num> nums){
  Num sum = new Num(0);
  for (int i=0; i<nums.size(); i++){
    sum = sum.add(nums.get(i));
  }
  return sum.div(new Num(nums.size()));
}


// ArrayList utilities
public <T> boolean removeItem(ArrayList<T> arr, T item){
  for (int i=0; i<arr.size(); i++){
    if (item == arr.get(i)){
      arr.remove(i);
      return true;
    }
  }
  return false;
}

public Num sum(ArrayList<Num> nums){
  Num result = new Num(0);
  for (int i=0; i<nums.size(); i++){
    result.add(nums.get(i));
  }
  return result;
}


public boolean posInRect(float x, float y, float rx, float ry, float rw, float rh){
  return x > rx && x < rx+rw && y > ry && y < ry+rh;
}

public boolean mouseInRect(float x, float y, float w, float h){
  return mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h;
}


// Lines
public void flowingLine(float x1, float y1, float x2, float y2){
  float speed = 3; // Lower number --> more speed
  dottedLine(x1, y1, x2, y2, (((float)frameCount/20)%speed)/dist(x1, y1, x2, y2)*20/speed);
}

public void dottedLine(float x1, float y1, float x2, float y2){
  dottedLine(x1, y1, x2, y2, 0);
}

public void dottedLine(float x1, float y1, float x2, float y2, float start){
  float dotLength = 10;
  float d = dist(x1, y1, x2, y2);
  float unitx = (x2-x1)/d;
  float unity = (y2-y1)/d;
  float at = 0;
  boolean drawLine = true;
  if (start-dotLength/d > 0){
    line(x1, y1, x1 + unitx*(start-dotLength/d)*d, y1 + unity*(start-dotLength/d)*d);
  }
  
  for (float i=start; i<=1; i+=dotLength/d){
    if (drawLine){
      float x = x1 + unitx*i*d;
      float y = y1 + unity*i*d;
      if ((x1 < x2 && x+dotLength*unitx >= x2) || (x1 > x2 && x+dotLength*unitx <= x2)){
        line(x, y, x2, y2);
      }else{
        line(x, y, x+dotLength*unitx, y + dotLength*unity);
      }
    }
    drawLine = !drawLine;
  }
}
