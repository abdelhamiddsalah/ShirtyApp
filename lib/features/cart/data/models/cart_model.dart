import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';

class CartModel {
  final String productId;
  final String productname;
  final int quantity;
  final String productSelectedcolor;
  final String productSelectedsize;
  final double mainprice;
  final double totalprice;
  final String productimage;
  final String createDate;


  CartModel({
    required this.productId,
    required this.productname,
    required this.quantity,
    required this.productSelectedcolor,
    required this.productSelectedsize,
    required this.mainprice,
    required this.totalprice,
    required this.productimage,
    required this.createDate,
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
       totalprice: json['totalprice'],
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
      'totalprice': totalprice,
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
      totalPrice: totalprice,
      productimage: productimage,
      createDate: createDate,
    );
  }


}