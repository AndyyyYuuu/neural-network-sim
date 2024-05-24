import java.util.*;

PFont font;

String CATASTROPHIC_LETHAL_ERROR_MESSAGE = "DOUBLE DOUBLE TOIL AND TROUBLE FIRE BURN AND CAULDRON BUBBLE!";
ArrayList<Module> modules = new ArrayList<Module>();
ArrayList<Port> ports = new ArrayList<Port>();
ArrayList<Connector> connectors = new ArrayList<Connector>();
ArrayList<Button> buttons = new ArrayList<Button>();
ArrayList<Slider> sliders = new ArrayList<Slider>();
Module grabbedModule;
Connector grabbedConnector;
Dataset circleData = new CircleDataset(80, 20);
// Pretend static methods (screw Processing for not having static methods) that also serve as the buttons
AddModule addModule;
MultModule multModule;
TanhModule tanhModule;
SinModule sinModule;
NeuronModule neuronModule;
ParamModule paramModule;
DataModule dataModule;
MeanModule meanModule;
LossModule lossModule;
OptimModule optimModule;
ReaderModule readerModule;
NumModule numModule;
GraphModule graphModule;
Module[] moduleTypes;
MenuFolder[] menuFolders;

int START = 0;
int PLAY = 1;
int mode = PLAY;

void setup(){
  size(1400, 720);
  //fullScreen();
  pixelDensity(2);
  font = createFont("font/JetBrainsMono-VariableFont_wght.ttf", 32);
  textFont(font);
  strokeWeight(2);
  circleData = new CircleDataset(80, 20);
  
  ICON_OPEN.load();
  ICON_CLOSED.load();
  
  // Pretend static methods (screw Processing for not having static methods) that also serve as the buttons
  addModule = new AddModule(new PVector(60, 30));
  multModule = new MultModule(new PVector(120, 30));
  tanhModule = new TanhModule(new PVector(180, 30));
  sinModule = new SinModule(new PVector(240, 30));
  paramModule = new ParamModule(new PVector(350, 30));
  neuronModule = new NeuronModule(new PVector(450, 30));
  dataModule = new DataModule(new PVector(550, 30));
  lossModule = new LossModule(new PVector(650, 30), 80);
  optimModule = new OptimModule(new PVector(750, 30));
  readerModule = new ReaderModule(new PVector(850, 30));
  numModule = new NumModule(new PVector(0, 0));
  graphModule = new GraphModule(new PVector(0, 0));
  meanModule = new MeanModule(new PVector(0, 0), 80);
  
  menuFolders = new MenuFolder[]{
    new MenuFolder("Simple Operations", new Module[]{addModule, multModule, sinModule, tanhModule}, COLOR_OP),
    new MenuFolder("Advanced Operations", new Module[]{neuronModule, meanModule, lossModule}, COLOR_NEURAL),
    new MenuFolder("Data Sources", new Module[]{dataModule, numModule}, COLOR_DATA),
    new MenuFolder("Optimization", new Module[]{optimModule, paramModule}, COLOR_OPTIM),
    new MenuFolder("Reading & Analysis", new Module[]{readerModule, graphModule}, COLOR_READER),
  };
}

void mousePressed(){
  if (mode == PLAY){
    
    for (MenuFolder m: menuFolders){
      Module clickResult = m.click();
      if (clickResult != null){
        grabbedModule = clickResult;
        grabbedModule.grab();
        return;
      }
    }
    
    for (Button b: buttons){
      if (b.mouseDown()){
        return;
      }
    }
    
    for (Slider s: sliders){
      if (s.mouseDown()){
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
    
    for (Slider s: sliders){
      s.mouseUp();
    }
  }
}

void draw(){
  background(0);
  if (mode == PLAY){

    for (Module module: modules){
      module.show();
    }
    
    for (Connector connector: connectors){
      connector.show();
    }
    if (grabbedConnector != null){
      grabbedConnector.show();
    }
    
    float yAt = 50;
    for (MenuFolder m: menuFolders){
      yAt += m.draw(yAt);
    }
    
    if (grabbedModule != null){
      grabbedModule.show();
      grabbedModule.followMouse();
    }
    
    for (Button b: buttons){
      b.tick();
    }
    
    for (Slider s: sliders){
      s.tick();  // Stick
    }
    
    
  }
}
