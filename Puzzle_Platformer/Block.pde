class PlayBlock extends Platform {
   PlayBlock (PVector center_, float height_, color colour_){
   super(center_, height_, height_, colour_); 
   
    PVector block1 = new PVector(this.coordinate.x - height_, this.coordinate.y - height_);
    //PVector block2 = new PVector(this.coordinate.x + width_/2, this.coordinate.y + height_/2);
    
    stroke(250,0,0);
    fill(250,0,0);
    rect(block1.x, block1.y, height_, height_);
    


}}
