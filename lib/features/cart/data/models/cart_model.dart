import 'package:hive/hive.dart';

part 'cart_model.g.dart';
@HiveType(typeId: 1)
class CartModel extends HiveObject{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final int count;
  @HiveField(4)
  final int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.count,
    required this.quantity,
  });

}