import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences_bug/data/store/favourite_joke_store.dart';
import 'package:shared_preferences_bug/domain/model/models.dart';
import 'package:shared_preferences_bug/presentation/error/error_screen.dart';
import 'package:shared_preferences_bug/presentation/home/bloc/joke_bloc.dart';
import 'package:shared_preferences_bug/presentation/progress/progress_screen.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var bloc = GetIt.instance.get<JokeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JokeBloc, JokeState>(
      bloc: bloc,
      builder: (_, state) {
        switch (state.status) {
          case JokeStatus.success:
            return HomeContent(
              joke: state.joke,
              onRefresh: () => bloc.add(const LoadJokeEvent()),
              onSave: (joke) => bloc.add(SaveJokeEvent(joke)),
            );
          case JokeStatus.failure:
            return const ErrorScreen();
          default:
            return const ProgressScreen();
        }
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  final Joke joke;
  final Function onRefresh;
  final void Function(String) onSave;

  const HomeContent({
    Key? key,
    required this.joke,
    required this.onRefresh,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(joke.imageUrl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              joke.joke,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          MaterialButton(
            color: Colors.pink,
            onPressed: () {
              onRefresh();
            },
            child: const Text(
              'Refresh',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          MaterialButton(
            color: Colors.green,
            onPressed: () {
              onSave(joke.joke);
            },
            child: const Text(
              'Save to favorite',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  FavouriteJokesStore().favouriteJokes.elementAt(index),
                ),
              ),
              itemCount: FavouriteJokesStore().favouriteJokes.length,
            ),
          ),
        ],
      ),
    );
  }
}
