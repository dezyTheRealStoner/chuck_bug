import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences_bug/domain/repository/repository.dart';
import 'package:shared_preferences_bug/presentation/home/bloc/joke_bloc.dart';
import 'package:shared_preferences_bug/presentation/main_screen.dart';
import 'package:get_it/get_it.dart';

import 'presentation/common/bloc/app_bloc_obsever.dart';
import 'package:shared_preferences_bug/di.dart';

Future<void> main() async {
  await BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      EquatableConfig.stringify = true;
      await initDi();

      runApp(const MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
