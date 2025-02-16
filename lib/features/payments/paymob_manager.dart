import 'package:dio/dio.dart' as dio;

class PaymobManager {
  Future<String> makePayment(int amount, String currency) async {
    // Implement the logic to make the payment using Paymob API
    // Return the payment token
    String AuthinticationToken = await _getAuthToken();
    return 'payment_token';
  }

  Future <String> _getAuthToken() async {
  final dio.Response response = await dio.Dio().post(
      'https://accept.paymob.com/api/auth/tokens',
      data: {
        'username': 'YOUR_USERNAME',
        'password': 'YOUR_PASSWORD',
      },
    );
     return response.data['token'];
  }
}