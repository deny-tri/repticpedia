part of 'utilities.dart';

mixin routeName {
  static const login = '/login';
  static const splash = '/splash';
  static const register = '/register';
  static const home = '/home';
  static const adminPath = '/home/admin';
}

final GoRouter router = GoRouter(initialLocation: routeName.splash, routes: [
  GoRoute(
    path: routeName.splash,
    redirect: (context, state) {
      if (FirebaseAuth.instance.currentUser != null) {
        BlocProvider.of<UserBloc>(context).add(LoadUserData());
        return routeName.home;
      } else {
        return routeName.login;
      }
    },
    builder: (context, state) {
      return const SplashScreens();
    },
  ),
  GoRoute(
    path: routeName.register,
    builder: (context, state) {
      return const RegisterScreens();
    },
  ),
  GoRoute(
    path: routeName.login,
    builder: (context, state) {
      BlocProvider.of<UserBloc>(context).add(LoadUserData());
      return const LoginScreens();
    },
  ),
  GoRoute(
    path: routeName.home,
    builder: (context, state) {
      BlocProvider.of<UserBloc>(context).add(LoadUserData());
      return const HomeScreens();
    },
  ),
]);
