import 'package:clothshop/features/home/data/models/product_model.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel(super.selectedColor, super.selectedSize, {
    required ProductModel super.product,
    required super.quantity,
    required super.totalPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>,''),
      quantity: json['quantity'] ?? 1,
      totalPrice: (json['totalPrice'] as num).toDouble(),
       json['selectedColor'],
       json['selectedSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': (product as ProductModel).toJson(),
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
     selectedColor,
       selectedSize,
      product: product,
      quantity: quantity,
      totalPrice: totalPrice,
    );
  }
}

/* CartModel({
    required super.productId,
    required super.productname,
    required super.quantity,
    required super.productSelectedcolor,
    required super.productSelectedsize,
    required super.mainprice,
    required super.totalPrice,
    required super.productimage,
    required super.createDate,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      productname: json['productname'],
      quantity: json['quantity'],
      productSelectedcolor: json['productSelectedcolor'],
      productSelectedsize: json['productSelectedsize'],
      productimage: json['productimage'],
      createDate: json['createDate'],
      mainprice: json['mainprice'],
      totalPrice: json['totalprice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productname': productname,
      'quantity': quantity,
      'productSelectedcolor': productSelectedcolor,
      'productSelectedsize': productSelectedsize,
      'mainprice': mainprice,
      'totalprice': totalPrice,
      'productimage': productimage,
      'createDate': createDate,
    };
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      productId: productId,
      productname: productname,
      quantity: quantity,
      productSelectedcolor: productSelectedcolor,
      productSelectedsize: productSelectedsize,
      mainprice: mainprice,
      totalPrice: totalPrice,
      productimage: productimage,
      createDate: createDate,
    );
  }*/
