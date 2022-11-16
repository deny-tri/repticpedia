part of 'screens.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DetailProductsBloc, DetailProductsState>(
          listener: (context, state) {
            if (state is DetailProductsIsFailed) {
              Commons().showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is DetailProductsIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DetailProductsIsSuccess) {
              final data = state.model;
              return VStack([
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    data.picture!,
                    fit: BoxFit.cover,
                  ),
                ),
                data.name!.text.bodyText1(context).makeCentered(),
                8.heightBox,
                data.price!.text.bodyText1(context).makeCentered(),
              ]).p16();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
