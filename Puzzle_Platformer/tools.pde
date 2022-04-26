class Tool{
  int price;
  PImage icon;
  String desc;
  int uses;
  boolean selected = false;
  
  Tool(int p, PImage i, String d, int u){
    price = p;
    i.resize(50, 50);
    icon = i;
    desc = d;
    uses = u;
  }
  
  void clicked(){
    for(int i = 0; i < itemShop.stock.size(); i ++){
      itemShop.stock.get(i).selected = false;
    }
    selected = true;
    itemShop.update();
    explain();
  }
  
  void explain(){
    label.setText(desc);
    itemShop.update();
    displayBuyButton();
    outline(275, 50, size, 0);
    shopWindow.image(icon, 275, 50);
  }
  
  void displayBuyButton(){
    println("displaying button");
    buyLabel.setText("buy");
    outline(223, 50, 50, color(0, 255, 0));
    
  }
  
  void buyButtClicked(){
    println("");
    println("buy clicked");
    if(selected){
      if(mouse.x > 223 && mouse.x < 273 && mouse.y > 280 && mouse.y < 330){
        if(itemShop.stock.contains(this)){
          itemShop.stock.remove(this);
          itemShop.update();
          label.setText("");
        }
      }
    }
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
