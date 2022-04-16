import 'package:flutter/foundation.dart';

import 'categoryModel.dart';

class BookmarkedSessionModel {
  final String id;
  final String logoUrl;
  final String sessId;
  final String shopName;
  final String sellerId;
  final String sessionId;
  final String sessionName;
  final String sessionThumbnail;
  final String sessionDate;
  final String sessionTime;
  final String sessionPageLink;
  final BMCategoryModel categoryList;

  BookmarkedSessionModel({
    @required this.id,
    @required this.logoUrl,
    @required this.sessId,
    @required this.shopName,
    @required this.sellerId,
    @required this.sessionId,
    @required this.sessionName,
    @required this.sessionThumbnail,
    @required this.sessionDate,
    @required this.sessionTime,
    @required this.sessionPageLink,
    @required this.categoryList,
  });
}
