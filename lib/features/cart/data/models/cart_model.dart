import 'package:clothshop/constants/hive_type_ids.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:hive/hive.dart';


part 'cart_model.g.dart';

@HiveType(typeId: HiveTypeIds.cartModel)
class CartModel extends HiveObject {
  @HiveField(0)
  final String productId;
  
  @HiveField(1)
  final int quantity;
  
  @HiveField(2)
  final String? selectedSize;
  
  @HiveField(3)
  final String? selectedColor;

  CartModel({
    required this.productId,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  CartItemEntity toEntity(ProductEntity product) {
    return CartItemEntity(
      product: product,
      quantity: quantity,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
    );
  }
}