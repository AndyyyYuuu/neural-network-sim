
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
