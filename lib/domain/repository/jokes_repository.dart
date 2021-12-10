import 'package:shared_preferences_bug/data/model/mapper/joke_mapper.dart';
import 'package:shared_preferences_bug/data/store/favourite_joke_store.dart';
import 'package:shared_preferences_bug/data/store/jokes_store.dart';
import 'package:shared_preferences_bug/domain/model/models.dart';

abstract class JokesRepository {
  Future<Joke> getRandomJoke();

  Future<void> saveFavouriteJoke(String joke);
}

class JokesRepositoryIml implements JokesRepository {
  final JokesStore jokesStore;
  final FavouriteJokesStore favouriteJokesStore;

  JokesRepositoryIml(this.jokesStore, this.favouriteJokesStore);

  @override
  Future<Joke> getRandomJoke() async {
    var jokeEntity = await jokesStore.getRandomJoke();
    return JokeMapper.toDomain(jokeEntity);
  }

  @override
  Future<void> saveFavouriteJoke(String joke) async {
    var favJokeEntity = await favouriteJokesStore.saveFavouriteJoke(joke);
    return favJokeEntity;
  }
}
