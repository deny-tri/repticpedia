import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repticpedia/src/utilitie/utilities.dart';

part 'product_picture_state.dart';

class ProductPictureCubit extends Cubit<ProductPictureState> {
  ProductPictureCubit() : super(ProductPictureInitial());

  void getImage() async {
    final file = await Commons().getImage();
    if (file.path.isNotEmpty) {
      emit(ProductPictureIsLoaded(file: file));
    } else {
      emit(ProductPictureIsFailed());
    }
  }

  void resetImage() {
    emit(ProductPictureInitial());
  }
}
