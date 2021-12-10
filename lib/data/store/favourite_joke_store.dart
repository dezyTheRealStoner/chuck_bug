import 'package:shared_preferences/shared_preferences.dart';

class FavouriteJokesStore {
  List<String> favouriteJokes = [];

  Future<void> saveFavouriteJoke(String joke) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentList = prefs.getStringList('key');
    currentList?.add(joke);
    prefs.setStringList('key', currentList!);
    var updatedList = prefs.getStringList('key');
    print(updatedList);
  }
}
