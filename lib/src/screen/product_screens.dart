part of 'screens.dart';

class ProductScreens extends StatelessWidget {
  const ProductScreens({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: 'Products'.text.color(colorName.black).makeCentered(),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          onPressed: () {
            context.go(routeName.home);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<ListProductBloc, ListProductState>(
          listener: (context, state) {
            if (state is ListProductIsFailed) {
              Commons().showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ListProductIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ListProductIsSuccess) {
              final data = state.products;
              final double conHeight = (size.height / 2 - kToolbarHeight);
              final double conWidth = size.width / 2;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  childAspectRatio: (conWidth / conHeight),
                  mainAxisSpacing: 20,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ProductWidgets(
                    products: data[index],
                    isLoading: (state is ListProductIsLoading) ? false : true,
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
