// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'widgets.dart';

class ProductWidgets extends StatelessWidget {
  final ProductModel products;
  final bool isLoading;
  const ProductWidgets({
    Key? key,
    required this.products,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(routeName.detailPath, extra: products.id);
      },
      child: VStack(
        [
          VStack(
            [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  products.picture!,
                  fit: BoxFit.cover,
                )
                    .box
                    .rounded
                    .size(
                        context.percentWidth * 100, context.percentHeight * 20)
                    .make(),
              ),
              16.heightBox,
              products.name!.text.bold.make(),
              16.heightBox,
              HStack(
                [
                  'Harga'.text.bold.make(),
                  products.price!.text.make(),
                ],
                alignment: MainAxisAlignment.spaceBetween,
                axisSize: MainAxisSize.max,
              ),
              16.heightBox,
              HStack(
                [
                  'Stock'.text.bold.make(),
                  products.stock!.text.make(),
                ],
                alignment: MainAxisAlignment.spaceBetween,
                axisSize: MainAxisSize.max,
              ),
            ],
          )
              .p8()
              .box
              .color(colorName.white)
              .rounded
              .outerShadow
              .size(context.percentWidth * 100, context.percentHeight * 38)
              .make(),
        ],
      ).p8(),
    )
        // return VxBlock(
        //   children: [
        //     VxBox(
        //             // child: Image.network(products.picture!),
        //             )
        //         .color(colorName.white)
        //         .outerShadow
        //         .rounded
        //         .make(),
        //   ],
        // );
        ;
//     // Stack(
//     //   children: [
//     //     isLoading
//     //         ? GestureDetector(
//     //             onTap: () {
//     //               context.go(routeName.detailPath);
//     //             },
//     //             child: VxBox(
//     //               child: ClipRRect(
//     //                 child: Image.network(products.picture!),
//     //               ),
//     //             )
//     //                 .size(context.percentWidth * 100,
//     //                     context.percentHeight * 20)
//     //                 .rounded
//     //                 .color(colorName.accentBlue)
//     //                 .make(),
//     //           )
//     //         : Shimmer(
//     //             gradient: const LinearGradient(colors: [
//     //               Colors.yellow,
//     //               Colors.white,
//     //               Colors.yellow,
//     //             ]),
//     //             child: VxBox()
//     //                 .color(colorName.accentGreen)
//     //                 .size(context.percentWidth * 100,
//     //                     context.percentHeight * 20)
//     //                 .make(),
//     //           ),
//     //   ],
//     // ),

//     // return ClipRRect(
//     //   borderRadius: BorderRadius.circular(10),
//     //   child: VStack(
//     //     [
//     //       GestureDetector(
//     //         onTap: () {
//     //           context.go(routeName.detailPath, extra: products.id);
//     //         },
//     //         child: Stack(
//     //           children: [
//     //             VxBox(
//     //                 child: Image.network(
//     //               products.picture!,
//     //               fit: BoxFit.cover,
//     //             )).width(200).height(200).make()
//     //           ],
//     //         ),
//     //       ),
    //       // products.name!.text.bodyText1(context).make(),
    //       // products.price!.text.bodyText1(context).make(),
//     //     ],
//     //     alignment: MainAxisAlignment.spaceBetween,
//     //     axisSize: MainAxisSize.max,
//     //   ).p16(),
//     // );
//   }
// }
  }
}
