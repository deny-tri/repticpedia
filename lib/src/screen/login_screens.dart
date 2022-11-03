part of 'screens.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginIsFailed) {
              Commons().showSnackbar(context, state.message);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: state.message.text.make()));
            } else if (state is LoginIsSuccess) {
              context.go(routeName.home);
            }
          },
          child: VStack(
            [
              "Login".text.headline5(context).make().p16(),
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return VStack(
      [
        TextFieldWidget(
          title: "Email",
          controller: emailController,
        ),
        TextFieldWidget(
          title: "Password",
          controller: passwordController,
          isEnabled: true,
          isPassword: true,
        ),
        16.heightBox,
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return ButtonWidget(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(
                  LoginUser(
                      email: emailController.text,
                      password: passwordController.text),
                );
              },
              isLoading: (state is LoginIsLoading) ? true : false,
              text: 'Login',
            );
          },
        ),
      ],
    ).p(16);
  }
}
