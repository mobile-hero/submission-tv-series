import 'package:ditonton/data/models/creator_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tCreatorModel = CreatorModel(
      id: 1, creditId: 'creditId', name: 'name', profilePath: 'profilePath');

  group('Creator toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tCreatorModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "credit_id": "creditId",
        "name": "name",
        "profile_path": "profilePath",
      };
      expect(result, expectedJsonMap);
    });
  });
}
