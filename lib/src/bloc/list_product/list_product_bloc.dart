import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repticpedia/src/model/models.dart';
import 'package:repticpedia/src/service/services.dart';

part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  ListProductBloc() : super(ListProductInitial()) {
    on<ListProductEvent>((event, emit) async {
      emit(ListProductIsLoading());
      final result = await ProductService().fetchListProduct();
      emit(result.fold((l) => ListProductIsFailed(message: l),
          (r) => ListProductIsSuccess(products: r)));
    });
  }
}
