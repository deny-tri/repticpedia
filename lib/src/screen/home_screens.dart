part of 'screens.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
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
                  _buildAppbar(context, state.data),
                  24.heightBox,
                  _buildListProduct().expand(),
                ],
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              );
            }
            return 0.heightBox;
          },
        ).p16().centered(),
      ),
    );
  }

  Widget _buildAppbar(BuildContext context, UserModel data) {
    return VxBox(
      child: HStack(
        [
          HStack([
            VxCircle(
              radius: 80,
              backgroundImage: (data.photoProfile!.isNotEmpty)
                  ? DecorationImage(
                      image: NetworkImage(data.photoProfile!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ).onTap(() {
              context.go(routeName.adminPath);
            }),
            16.widthBox,
            '${Commons().greeting()},\n'
                .richText
                .size(12)
                .withTextSpanChildren([
              data.username!.textSpan.bold.size(18).make(),
            ]).make(),
          ]).expand(),
          IconButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(LogOutUser());
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    ).gray100.make();
  }

  Widget _buildListProduct() {
    return BlocConsumer<ListProductBloc, ListProductState>(
      listener: (context, state) {
        if (state is ListProductIsFailed) {
          Commons().showSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ListProductIsLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ListProductIsSuccess) {
          final data = state.products;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              // return Image.network(
              //   data[index].picture!,
              //   fit: BoxFit.cover,
              // );
              // return data[index].name!.text.make();
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: VStack([
                  GestureDetector(
                    onTap: () {
                      context.go(routeName.detailPath, extra: data[index].id);
                    },
                    child: Image.network(
                      data[index].picture!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  data[index].name!.text.bodyText1(context).make(),
                  data[index].price!.text.bodyText1(context).make(),
                ]),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
