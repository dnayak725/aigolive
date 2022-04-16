import 'package:flutter/foundation.dart';

class NotificationModel {
  final String id;
  final String notificationHeader;
  final String message;
  final String pageLink;
  final String receipientId;
  final String receipientType;
  final String receipientRead;
  final String notificationType;
  final String metaData;
  final String icon;
  final String buttonName;
  final String time;

  NotificationModel({
    @required this.id,
    @required this.notificationHeader,
    @required this.message,
    @required this.pageLink,
    @required this.receipientId,
    @required this.receipientType,
    @required this.receipientRead,
    @required this.notificationType,
    @required this.metaData,
    @required this.icon,
    @required this.buttonName,
    @required this.time,
  });
}
