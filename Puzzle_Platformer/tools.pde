class Tool{
  boolean mainSelected = false;
  int price;
  PImage icon;
  String desc;
  int hardness; // number of time the item can be used
  int used = 0;
  boolean selected = false;
  
  Tool(int p, PImage i, String d, int h){
    price = p;
    i.resize(50, 50);
    icon = i;
    desc = d;
    hardness = h;
  }
  
  void shopClicked(){
    shopBackground();
    for(int i = 0; i < itemShop.stock.size(); i ++){
      itemShop.stock.get(i).selected = false;
    }
    this.selected = true;
    explain();
    itemShop.update();
  }
  
  void explain(){
    shopBackground();
    label.setText(desc);
    priceLabel.setText("$"+ str(price));
    itemShop.update();
    displayBuyButton();
    outline(275, 70, size, 0);
    shopWindow.image(icon, 275, 70);
    
  }
  
  void displayBuyButton(){
    shopBackground();
    buyLabel.setText("buy");
    buyLabel.setVisible(true);
    outline(223, 70, 50, color(0, 255, 0));
  }
  
  
  void buyButtClicked(){
    if(selected){
      if(mouse.x > 223 && mouse.x < 273 && mouse.y > 300 && mouse.y < 350){
        if(itemShop.stock.contains(this)){
          if(emre.inventory.size() < emre.invSize){
            if(emre.money >= price){
              shopBackground();
              emre.money -= price;
              emre.addItemToInv(this);
              itemShop.stock.remove(this);
              itemShop.update();
              label.setText("");
              priceLabel.setText("");
              usesLabel.setText("");
              emre.displayInventory();
              buyLabel.setText("");
              redraw();
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
  
  void displayTool(int x, int y, int w, int h){
    icon.resize(w, h);
    image(this.icon, x, y);
  }
  
  void mainClicked(){
    for(int i = 0; i < emre.inventory.size(); i ++){
      emre.inventory.get(i).mainSelected = false;
    }
    
    this.mainSelected = true;
    redraw();
    emre.equipped_tool = this;
    //THIS IS RUN WHEN THIS IS CLICKED ON THE MAIN SKETCH WINDOW.
    //THIS IS RUN WHEN THIS IS CLICKED ON THE MAIN SKETCH WINDOW.
    //THIS IS RUN WHEN THIS IS CLICKED ON THE MAIN SKETCH WINDOW.
    //THIS IS RUN WHEN THIS IS CLICKED ON THE MAIN SKETCH WINDOW.
    //THIS IS RUN WHEN THIS IS CLICKED ON THE MAIN SKETCH WINDOW.
    //THIS IS RUN WHEN THIS IS CLICKED ON THE MAIN SKETCH WINDOW.
  }
  
  
}

//--------------------------------------------PICKAXE---------------------------------------------------------\\
class Pickaxe extends Tool{
  Pickaxe(int p, PImage i, String d, int u){
    super(p, i, d, u);
  }
  void explain(){
    usesLabel.setText("uses :" + str(hardness));
    super.explain();
  }
}

//----------------------------------------Block---------------------------------------------------
class Block extends Tool{
  Block(int p, PImage i, String d, int u){
    super(p, i, d, u);
  }
  void explain(){
    usesLabel.setText("blocks :" + str(hardness));
    super.explain();
  }
}

//-------------------------------pend-------------------------------
class Pend_block extends Tool{
  Pend_block(int p, PImage i, String d, int u){
    super(p, i, d, u);
  }
  void explain(){
    usesLabel.setText("uses :" + str(hardness));
    super.explain();
  }
  
}
