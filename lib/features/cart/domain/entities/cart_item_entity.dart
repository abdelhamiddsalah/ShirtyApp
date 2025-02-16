import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable{
  final String productId;
  final String productname;
  final int quantity;
  final String productSelectedcolor;
  final String productSelectedsize;
  final double mainprice;
  final double totalprice;
  final String productimage;
  final String createDate;


  CartItemEntity({
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

  @override
  List<Object?> get props => [
    productId,
    productname,
    quantity,
    productSelectedcolor,
    productSelectedsize,
    mainprice,
    totalprice,
    productimage,
    createDate,
  ];
}