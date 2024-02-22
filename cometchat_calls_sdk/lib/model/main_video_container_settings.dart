import 'item_settings.dart';

class MainVideoContainerSetting {
  String? videoFit;
  ItemSettings? fullScreenButton;
  ItemSettings? userListButton;
  ItemSettings? zoomButton;
  ItemSettings? nameLabel;

  void setMainVideoAspectRatio(String videoFit){
    this.videoFit=videoFit;
  }

  void setFullScreenButtonParams(String position, bool visibility){
    fullScreenButton = ItemSettings(position,visibility,"");
  }

  void setNameLabelParams(String position, bool visibility,String color){
    nameLabel = ItemSettings(position,visibility,color);
  }

  void setZoomButtonParams(String position, bool visibility){
    zoomButton = ItemSettings(position,visibility,"");
  }

  void setUserListButtonParams(String position, bool visibility){
    userListButton = ItemSettings(position,visibility,"");
  }
}