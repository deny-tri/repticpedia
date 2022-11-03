part of 'screens.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserIsFailed) {
            Commons().showSnackbar(context, state.message);
          } else if (state is UserIsLogOut) {
            context.go(routeName.login);
          }
        },
        builder: (context, state) {
          if (state is UserIsLoading) {
            return const CircularProgressIndicator().centered();
          } else if (state is UserIsSuccess) {
            return VStack(
              [
                'Welcome ${state.data.username}'.text.makeCentered(),
                8.heightBox,
                ButtonWidget(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context).add(LogOutUser());
                  },
                  text: 'Login Out',
                ),
              ],
            );
          }
          return 0.heightBox;
        },
      ).p16().centered(),
    );
  }
}
