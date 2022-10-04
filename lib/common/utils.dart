import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

extension ImagePath on String? {
  String get imageUrl => this != null ? "$BASE_IMAGE_URL$this" : "unknown";
}

extension GenreNames on List<Genre> {
  String get names {
    if (this.isEmpty || this.every((element) => element.name.trim().isEmpty)) {
      return "";
    }

    final result =
        this.fold<String>("", (prev, element) => prev + element.name + ", ");
    return result.substring(0, result.length - 2);
  }
}

extension RuntimeFormatter on int {
  String get convertToReadableDuration {
    final int hours = this ~/ 60;
    final int minutes = this % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
