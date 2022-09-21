import 'package:ditonton/common/constants.dart';
import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

extension ImagePath on String? {
  String get imageUrl => "$BASE_IMAGE_URL$this";
}