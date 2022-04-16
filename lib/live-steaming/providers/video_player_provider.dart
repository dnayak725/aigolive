import 'package:flutter/material.dart';

class VideoPlayerProvider with ChangeNotifier {
  bool _isFullScreenPlayer = false;

  bool get isFullScreenPlayer {
    return _isFullScreenPlayer;
  }

  void setIsFullScreenPlayer(isFullScreenPlayer) {
    _isFullScreenPlayer = isFullScreenPlayer;
    notifyListeners();
  }

  //code for vlc player and red5pro live streaming
  int _viewers = 0;
  int get totalViewers {
    return _viewers;
  }

  void changeViewersValue(int value) {
    _viewers = value;
    notifyListeners();
  }
}
