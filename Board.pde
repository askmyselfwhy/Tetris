class Board{
  int sk;
  public int blockwidth;
  public int blockheight;
  int [][] grid;
  public int [][] fig;
  public int ftype;
  int turnP;
  boolean speedUp = false;
  Board(int k){
    blockwidth = width/k;
    blockheight = height/k;
    sk = k;
    grid = new int[k][k];
    fig = new int[2][4];
    for(int i = 0; i < k; i++){
      for(int j = 0; j < k; j++){
        grid[i][j] = 0; 
      }
    }
  }

  void show(){
    stroke(0);
    
    if(speedUp){
      updateFigure();
      speedUp = false;
    }
    if(frameCount % 45 == 0){
      updateFigure();
    }
    for(int i = 0; i < sk; i++){
      for(int j = 0; j < sk; j++){
        if(grid[i][j] == 1){
          fill(0);
          stroke(255);
          rect(j*blockwidth,i*blockheight,blockwidth,blockheight);
        }
        else if(grid[i][j] == 2){
          fill(0,200,128);
          stroke(255);
          rect(j*blockwidth,i*blockheight,blockwidth,blockheight);
        }
        else{
          fill(255);
          stroke(0);
          rect(j*blockwidth,i*blockheight,blockwidth,blockheight);
        }
      }
    }
  }
  
  void check(){
    boolean [] lines = new boolean[sk];
    for(int i = 0; i < sk; i++){
      boolean isRowCreated = true;
      for(int j = 0; j < sk; j++){
        if(grid[i][j] == 0){
          isRowCreated = false;
          break;
        }
      }
      if(isRowCreated){
        lines[i] = true;  
      }
    }
    for(int k = 0; k < lines.length; k++){
      if(lines[k] == true){
        for(int i = k; i > 0; i--){
          for(int j = 0; j < sk; j++){
            grid[i][j] = grid[i-1][j]; 
          }
        }
        for(int i = 0; i < sk; i++){
          grid[0][i] = 0;  
        }
      }
    }
  }
  
  void createFigure(){
    float n = random(0,7);
    int type = floor(n);
    println(n + " " + type);
    turnP = 0;
    ftype = type;
    switch(type){
      case 0:
        fig[0][0] = 3;
        fig[1][0] = 0;
        
        fig[0][1] = 4;
        fig[1][1] = 0;
        
        fig[0][2] = 5;
        fig[1][2] = 0;
        
        fig[0][3] = 6;
        fig[1][3] = 0;
      break;  // line
      case 1:
        fig[0][0] = 3;
        fig[1][0] = 0;
        
        fig[0][1] = 3;
        fig[1][1] = 1;
        
        fig[0][2] = 4;
        fig[1][2] = 1;
        
        fig[0][3] = 5;
        fig[1][3] = 1;
      break;  // l
      case 2:
        fig[0][0] = 5;
        fig[1][0] = 1;
        
        fig[0][1] = 5;
        fig[1][1] = 2;
        
        fig[0][2] = 4;
        fig[1][2] = 2;
        
        fig[0][3] = 3;
        fig[1][3] = 2;
      break;  // rev l
      case 3:
        fig[0][0] = 4;
        fig[1][0] = 0;
        
        fig[0][1] = 5;
        fig[1][1] = 0;
        
        fig[0][2] = 3;
        fig[1][2] = 1;
        
        fig[0][3] = 4;
        fig[1][3] = 1;
      break;  // zig-zag
      case 4:
        fig[0][0] = 3;
        fig[1][0] = 0;
        
        fig[0][1] = 4;
        fig[1][1] = 0;
        
        fig[0][2] = 4;
        fig[1][2] = 1;
        
        fig[0][3] = 5;
        fig[1][3] = 1;
      break;  // rev zig-zag
      case 5:
        fig[0][0] = 4;
        fig[1][0] = 0;
        
        fig[0][1] = 3;
        fig[1][1] = 1;
        
        fig[0][2] = 4;
        fig[1][2] = 1;
        
        fig[0][3] = 5;
        fig[1][3] = 1;
      break;  // t 
      case 6:
        fig[0][0] = 4;
        fig[1][0] = 0;
        
        fig[0][1] = 5;
        fig[1][1] = 0;
        
        fig[0][2] = 4;
        fig[1][2] = 1;
        
        fig[0][3] = 5;
        fig[1][3] = 1;
      break;  // quad
    }
    grid[fig[1][0]][fig[0][0]] = 2;
    grid[fig[1][1]][fig[0][1]] = 2;
    grid[fig[1][2]][fig[0][2]] = 2;
    grid[fig[1][3]][fig[0][3]] = 2;
  }
  
  void turnFigure(){
    clearPrevPosition();
    if(!figureCollided()){
      switch(ftype){
        case 0:
          if(turnP == 0){
            fig[0][0] = fig[0][0]+2;
            fig[1][0] = fig[1][0]+2;
            
            fig[0][1] = fig[0][1]+1;
            fig[1][1] = fig[1][1]+1;
            
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            fig[0][3] = fig[0][3]-1;
            fig[1][3] = fig[1][3]-1;
            turnP = 1;
          }
          else if(turnP == 1){
            fig[0][0] = fig[0][0]-2;
            fig[1][0] = fig[1][0]-2;
            
            fig[0][1] = fig[0][1]-1;
            fig[1][1] = fig[1][1]-1;
            
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            fig[0][3] = fig[0][3]+1;
            fig[1][3] = fig[1][3]+1;
            
            turnP = 0;
          }
        break;  // line
        case 1:
          if(turnP == 0){
            fig[0][0] = fig[0][0];
            fig[1][0] = fig[1][0]+2;
            
            fig[0][1] = fig[0][1]+1;
            fig[1][1] = fig[1][1]+1;
            
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            fig[0][3] = fig[0][3]-1;
            fig[1][3] = fig[1][3]-1;
            turnP = 1;
          }
          else if(turnP == 1){
            fig[0][0] = fig[0][0]+2;
            fig[1][0] = fig[1][0];
            
            fig[0][1] = fig[0][1]+1;
            fig[1][1] = fig[1][1]-1;
            
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            fig[0][3] = fig[0][3]-1;
            fig[1][3] = fig[1][3]+1;
            
            turnP = 2;
          }
          else if(turnP == 2){
            fig[0][0] = fig[0][0];
            fig[1][0] = fig[1][0]-2;
            
            fig[0][1] = fig[0][1]-1;
            fig[1][1] = fig[1][1]-1;
            
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            fig[0][3] = fig[0][3]+1;
            fig[1][3] = fig[1][3]+1;
            
            turnP = 3;
          }
          else if(turnP == 3){
            fig[0][0] = fig[0][0]-2;
            fig[1][0] = fig[1][0];
            
            fig[0][1] = fig[0][1]-1;
            fig[1][1] = fig[1][1]+1;
            
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            fig[0][3] = fig[0][3]+1;
            fig[1][3] = fig[1][3]-1;
            
            turnP = 0;
          }
        break;  // l
        case 2:
          if(turnP == 0){
            // 31
            fig[0][0] = fig[0][0]-2;
            fig[1][0] = fig[1][0];
            
            // 41
            fig[0][1] = fig[0][1]-1;
            fig[1][1] = fig[1][1]-1;
            
            // 42
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            // 43
            fig[0][3] = fig[0][3]+1;
            fig[1][3] = fig[1][3]+1;
            
            turnP = 1;
          }
          else if(turnP == 1){
            // 33
            fig[0][0] = fig[0][0];
            fig[1][0] = fig[1][0]+2;
            
            // 32
            fig[0][1] = fig[0][1]-1;
            fig[1][1] = fig[1][1]+1;
            
            // 42
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            // 52
            fig[0][3] = fig[0][3]+1;
            fig[1][3] = fig[1][3]-1;
            
            turnP = 2;
          }
          else if(turnP == 2){
            // 53
            fig[0][0] = fig[0][0]+2;
            fig[1][0] = fig[1][0];
            
            // 43
            fig[0][1] = fig[0][1]+1;
            fig[1][1] = fig[1][1]+1;
            
            // 42
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            // 41
            fig[0][3] = fig[0][3]-1;
            fig[1][3] = fig[1][3]-1;
            
            turnP = 3;
          }
          else if(turnP == 3){
            // 53
            fig[0][0] = fig[0][0];
            fig[1][0] = fig[1][0]-2;
            
            // 43
            fig[0][1] = fig[0][1]+1;
            fig[1][1] = fig[1][1]-1;
            
            // 42
            fig[0][2] = fig[0][2];
            fig[1][2] = fig[1][2];
            
            // 41
            fig[0][3] = fig[0][3]-1;
            fig[1][3] = fig[1][3]+1;
            
            turnP = 0;
          }
        break;  // rev l
        case 3:
          if(turnP == 0){
            fig[0][0] = fig[0][0];
            fig[1][0] = fig[1][0];
            
            fig[0][1] = fig[0][1]-1;
            fig[1][1] = fig[1][1]+1;
            
            fig[0][2] = fig[0][2]+2;
            fig[1][2] = fig[1][2]+1;
            
            fig[0][3] = fig[0][3]+1;
            fig[1][3] = fig[1][3];
            turnP = 1;
          }
          else if(turnP == 1){
            fig[0][0] = fig[0][0];
            fig[1][0] = fig[1][0];
            
            fig[0][1] = fig[0][1]+1;
            fig[1][1] = fig[1][1]-1;
            
            fig[0][2] = fig[0][2]-2;
            fig[1][2] = fig[1][2]-1;
            
            fig[0][3] = fig[0][3]-1;
            fig[1][3] = fig[1][3];
            turnP = 0;
          }
        break;  // zig-zag
        case 4:
          if(turnP == 0){
            fig[0][0] = fig[0][0]+1;
            fig[1][0] = fig[1][0]+1;
            
            fig[0][1] = fig[0][1];
            fig[1][1] = fig[1][1];
            
            fig[0][2] = fig[0][2]+1;
            fig[1][2] = fig[1][2]-1;
            
            fig[0][3] = fig[0][3];
            fig[1][3] = fig[1][3]-2;
            turnP = 1;
          }
          else if(turnP == 1){
            fig[0][0] = fig[0][0]-1;
            fig[1][0] = fig[1][0]-1;
            
            fig[0][1] = fig[0][1];
            fig[1][1] = fig[1][1];
            
            fig[0][2] = fig[0][2]-1;
            fig[1][2] = fig[1][2]+1;
            
            fig[0][3] = fig[0][3];
            fig[1][3] = fig[1][3]+2;
            turnP = 0;
          }
        break;  // rev zig-zag
        case 5:
        break;  // t 
        case 6:
        break;  // quad
      }
      for(int i = 0; i < 4; i++){
        grid[fig[1][i]][fig[0][i]] = 2;
      }
    }

  }
  
  void moveFigureLeft(){
    if(fig[0][0]-1 >= 0 && fig[0][1]-1 >= 0 && fig[0][2]-1 >= 0 && fig[0][3]-1 >= 0){
      boolean isCollided = false;
      for(int i = 0; i < 4; i++){
        if(grid[fig[1][i]][fig[0][i]-1] == 1){
          isCollided = true;
          break;
        }
      }
      if(!isCollided){
        clearPrevPosition();
        fig[0][0] = fig[0][0]-1;
        fig[0][1] = fig[0][1]-1;
        fig[0][2] = fig[0][2]-1;
        fig[0][3] = fig[0][3]-1;
        for(int i = 0; i < 4; i++){
          grid[fig[1][i]][fig[0][i]] = 2;
        }
        show();
      }
    }
  }
  void moveFigureRight(){
    if(fig[0][0]+1 < sk && fig[0][1]+1 < sk && fig[0][2]+1 < sk && fig[0][3]+1 < sk){
      boolean isCollided = false;
      for(int i = 0; i < 4; i++){
        if(grid[fig[1][i]][fig[0][i]+1] == 1){
          isCollided = true;
          break;
        }
      }
      if(!isCollided){
        clearPrevPosition(); 
        fig[0][0] = fig[0][0]+1;
        fig[0][1] = fig[0][1]+1;
        fig[0][2] = fig[0][2]+1;
        fig[0][3] = fig[0][3]+1;
        for(int i = 0; i < 4; i++){
          grid[fig[1][i]][fig[0][i]] = 2;
        }
        show();
      }
    }
  }
  
  void increaseSpeed(){
    speedUp = true; 
  }
  
  boolean figureCollided(){
    for(int i = 0; i < 4; i++){
      if(fig[1][i] >= sk || fig[1][i]+1 >= sk || grid[fig[1][i]+1][fig[0][i]] == 1){
        return true;
      }
    }
    return false;
  }
  
  void updateFigure(){
    if(figureCollided()){
      for(int i = 0; i < 4; i++){
        grid[fig[1][i]][fig[0][i]] = 1;
      }
      check();
      createFigure();
    
    }else{
      clearPrevPosition();
      for(int i = 0; i < 4; i++){
        fig[1][i]++;
        grid[fig[1][i]][fig[0][i]] = 2;
      }
    }

  }
  void clearPrevPosition(){
    for(int i = 0; i < 4; i++){
      grid[fig[1][i]][fig[0][i]] = 0;      
    }  
  }

}