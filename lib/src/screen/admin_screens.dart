part of 'screens.dart';

class AdminScreens extends StatefulWidget {
  const AdminScreens({super.key});

  @override
  State<AdminScreens> createState() => _AdminScreensState();
}

class _AdminScreensState extends State<AdminScreens> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  void reset() {
    productNameController.clear();
    productPriceController.clear();
    BlocProvider.of<ProductPictureCubit>(context).resetImage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        reset();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: 'Add Product'.text.make(),
          elevation: 0.0,
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is AdminIsSuccess) {
              reset();
              Commons().showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            return VStack([
              _buildProductFrom(),
              ButtonWidget(
                onPressed: () {
                  BlocProvider.of<AdminBloc>(context).add(AddProduct(
                    name: productNameController.text,
                    price: double.parse(productPriceController.text),
                  ));
                },
                isLoading: (state is AdminIsLoading) ? true : false,
                text: 'Upload',
              ).p16()
            ]);
          },
        ),
      ),
    );
  }

  Widget _buildProductFrom() {
    return VStack([
      TextFieldWidget(
        controller: productNameController,
        title: 'Product Name',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productPriceController,
        title: 'Product Price',
      ),
      8.heightBox,
      BlocBuilder<ProductPictureCubit, ProductPictureState>(
        builder: (context, state) {
          if (state is ProductPictureIsLoaded) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ZStack(
                [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(
                      state.file,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<ProductPictureCubit>(context).getImage();
                    },
                    icon: const Icon(Icons.image),
                  )
                      .box
                      .color(colorName.white.withOpacity(.8))
                      .roundedFull
                      .make(),
                ],
                alignment: Alignment.center,
              ),
            );
          }
          return IconButton(
            onPressed: () {
              BlocProvider.of<ProductPictureCubit>(context).getImage();
            },
            icon: const Icon(Icons.image),
          );
        },
      )
    ]).p16();
  }
}
