class Tool{
  int price;
  PImage icon;
  String desc;
  int uses;
  Tool(int p, PImage i, String d, int u){
    price = p;
    i.resize(50, 50);
    icon = i;
    desc = d;
    uses = u;
  }
  void clicked(){
    itemShop.displayIcons();
    explain();
  }
  
  void explain(){
    label.setText(desc);
    itemShop.displayIcons();
    outline(275, 50, size, 0);
    shopWindow.image(icon, 275, 50);
  }
  
}

//--------------------------------------------PICKAXE---------------------------------------------------------\\
class Pickaxe extends Tool{
  Pickaxe(int p, PImage i, String d, int u){
    super(p, i, d, u);
  }
  
}

class Block extends Tool{
  Block(int p, PImage i, String d, int u){
    super(p, i, d, u);
  }
  
}
