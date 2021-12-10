import 'package:shared_preferences_bug/data/model/joke_entity.dart';
import 'package:shared_preferences_bug/data/network_service.dart';

class JokesStore {
  final NetworkService networkService;

  JokesStore(this.networkService);

  Future<JokeEntity> getRandomJoke() async {
    return await networkService.getRandomJoke();
  }
}
