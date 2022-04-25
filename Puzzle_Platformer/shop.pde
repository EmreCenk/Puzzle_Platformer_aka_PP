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
    int size = 50;
    int x = 0;
    int y = 0;
    for( int i = 0 ; i < stock.size(); i++){
      img = new GImageButton(shopWindow, x, y, size, size, new String[] { stock.get(i).iconPath } );
      x += size;
      if(i%4 == 3){
        x = 0;
        y += size;
      }
    }  
  }
  

}
  
  
