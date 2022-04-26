class Shop{
  ArrayList<Tool> stock = new ArrayList<Tool> ();
  Shop(){
    
  }
  void opened(){
    open = !open;
    shopWindow.setVisible(open);
    this.displayIcons();

}
  
  void addToStock(Tool a){
    this.stock.add(a);
  }
  
  void displayIcons(){
    updateShopWindow();
    int x = 0;
    int y = 0;
    for( int i = 0 ; i < stock.size(); i++){ 
      outline(x, y, size);
      shopWindow.image(stock.get(i).icon, x, y);
      
      x += size;
      if(i%4 == 3){
        x = 0;
        y += size;
      }
    }  
  }
  

}
  
  
