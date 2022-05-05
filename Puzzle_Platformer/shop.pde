class Shop{
  ArrayList<Tool> stock = new ArrayList<Tool> ();
  Shop(){
    
  }
  void opened(){
    open = !open;
    shopWindow.setVisible(open);
    shopWindow.fill(255);
    
    displayIcons();
    update();
  }
  
  void addToStock(Tool a){
    this.stock.add(a);
  }
  
  void displayIcons(){
<<<<<<< HEAD
    println(emre);
=======
    emre.display_inventory_in_shop_window();
>>>>>>> 65a9f5545473a3cd876ee95ff4b8cbdadc9b894b
    int x = 0;
    int y = 0;
    PImage temp = loadImage("images/money.png");
    temp.resize(size, size);
    shopWindow.image(temp, 200, 0);
    
    PImage tempShop;
    moneyLabel.setText(str(emre.money));
    for( int i = 0 ; i < stock.size(); i++){ 
      outline(x, y, size, 0);
      tempShop = stock.get(i).icon;
      tempShop.resize(size, size);
      shopWindow.image(tempShop, x, y);
      
      x += size;
      if(i%4 == 3){
        x = 0;
        y += size;
      }
    }  
  }
  
  void update(){
    displayIcons();
  }
  
  void itemBought(Tool a){
    stock.remove(a);
    update();
  }

}
  
  
