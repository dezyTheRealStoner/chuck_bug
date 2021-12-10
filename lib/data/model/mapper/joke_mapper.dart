import 'package:shared_preferences_bug/data/model/models.dart';
import 'package:shared_preferences_bug/domain/model/models.dart';

class JokeMapper {
  static Joke toDomain(JokeEntity entity) => Joke(
        imageUrl: entity.imageUrl,
        joke: entity.joke,
      );
}
