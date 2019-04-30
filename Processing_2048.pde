
/*
  Global variables
*/
final int boardSize = 4;
int tileWidth, tileHeight;

int panelSize = 80; // score panel

final double TILE_4_CHANCE = 0.33;


private Game game;


public void setup() {
  tileWidth = width / boardSize;
  tileHeight = (height - panelSize) / boardSize;
  game = new Game();
}

public void settings() {
  size(600, 600 + panelSize);
}

public void draw() {
  background(220, 220, 220);
  game.board.show();

  text("Score: " + game.getScore(), width / 2, height - 40);
}

public void keyPressed() {
  if (key == CODED) {
    this.game.move(keyCode);
  }
}
