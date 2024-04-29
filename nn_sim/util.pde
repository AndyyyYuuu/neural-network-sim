
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

public Num sum(ArrayList<Num> nums){
  Num result = new Num(0);
  for (int i=0; i<nums.size(); i++){
    result.add(nums.get(i));
  }
  return result;
}

public void flowingLine(float x1, float y1, float x2, float y2){
  dottedLine(x1, y1, x2, y2, (((float)frameCount/20)%3)/dist(x1, y1, x2, y2)*6);
}

public void dottedLine(float x1, float y1, float x2, float y2){
  dottedLine(x1, y1, x2, y2, 0);
}

public void dottedLine(float x1, float y1, float x2, float y2, float start){
  float d = dist(x1, y1, x2, y2);
  float nx = (x2-x1)/d;
  float ny = (y2-y1)/d;
  float at = 0;
  boolean drawLine = true;
  for (float i=start; i<=1; i+=20/d){
    //if (drawLine){
    line(x1 + nx * i * d, y1 + ny * i * d, x1 + nx * (i+10/d) * d, y1 + ny * (i+10/d) * d);
    //}
  }
  
}

public boolean mouseInRect(float x, float y, float w, float h){
  return mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h;
}

// Shortened `new PVector()`
public PVector vec(float x, float y){
  return new PVector(x, y);
}
