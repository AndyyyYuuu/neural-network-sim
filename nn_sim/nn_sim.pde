import java.util.*;

String CATASTROPHIC_LETHAL_ERROR_MESSAGE = "DOUBLE DOUBLE TOIL AND TROUBLE FIRE BURN AND CAULDRON BUBBLE!";
ArrayList<Module> modules = new ArrayList<Module>();
ArrayList<Port> ports = new ArrayList<Port>();
ArrayList<Connector> connectors = new ArrayList<Connector>();
Module grabbedModule;

// Pretend static methods (screw Processing for not having static methods) that also serve as the buttons
MultModule multModule = new MultModule(new PVector(30, 30));
NeuronModule neuronModule = new NeuronModule(new PVector(100, 30));
Module[] moduleTypes = new Module[]{
  multModule, 
  neuronModule
};

int START = 0;
int PLAY = 1;
int mode = PLAY;

void setup(){
  size(800, 640);
  Num a = new Num(5);
  Num b = new Num(4);
  Num c = new Num(3);
  Num d = a.mult(b);
  Num e = d.mult(c);
  Num l = e.mult(c);
  l.backward();
  println(a);
  println(b);
  println(c);
  println(d);
  println(e);
  println(l);
}

void mousePressed(){
  if (mode == PLAY){
    for (int i=0; i<moduleTypes.length; i++){
      if (moduleTypes[i].mouseIsIn()){
        grabbedModule = moduleTypes[i].createNew();
        grabbedModule.grab();
      }
    }
    
    for (int i=0; i<modules.size(); i++){
      if (modules.get(i).mouseIsIn()){
        grabbedModule = modules.get(i).grab();
      }
    }
  }
}

void mouseReleased(){
  if (mode == PLAY){
    if (grabbedModule != null){
      modules.add(grabbedModule);
      grabbedModule = null;
    }
  }
}

void draw(){
  background(0);
  if (mode == PLAY){
    for (int i=0; i<moduleTypes.length; i++){
      moduleTypes[i].show();
    }

    for (Module module: modules){
      module.show();
    }
    if (grabbedModule != null){
      grabbedModule.show();
      grabbedModule.followMouse();
    }
  }
}
