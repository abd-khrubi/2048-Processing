class Board {
  Tile[][] tiles;

  Board() {
    tiles = new Tile[boardSize][boardSize];
    init();
  }

  void init() {
    addRandom();
  }

  void show() {
    //    processing.background(255);
    for (Tile[] row : tiles) {
      for (Tile tile : row) {
        if (tile != null) {
          tile.show();
        }
      }
    }
  }

  public Tile addRandom() {
    int x;
    int y;
    int val;
    do {
      x = int(random(0, boardSize));
      y = int(random(0, boardSize));
    } while (this.tiles[y][x] != null);
    float r = random(1);

    if (r <= TILE_4_CHANCE) {
      val = 2;
    } else {
      val = 4;
    }
    this.tiles[y][x] = new Tile(val, x, y);
    return this.tiles[y][x];
  }

  void print() {
    for (Tile[] row : this.tiles) {
      for (Tile tile : row) {
        if (tile == null) {
          System.out.print("_, ");
        } else {
          System.out.print(tile.value + ", ");
        }
      }
      println();
    }
    println("---------------------------");
  }
}
