import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/network/network_info.dart';
import 'package:clothshop/core/services/firebase_add_services.dart';
import 'package:clothshop/features/cart/data/datasources/local_datasource_cart.dart';
import 'package:clothshop/features/cart/data/datasources/remote_datasource_cart.dart';
import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/repositories/cart_repositry.dart';
import 'package:dartz/dartz.dart';

class CartRepositryImpl extends CartRepositry{
  final RemoteDatasourceCart remoteDatasourceCart;
  final LocalDatasourceCart localDatasourceCart;
  final NetworkInfo networkInfo;
  final FirebaseAddServices firebaseAddServices;

  CartRepositryImpl(this.networkInfo, this.firebaseAddServices, {required this.remoteDatasourceCart,required this.localDatasourceCart});
  @override
    Future<Either<Failure, List<CartItemEntity>>> getcarts() async {
    if (await networkInfo.isConnected) {
      return _fetchRemoteCarts();
    } 
    return _getLocalCarts();
  }


   Future<Either<Failure, List<CartItemEntity>>> _fetchRemoteCarts() async {
    try {
      final carts = await remoteDatasourceCart.getCart();
      await localDatasourceCart.cacheCarts(carts);
      return Right(carts.map((cart) => cart.toEntity()).toList()); // تحويل CartModel إلى CartItemEntity
    } catch (e) {
      return await _getLocalCarts();
    }
  }

  Future<Either<Failure, List<CartItemEntity>>> _getLocalCarts() async {
  try {
    final carts = await localDatasourceCart.getlocalcarts();
    if (carts.isEmpty) {
      return const Left(CacheFailure('No cached data available'));
    }
    return Right(carts.map((cart) => cart.toEntity()).toList()); // ✅ التصحيح الصحيح
  } catch (e) {
    return Left(CacheFailure('Failed to retrieve cached data: ${e.toString()}'));
  }
}

  
  
  
   @override
  Future<Either<Failure, CartItemEntity>> addtocart(CartItemEntity cartItem, String userId) async {
    try {
     
    final CartItemModel cartItemModel = CartItemModel(
      selectedColor: cartItem.selectedColor,
      selectedSize: cartItem.selectedSize,
      quantity: cartItem.quantity,
      totalPrice: cartItem.totalPrice,
      name: cartItem.name,
      image: cartItem.image,
      price: cartItem.price,
      id: cartItem.id,
    );
      await firebaseAddServices.addCartItem(cartItemModel, userId);
      return Right(cartItem); // إرجاع CartItemEntity وليس CartItemModel
    } catch (e) {
      return Left(CacheFailure('Failed to add product to cart: ${e.toString()}'));
    }
  }
  
  
@override
Future<Either<Failure, List<CartItemEntity>>> deletecart(String cartId,String selectedSize, String selectedColor) async {
  try {
    await firebaseAddServices.deletecart(cartId, selectedSize, selectedColor);
    return Right([]);
  } catch (e) {
    return Left(CacheFailure('Failed to delete product from cart: ${e.toString()}'));
  }
}


}
