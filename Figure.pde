class Figure{
  PVector [] locs;
  int type;
  int blockwidth;
  int blockheight;
  color clr;
  int timer;
  Figure(int t, int blockw, int blockh, color col){
    clr = col;
    blockheight = blockw;
    blockwidth = blockh;
    locs = new PVector[4];
    type = t;
    switch(t){
      case 0:
        locs[0] = new PVector(3*blockwidth,0);
        locs[1] = new PVector(4*blockwidth,0);
        locs[2] = new PVector(5*blockwidth,0);
        locs[3] = new PVector(6*blockwidth,0);
      break;  // line
      case 1: break;  // l
      case 2: break;  // rev l
      case 3: break;  // zig-zag
      case 4: break;  // rev zig-zag
      case 5: break;  // t 
      case 6: break;  // quad
    }
  }
  void update(){
    timer++;
    if(timer >= MAX_INT-1e-2){
      timer = 0;
    }
    if(timer % 100 == 0){
      for(int i = 0; i < locs.length; i++){
        locs[i].y += blockheight;
      } 
    }
    println(timer);
  }
  void show(){
    update();
    for(int i = 0; i < locs.length; i++){
      fill(clr);
      rect(locs[i].x, locs[i].y, blockwidth, blockheight);
    }
  }
}