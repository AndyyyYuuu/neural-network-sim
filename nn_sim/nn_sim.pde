import java.util.*;

PFont font;

String CATASTROPHIC_LETHAL_ERROR_MESSAGE = "DOUBLE DOUBLE TOIL AND TROUBLE FIRE BURN AND CAULDRON BUBBLE!";
ArrayList<Module> modules = new ArrayList<Module>();
ArrayList<Port> ports = new ArrayList<Port>();
ArrayList<Connector> connectors = new ArrayList<Connector>();
Module grabbedModule;
Connector grabbedConnector;
Dataset circleData = new CircleDataset(80, 20);
// Pretend static methods (screw Processing for not having static methods) that also serve as the buttons
AddModule addModule = new AddModule(new PVector(50, 30));
MultModule multModule = new MultModule(new PVector(150, 30));
NeuronModule neuronModule = new NeuronModule(new PVector(450, 30));
ParamModule paramModule = new ParamModule(new PVector(250, 30));
DataModule dataModule = new DataModule(new PVector(550, 30));
LossModule lossModule = new LossModule(new PVector(650, 30), 40);
OptimModule optimModule = new OptimModule(new PVector(750, 30));
Module[] moduleTypes = new Module[]{
  addModule,
  multModule, 
  neuronModule, 
  paramModule, 
  dataModule,
  lossModule,
  optimModule
};

int START = 0;
int PLAY = 1;
int mode = PLAY;

void setup(){
  size(800, 600);
  fullScreen();
  pixelDensity(2);
  font = createFont("font/JetBrainsMono-VariableFont_wght.ttf", 32);
  textFont(font);
  Num a = new Num(5);
  Num b = new Num(4);
  Num c = new Num(3);
  Num d = a.mult(b);
  Num e = d.mult(c);
  Num l = e.mult(c);
  l.backward();
  /*println(a);
  println(b);
  println(c);
  println(d);
  println(e);
  println(l);*/
}

void keyPressed(){
  if (key == 'l'){
    for (Module m: modules){
      if (m instanceof LossModule){
        println(m.attemptForward());
      }
    }
  }
}

void mousePressed(){
  if (mode == PLAY){
    for (int i=0; i<moduleTypes.length; i++){
      if (moduleTypes[i].mouseIsIn()){
        grabbedModule = moduleTypes[i].createNew();
        grabbedModule.grab();
        
        return;
      }
    }
    
    
    
    for (int i=0; i<ports.size(); i++){
      if (ports.get(i).mouseIsIn()){
        if (grabbedConnector != null){
          if (grabbedConnector.connect(ports.get(i))){
            connectors.add(grabbedConnector);
            grabbedConnector = null;
            return;
          }
          
        }else{
          grabbedConnector = new Connector(ports.get(i));
          ports.get(i).occupied = true;
          //connectors.add(grabbedConnector);
          print("!");
          return;
        }
      }
    }
    
    grabbedConnector = null;
    
    for (int i=0; i<modules.size(); i++){
      if (modules.get(i).mouseIsIn()){
        grabbedModule = modules.get(i).grab();
        return;
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
    
    for (Connector connector: connectors){
      connector.show();
    }
    if (grabbedConnector != null){
      grabbedConnector.show();
    }
    
    if (grabbedModule != null){
      grabbedModule.show();
      grabbedModule.followMouse();
    }
  }
}
