
import java.awt.*;

enum COLORS {

  TILE_2(2, 238, 228, 218), 
    TILE_4(4, 237, 224, 200), 
    TILE_8(8, 242, 177, 121), 
    TILE_16(16, 245, 149, 99), 
    TILE_32(32, 246, 124, 95), 
    TILE_64(64, 246, 94, 59), 
    TILE_128(128, 237, 207, 114), 
    TILE_256(256, 237, 204, 97), 
    TILE_512(512, 237, 200, 80), 
    TILE_1024(1024, 237, 197, 63), 
    TILE_2048(2048, 255, 65, 97);

  private int value, r, g, b;

  private COLORS(int value, int r, int g, int b) {
    this.value = value;
    this.r = r;
    this.g = g;
    this.b = b;
  }

  static COLORS forValue(int value) {
    for (COLORS col : COLORS.values()) {
      if (col != null && col.value == value) {
        return col;
      }
    }
    return null;
  }

  public int getValue() {
    return value;
  }

  public int getR() {
    return r;
  }

  public int getG() {
    return g;
  }

  public int getB() {
    return b;
  }
}

class Tile {

  int value;
  int x, y;

  Animation animation;

  Tile(int value, int x, int y) {
    this.value = value;
    this.x = x;
    this.y = y;
    this.animation = new Expand(this);
  }


  void show() {
    if (this.animation != null && this.animation.finished()) {
      this.animation = null;
    }

    if (this.animation != null) {
      this.animation.update();
    } else {
      int x = this.x * tileWidth;
      int y = this.y * tileHeight;

      Color col = this.getColor();
      rectMode(CENTER);
      fill(col.getRed(), col.getGreen(), col.getBlue());
      stroke(0);
      strokeWeight(2);
      rect(x + tileWidth / 2, y + tileHeight / 2, tileWidth, tileHeight, 7);

      textSize(32);
      textAlign(CENTER);
      fill(0, 102, 153, 204);
      text(str(this.value), x + tileWidth / 2, y + tileHeight / 2);
    }
  }

  Color getColor() {

    COLORS col = COLORS.forValue(this.value);
    if (col == null) {
      return Color.DARK_GRAY;
    }
    return new Color(col.r, col.g, col.b);
  }

  public String toString() {
    return String.format("[%s] (%s, %s)", this.value, this.x, this.y);
  }
}
