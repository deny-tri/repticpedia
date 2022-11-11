// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {}

class AddProduct extends AdminEvent {
  final String? name;
  final double? price;
  AddProduct({
    this.name,
    this.price,
  });
}
