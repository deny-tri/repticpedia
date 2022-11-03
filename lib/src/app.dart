import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repticpedia/src/utilitie/utilities.dart';

import 'bloc/blocs.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
          child: Container(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
