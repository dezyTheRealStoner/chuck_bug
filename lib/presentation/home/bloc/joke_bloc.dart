import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences_bug/domain/model/models.dart';
import 'package:shared_preferences_bug/domain/repository/jokes_repository.dart';
import 'package:meta/meta.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final JokesRepositoryIml repository;

  JokeBloc(this.repository) : super(const JokeState.loading()) {
    on<LoadJokeEvent>((event, emit) async {
      try {
        final joke = await repository.getRandomJoke();

        emit(JokeState.success(joke));
      } on Exception {
        emit(const JokeState.failure());
        rethrow;
      }
    });
    on<SaveJokeEvent>((event, emit) async {
      var joke = event.joke;

      await repository.saveFavouriteJoke(joke);
      debugPrint('added $joke');
    });

    add(const LoadJokeEvent());
  }
}
