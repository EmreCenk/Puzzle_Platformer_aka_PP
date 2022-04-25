class Shop{
  ArrayList<Tool> stock = new ArrayList<Tool> ();
  Shop(){
    
  }
  void opened(){
    open = !open;
    shopWindow.setVisible(open);
  }
  
  void addToStock(Tool a){
    this.stock.add(a);
  }
  
  void displayIcons(){
    int x = 0;
    int y = 0;
    for(int i = 0; i < stock.size(); i ++){
      //win_draw(loadImage(stock.get(i).path), x, y);
    }
    
  }
  
  
}
