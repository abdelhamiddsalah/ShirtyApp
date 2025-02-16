class Addtocart {
  final String productId;
  final String productname;
  final int quantity;
  final String productSelectedcolor;
  final String productSelectedsize;
  final double mainprice;
  final double totalprice;
  final String productimage;
  final String createDate;


  Addtocart({
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
}