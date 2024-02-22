class ItemSettings{
  String position;
  bool visibility;
  String color;

  ItemSettings(this.position, this.visibility, this.color);

  String getPosition() {
    return position;
  }

  bool getVisibility(){
    return visibility;
  }

  String getColor() {
    return color;
  }
}
