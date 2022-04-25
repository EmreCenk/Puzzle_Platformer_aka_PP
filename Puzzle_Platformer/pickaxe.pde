class Pickaxe extends Tools{
  
  int uses;
  
   Pickaxe(int p, int u){
    icon = loadImage("pick.png");
    icon.resize(200, 200);
    this.price = p;
    this.uses = u;
  }
  
  
}
