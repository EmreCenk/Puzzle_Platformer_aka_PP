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
    emre.displayInventory();
    int x = 0;
    int y = 0;
    PImage temp = loadImage("images/money.png");
    temp.resize(size, size);
    shopWindow.image(temp, 200, 0);
    moneyLabel.setText(str(emre.money));
    for( int i = 0 ; i < stock.size(); i++){ 
      outline(x, y, size, 0);
      PImage tempShop = stock.get(i).icon;
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
  
  
