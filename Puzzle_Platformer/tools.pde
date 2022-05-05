class Tool {
  boolean mainSelected = false;
  int price;
  PImage icon;
  String desc;
  int uses; // number of time the item can be used
  boolean selected = false;

  Tool(int p, PImage i, String d, int h) {
    price = p;
    i.resize(50, 50);
    icon = i;
    desc = d;
    uses = h;
  }

  void shopClicked() {// checks if icon is clicked in shop window
    shopBackground();
    for (int i = 0; i < itemShop.stock.size(); i ++) {
      itemShop.stock.get(i).selected = false;
    }
    this.selected = true;
    explain();
    itemShop.update();
  }

  void explain() { // showcases the item in the shop window screen
    shopBackground();
    label.setText(desc);
    priceLabel.setText("$"+ str(price));
    itemShop.update();
    displayBuyButton();
    outline(275, 70, size, 0);
    shopWindow.image(icon, 275, 70);
  }

  void displayBuyButton() { // displays the buy button in the shop window screen
    shopBackground();
    buyLabel.setText("buy");
    buyLabel.setVisible(true);
    if (emre.money >= this.price) {
      outline(223, 70, 50, color(0, 255, 0));
      return;
    }
    outline(223, 70, 50, color(255, 0, 0));
  }


  void buyButtClicked() { // the buy button has been clciekd in the shop window screen
    if (selected) {
      if (mouse.x > 223 && mouse.x < 273 && mouse.y > 300 && mouse.y < 350) {
        if (itemShop.stock.contains(this)) {
          if (emre.inventory.size() < emre.invSize) {
            if (emre.money >= price) {
              shopBackground();
              emre.money -= price;
              emre.addItemToInv(this);
              itemShop.stock.remove(this);
              itemShop.update();
              label.setText("");
              priceLabel.setText("");
              usesLabel.setText("");
              emre.display_inventory_in_shop_window();
              buyLabel.setText("");
              redraw();
            } else {
              println("YOU ARE BROKE");
            }
          } else {
            println("YOUR INVENTORY IS FULL");
          }
        }
      }
    }
  }

  void displayTool(int x, int y, int w, int h) {
    icon.resize(w, h);
    image(this.icon, x, y);
  }

  void mainClicked() {
    for (int i = 0; i < emre.inventory.size(); i ++) {
      emre.inventory.get(i).mainSelected = false;
    }

    this.mainSelected = true;
    redraw();
    emre.equipped_tool = this;
  }
  void use() {
    uses -= 1;
  }
}

//--------------------------------------------PICKAXE---------------------------------------------------------\\
class Pickaxe extends Tool {
  Pickaxe() {
    super(20, loadImage("images/pick.png"), "A better pickaxe.", 10);
  }
  void explain() {
    usesLabel.setText("uses :" + str(uses));
    super.explain();
  }
}

//----------------------------------------Block---------------------------------------------------
class Block extends Tool {
  Block(int p, PImage i, String d, int u) {
    super(p, i, d, u);
  }
  void explain() {
    usesLabel.setText("blocks :" + str(uses));
    super.explain();
  }
}

//-------------------------------pend-------------------------------
class Pend_block extends Tool {
  Pend_block() {
    super(40, loadImage("images/pend.png"), "A pendulum", 1);
  }
  void explain() {
    usesLabel.setText("uses :" + str(uses));
    super.explain();
  }
}

class BouncyBlock extends Block {
  BouncyBlock() {
    super(30, loadImage("images/diamond.png"), "BLUE BOUNCY BLOCK.", 10);
  }
  void explain() {
    usesLabel.setText("blocks :" + str(uses));
    super.explain();
  }
}  
class NormalBlock extends Block {
  NormalBlock() {
    super(10, loadImage("images/dirt.png"), "Literally a dirt block what more can I say?", 10);
  }
  void explain() {
    usesLabel.setText("blocks :" + str(uses));
    super.explain();
  }
}  
