class Shop{
  ArrayList<Tool> stock = new ArrayList<Tool> ();
  Shop(){
    
  }
  void opened(){
    open = !open;
    shopWindow.setVisible(open);
    this.displayIcons();
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
    temp.resize(50, 50);
    shopWindow.image(temp, 200, 0);
    moneyLabel.setText(str(emre.money));
    for( int i = 0 ; i < stock.size(); i++){ 
      outline(x, y, size, 0);
      shopWindow.image(stock.get(i).icon, x, y);
      
      x += size;
      if(i%4 == 3){
        x = 0;
        y += size;
      }
    }  
  }
  
  void update(){
    shopBackground();
    buyLabel.setText("");
    displayIcons();
  }
  
  void itemBought(Tool a){
    stock.remove(a);
    update();
  }

}
  
  
