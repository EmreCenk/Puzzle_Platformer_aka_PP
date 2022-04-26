class Tool{
  int price;
  PImage icon;
  String desc;
  Tool(int p, PImage i, String d){
    price = p;
    i.resize(50, 50);
    icon = i;
    desc = d;
  }
  void clicked(){
    
  }
  void explain(){
    label.setText(desc);
  }
  
}

//--------------------------------------------PICKAXE---------------------------------------------------------\\
class Pickaxe extends Tool{
  
  int uses;
  Pickaxe(int u, int p, PImage i, String d){
    super(p, i, d);
    this.uses = u;
  }
  
  void explain(){
    super.explain();
    itemShop.displayIcons();
    outline(275, 50, size);
    shopWindow.image(icon, 275, 50);
    
  }
  
  void clicked(){
    explain();
    
  }
  
  
}
