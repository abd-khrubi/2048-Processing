enum Action { //<>// //<>//
  ACTION_UP, ACTION_DOWN, ACTION_LEFT, ACTION_RIGHT;

  public static Action forKey(int key) {
    if (key == UP) {
      return ACTION_UP;
    } else if (key == DOWN) {
      return ACTION_DOWN;
    } else if (key == LEFT) {
      return ACTION_LEFT;
    } else if (key == RIGHT) {
      return ACTION_RIGHT;
    } else {
      return null;
    }
  }
}

class Game {

  Board board;
  public int score;

  Game() {
    this.board = new Board();
    this.score = 0;
  }

  boolean up() {
    // Merge up
    boolean moved = false;
    for (int x = 0; x < boardSize; x++) {
      for (int y = 1; y < boardSize; y++) {
        Tile tile = this.board.tiles[y][x];
        if (tile != null) {
          for (int yy = y - 1; yy >= 0; yy--) {
            Tile tile2 = this.board.tiles[yy][x];
            if (tile2 == null) {
              tile.y = yy;
              this.board.tiles[yy][x] = tile;
              this.board.tiles[y][x] = null;
              y = yy;
              moved = true;
//              break;
            } else if (tile.value == tile2.value) {
              tile2.value += tile.value;
              this.board.tiles[y][x] = null;
              moved = true;
              break;
            } else {
              break;
            }
          }
        }
      }
    }
    return moved;
  }

  boolean down() {
    // Merge down
    boolean moved = false;
    for (int x = 0; x < boardSize; x++) {
      for (int y = boardSize - 2; y >= 0; y--) {
        Tile tile = this.board.tiles[y][x];
        if (tile != null) {
          for (int yy = y + 1; yy < boardSize; yy++) {
            Tile tile2 = this.board.tiles[yy][x];
            if (tile2 == null) {
              tile.y = yy;
              this.board.tiles[yy][x] = tile;
              this.board.tiles[y][x] = null;
              y = yy;
              moved = true;
            } else if (tile.value == tile2.value) {
              tile2.value += tile.value;
              this.board.tiles[y][x] = null;
              moved = true;
              break;
            } else {
              break;
            }
          }
        }
      }
    }
    return moved;
  }

  boolean left() {        // Merge up
    boolean moved = false;
    for (int y = 0; y < boardSize; y++) {
      for (int x = 1; x < boardSize; x++) {
        Tile tile = this.board.tiles[y][x];
        if (tile != null) {
          for (int xx = x - 1; xx >= 0; xx--) {
            Tile tile2 = this.board.tiles[y][xx];
            if (tile2 == null) { // hi
              tile.x = xx;
              this.board.tiles[y][xx] = tile;
              this.board.tiles[y][x] = null;
              x = xx;
              moved = true;
            } else if (tile.value == tile2.value) {
              tile2.value += tile.value;
              this.board.tiles[y][x] = null;
              moved = true;
              break;
            } else {
              break;
            }
          }
        }
      }
    }
    return moved;
  }

  boolean right() {
    boolean moved = false;
    for (int y = 0; y < boardSize; y++) {
      for (int x = boardSize - 2; x >= 0; x--) {
        Tile tile = this.board.tiles[y][x];
        if (tile != null) {
          for (int xx = x + 1; xx < boardSize; xx++) {
            Tile tile2 = this.board.tiles[y][xx];
            if (tile2 == null) { // hi
              tile.x = xx;
              this.board.tiles[y][xx] = tile;
              this.board.tiles[y][x] = null;
              x = xx;
              moved = true;
            } else if (tile.value == tile2.value) {
              tile2.value += tile.value;
              this.board.tiles[y][x] = null;
              moved = true;
              break;
            } else {
              break;
            }
          }
        }
      }
    }
    return moved;
  }

  ArrayList<Action> getLegalMoves() {
    ArrayList<Action> actions = new ArrayList<Action>();
    boolean up = false, down = false, left = false, right = false;
    int lastVal = -1;
    //for (Tile[] row : this.board.tiles) {
    for (int y = 0; y < boardSize; y++) {
      lastVal = -1;
      //for (Tile tile : row) {
      for (int x = 0; x < boardSize; x++) {
        Tile tile = this.board.tiles[y][x];
        if (tile == null) {
          if (x == 0) {
            left = true;
          } else if (x == boardSize - 1) {
            right = true;
          } else {
            left = right = true;
          }
          break;
        }
        if (lastVal == tile.value) {
          left = right = true;
          break;
        } else {
          lastVal = tile.value;
        }
      }
    }

    for (int x = 0; x < boardSize; x++) {
      lastVal = -1;
      for (int y = 0; y < boardSize; y++) {
        Tile tile = this.board.tiles[y][x]; // x, y?
        if (tile == null) {
          if (y == 0) {
            up = true;
          } else {
            up = down = true;
          }
          break;
        }
        if (lastVal == tile.value) {
          up = down = true;
          break;
        } else {
          lastVal = tile.value;
        }
      }
    }

    if (up) {
      actions.add(Action.ACTION_UP);
    }
    if (down) {
      actions.add(Action.ACTION_DOWN);
    }
    if (left) {
      actions.add(Action.ACTION_LEFT);
    }
    if (right) {
      actions.add(Action.ACTION_RIGHT);
    }
    return actions;
  }

  public void move(int key) {
    Action action = Action.forKey(key);
    ArrayList<Action> legal = getLegalMoves();
    if (legal.size() == 0) {
      println("Game over");
      return;
    }
    if (action == null) {
      return; // illegal move
    }
    boolean moved;
    switch (action) {
      case ACTION_UP:
        moved = up();
        break;
      case ACTION_DOWN:
        moved = down();
        break;
      case ACTION_LEFT:
        moved = left();
        break;
      case ACTION_RIGHT:
        moved = right();
        break;
      default:
        moved = false;
    }
    if (moved) {

      this.board.addRandom();
    }
  }
  public int getScore() {
    int score = 0;
    for (Tile[] row : this.board.tiles) {
      for (Tile tile : row) {
        if (tile != null) {
          score += tile.value;
        }
      }
    }
    return score;
  }
}
