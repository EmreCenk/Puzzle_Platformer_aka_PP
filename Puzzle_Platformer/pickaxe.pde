class Pickaxe extends Tool{
  
  int uses;
  Pickaxe(int p, int u, String pa){
    icon = loadImage(pa);
    icon.resize(200, 200);
    this.path = pa;
    this.price = p;
    this.uses = u;
  }
  
  
}
