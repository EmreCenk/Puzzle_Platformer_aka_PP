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
    priceLabel.setText("$"+ str(price));
    itemShop.update();
    displayBuyButton();
    outline(275, 70, size, 0);
    shopWindow.image(icon, 275, 70);
  }
  
  void displayBuyButton(){
    buyLabel.setText("buy");
    outline(223, 70, 50, color(0, 255, 0));
    
  }
  
  void buyButtClicked(){
    if(selected){
      if(mouse.x > 223 && mouse.x < 273 && mouse.y > 300 && mouse.y < 350){
        if(itemShop.stock.contains(this)){
          if(emre.inventory.size() < emre.invSize){
            if(emre.money >= price){
              emre.money -= price;
              emre.addItemToInv(this);
              itemShop.stock.remove(this);
              itemShop.update();
              label.setText("");
              priceLabel.setText("");
            }else{
              println("YOU ARE BROKE");
            }
          }else{
            println("YOUR INVENTORY IS FULL");
          }
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
