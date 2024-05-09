Icon ICON_REFRESH = new Icon("icon/refresh.png");

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
