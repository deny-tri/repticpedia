part of 'screens.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void _authenticateWithGoogle(context) {
    BlocProvider.of<LoginBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

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
              'Hello Again!'
                  .text
                  .color(colorName.accentBlue)
                  .headline4(context)
                  .makeCentered(),
              _buildLoginForm(),
            ],
            alignment: MainAxisAlignment.center,
            axisSize: MainAxisSize.max,
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
        16.heightBox,
        TextFieldWidget(
          title: "Password",
          controller: passwordController,
          isEnabled: true,
          isPassword: true,
        ),
        8.heightBox,
        'Forget Password?'.text.color(colorName.accentBlue).make(),
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
        HStack(
          [
            'Create new account?'.text.makeCentered(),
            8.widthBox,
            'Register'
                .text
                .color(colorName.accentBlue)
                .makeCentered()
                .onTap(() {
              context.go(routeName.register);
            }),
          ],
          alignment: MainAxisAlignment.center,
          axisSize: MainAxisSize.max,
        ),
        8.heightBox,
        'Or Continue With'.text.bold.makeCentered(),
        8.heightBox,
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            _authenticateWithGoogle(context);
          },
          child: Image.asset(
            "assets/images/google.png",
            fit: BoxFit.cover,
            height: 20,
            width: 20,
          ),
        ),
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).p(16);
  }
}
