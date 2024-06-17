Icon ICON_FORWARD = new Icon("icon/forward.png");
Icon ICON_REFRESH = new Icon("icon/refresh.png");
Icon ICON_DESCEND = new Icon("icon/descend.png");
Icon ICON_CALCULATE = new Icon("icon/calculate.png");
Icon ICON_BACKWARD = new Icon("icon/backward.png");
Icon ICON_ZERO = new Icon("icon/zero.png");
Icon ICON_OPEN = new Icon("icon/folder_open.png");
Icon ICON_CLOSED = new Icon("icon/folder_closed.png");
Icon ICON_DELETE = new Icon("icon/delete.png");
Icon ICON_HELP = new Icon("icon/help.png");

// Icon object for buttons and such
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

  public void draw(float x, float y, color c, float size){
    pushMatrix();
    
    tint(c, 255);
    imageMode(CENTER);
    image(img, x, y, size, size);
    
    popMatrix();
    
  }
  
  public void draw(float x, float y, color c){
    draw(x, y, c, 16);
  }
}
