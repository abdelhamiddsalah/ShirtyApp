import 'dart:convert';
import 'package:clothshop/features/cart/data/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatasourceCart {
   Future<List<CartModel>> getlocalcarts();
  Future<void> cacheCarts(List<CartModel> carts);
}

class LocalDatasourceCartImpl implements LocalDatasourceCart {
    final SharedPreferences sharedPreferences;
  static const String CACHED_CARTS_KEY = 'cached_carts';
  LocalDatasourceCartImpl(this.sharedPreferences);
  @override
  Future<List<CartModel>> getlocalcarts() async{
    final String? cartsjson = sharedPreferences.getString(CACHED_CARTS_KEY);
    if (cartsjson != null) {
      List<dynamic> decodedList = json.decode(cartsjson);
      return decodedList
          .map((cart) => CartModel.fromJson(cart))
          .toList();
    } else {
      return [];
    }
  }

  @override 
  Future<void> cacheCarts( List<CartModel> carts) async{
    final cartsJson =json.encode(carts.map((cart) => cart.toJson()).toList());
    await sharedPreferences.setString(CACHED_CARTS_KEY, cartsJson);
  }

    bool hasCachedData() {
    final String? categoriesJson = sharedPreferences.getString(CACHED_CARTS_KEY);
    return categoriesJson != null && categoriesJson.isNotEmpty;
  }

}