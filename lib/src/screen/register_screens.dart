part of 'screens.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({super.key});

  @override
  State<RegisterScreens> createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterIsFailed) {
              Commons().showSnackbar(context, state.message);
            } else if (state is RegisterIsSuccess) {
              context.go(routeName.home);
            }
          },
          child: VStack(
            [
              // VxBox()
              //     .size(context.screenWidth, context.percentHeight * 20)
              //     .color(colorName.accentBlue)
              //     .bottomRounded(value: 20)
              //     .make(),
              "Register".text.headline5(context).make().p16(),
              _buildRegisterForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return VStack(
      [
        TextFieldWidget(
          title: "Email",
          controller: emailController,
        ),
        TextFieldWidget(
          title: "Username",
          controller: usernameController,
        ),
        TextFieldWidget(
          title: "Password",
          controller: passwordController,
          isEnabled: true,
          isPassword: true,
        ),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return ButtonWidget(
              onPressed: () {
                BlocProvider.of<RegisterBloc>(context).add(
                  RegisterUser(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text),
                );
              },
              isLoading: (state is RegisterIsLoading) ? true : false,
              text: 'Register',
            );
          },
        ),
      ],
    ).p(16);
  }
}
