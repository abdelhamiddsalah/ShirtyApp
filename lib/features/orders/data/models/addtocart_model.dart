import 'package:clothshop/features/orders/domain/entities/addtocart.dart';

class AddtocartModel extends Addtocart{
  AddtocartModel(super.salescount, {
    required super.productId,
     required super.productname,
      required super.quantity,
       required super.productSelectedcolor,
        required super.productSelectedsize,
         required super.mainprice,
          required super.totalprice,
           required super.productimage,
            required super.createDate
            });

  factory AddtocartModel.fromJson(Map<String, dynamic> json) {
    return AddtocartModel(
       json['salescount'] ?? '',
      productId: json['productId'] ?? '',
      productname: json['productname']  ?? '',
      quantity: json['quantity'] ?? '',
      productSelectedcolor: json['productSelectedcolor'] ?? '',
      productSelectedsize: json['productSelectedsize'] ?? '',
      mainprice: json['mainprice'] ?? '',
      totalprice: json['totalprice'] ?? '',
      productimage: json['productimage'] ?? '',
      createDate: json['createDate'] ?? '',
    );
  }

  toJson() {
    return {
      'salescount': salescount,
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
  
}