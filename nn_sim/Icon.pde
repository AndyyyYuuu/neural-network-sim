Icon ICON_FORWARD = new Icon("icon/forward.png");
Icon ICON_REFRESH = new Icon("icon/refresh.png");
Icon ICON_DESCEND = new Icon("icon/descend.png");
Icon ICON_CALCULATE = new Icon("icon/calculate.png");
Icon ICON_BACKWARD = new Icon("icon/backward.png");
Icon ICON_ZERO = new Icon("icon/zero.png");

public class Icon{
  PImage img;
  String path;
  public Icon(String path){
    this.path = path;
    
    
  }
  
  public void load(){
    img = loadImage(path);
  }
  
  public boolean isLoaded(){
    return img != null;
  }

  public void draw(float x, float y, color c){
    pushMatrix();
    
    tint(c, 255);
    imageMode(CENTER);
    image(img, x, y, 16, 16);
    
    
    popMatrix();
    
  }
}
