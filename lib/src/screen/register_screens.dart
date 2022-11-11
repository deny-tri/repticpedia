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
        child: SingleChildScrollView(
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterIsFailed) {
                Commons().showSnackbar(context, state.message);
              } else if (state is RegisterIsSuccess) {
                context.go(routeName.home);
              }
            },
            child: VStack(
              alignment: MainAxisAlignment.center,
              [
                _buildHeaderText(),
                _buildRegisterForm(),
                _buildRegisSosmed(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return VxBox(
      child: VStack(
        [
          'Created New Account'
              .text
              .bold
              .headline5(context)
              .color(colorName.accentBlue)
              .make(),
          'Enter your Email, Name and Password for sign up'.text.make(),
          HStack([
            'for sign up. '.text.make(),
            'Already Have Account'
                .text
                .color(colorName.accentBlue)
                .make()
                .onTap(() {
              context.go(routeName.login);
            })
          ]),
        ],
      ),
    )
        .size(context.screenWidth, context.percentHeight * 20)
        .margin(const EdgeInsets.only(top: 20))
        .p16
        .make();
  }

  Widget _buildRegisSosmed() {
    return HStack(
      [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {},
          child: Image.asset(
            "assets/images/google.png",
            fit: BoxFit.cover,
            height: 20,
            width: 20,
          ),
        ),
      ],
      alignment: MainAxisAlignment.center,
      axisSize: MainAxisSize.max,
    );
  }

  Widget _buildRegisterForm() {
    return VStack(
      [
        TextFieldWidget(
          title: "Email",
          controller: emailController,
        ),
        16.heightBox,
        TextFieldWidget(
          title: "Username",
          controller: usernameController,
        ),
        16.heightBox,
        TextFieldWidget(
          title: "Password",
          controller: passwordController,
          isEnabled: true,
          isPassword: true,
        ),
        16.heightBox,
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
        8.heightBox,
        'Or Connect With'.text.makeCentered()
      ],
    ).p(16);
  }
}
