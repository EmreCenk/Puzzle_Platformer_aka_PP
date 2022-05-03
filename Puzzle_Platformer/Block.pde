class PlayBlock extends Platform {
  
  float price;
  PlayBlock (PVector center_, float height_, color colour_){
    super(center_, height_, height_, colour_); 
    this.effected_by_gravity = true;
    this.bounciness = DEFAULT_PLAYBLOCK_BOUNCE;
  }
  

}
