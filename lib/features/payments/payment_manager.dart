import 'package:clothshop/features/payments/payment_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManager {
 static Future<void> makePayment(int amount, String currency) async {
  try {
    String clientSecret = await _getClientSecret(amount * 100, currency); // ✅ التأكد من تحويل amount إلى cent كعدد صحيح
    await initialize(clientSecret);
    await Stripe.instance.presentPaymentSheet();
  } on StripeException  catch (e) {
    
     if (e.error.code == FailureCode.Canceled) {
        print("🔴 المستخدم قام بإلغاء الدفع.");
        return; // لا ترمي استثناء، فقط اخرج بهدوء
      }
      throw Exception('Failed to make payment: ${e.error.localizedMessage}');
  } on Exception catch (e) {
    throw Exception('Failed to make payment: $e');
  }
}


 static Future<void> initialize(String clientSecret)async{
  await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
    paymentIntentClientSecret: clientSecret,
    merchantDisplayName: 'Cloth Shop'
   ));
 }
static Future<String> _getClientSecret(int amount, String currency) async {
  Dio dio = Dio();

  final data = {
    'amount': amount.toString(),  // تأكد أن amount يتم تحويله إلى نص بشكل صحيح
    'currency': currency,
    'payment_method_types[]': 'card' // ✅ تصحيح الخطأ في `payment_method_types`
  };

  final response = await dio.post(
    'https://api.stripe.com/v1/payment_intents',
    options: Options(
      headers: {
        'Authorization': 'Bearer ${ApiKeys.secretKey}', // ✅ المفتاح السري الصحيح
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    ),
    data: data,
  );

  print('Response Data: ${response.data}'); // ✅ لطباعة تفاصيل الاستجابة وفحص الخطأ

  return response.data['client_secret'];
}

}