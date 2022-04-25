class Shop{
  ArrayList<Tools> stock = new ArrayList<Tools> ();
  Shop(){
    
  }
  void opened(){
    open = !open;
    shopWindow.setVisible(open);
  }
  
  void addToStock(Tools a){
    this.stock.add(a);
  }
  
  void displayIcons(){
    int x = 0;
    int y = 0;
    for(int i = 0; i < stock.size(); i ++){
      win_draw(stock.get(i).icon, x, y);
    }
    
  }
  
  
}
