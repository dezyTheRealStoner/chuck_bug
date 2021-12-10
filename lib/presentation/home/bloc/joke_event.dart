part of 'joke_bloc.dart';

@immutable
abstract class JokeEvent {
  const JokeEvent();
}

class LoadJokeEvent extends JokeEvent {
  const LoadJokeEvent();
}

class SaveJokeEvent extends JokeEvent {
  const SaveJokeEvent(this.joke);

  final String joke;
}
