import 'package:flutter/foundation.dart';

class LiveStreamDataModel {
  final String id;
  final String image;
  final String category;
  final String sessionTitle;
  final String status;
  final DateTime time;

  LiveStreamDataModel(
      @required this.id,
      @required this.image,
      @required this.category,
      @required this.sessionTitle,
      @required this.status,
      @required this.time);
}
