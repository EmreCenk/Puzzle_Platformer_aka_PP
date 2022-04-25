class Tool{
  int price;
  String iconPath;
  Tool(int p, String a){
    price = p;
    iconPath = a;
  }
  
  
}

//--------------------------------------------PICKAXE---------------------------------------------------------\\
class Pickaxe extends Tool{
  
  int uses;
  Pickaxe(int u, int p){
    super(p, "images/pick.png");
    this.uses = u;
  }
  
  
}
