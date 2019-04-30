public abstract class Animation {

  protected Tile tile;

  protected Animation(Tile tile) {
    this.tile = tile;
  }


  abstract void update();
  abstract boolean finished();
}
