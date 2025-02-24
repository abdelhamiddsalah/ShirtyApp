import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable{
  final ProductEntity product;
  final int quantity;
  final double totalPrice;

  const CartItemEntity({
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });
  
  @override
  List<Object?> get props => [product, quantity, totalPrice]; 

  CartItemEntity copyWith({
    ProductEntity? product,
    int? quantity,
    double? totalPrice,
  }) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
/* final String productId;
  final String productname;
  final int quantity;
  final String productSelectedcolor;
  final String productSelectedsize;
  final double mainprice;
  final double totalPrice;
  final String productimage;
  final String createDate;


  CartItemEntity({
    required this.productId,
    required this.productname,
    required this.quantity,
    required this.productSelectedcolor,
    required this.productSelectedsize,
    required this.mainprice,
    required this.totalPrice,
    required this.productimage,
    required this.createDate,
  });

  @override
  List<Object?> get props => [
    productId,
    productname,
    quantity,
    productSelectedcolor,
    productSelectedsize,
    mainprice,
    totalPrice,
    productimage,
    createDate,
  ];

  CartItemEntity copyWith({
    String? productId,
    String? productname,
    int? quantity,
    String? productSelectedcolor,
    String? productSelectedsize,
    double? mainprice,
    double? totalPrice,
    String? productimage,
    String? createDate,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      productname: productname ?? this.productname,
      quantity: quantity ?? this.quantity,
      productSelectedcolor: productSelectedcolor ?? this.productSelectedcolor,
      productSelectedsize: productSelectedsize ?? this.productSelectedsize,
      mainprice: mainprice ?? this.mainprice,
      totalPrice: totalPrice ?? this.totalPrice,
      productimage: productimage ?? this.productimage,
      createDate: createDate ?? this.createDate,
    );
  }

  
   double calculatedTotalPrice() {
    return mainprice * quantity;
  }*/