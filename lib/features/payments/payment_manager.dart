import 'package:clothshop/features/payments/payment_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManager {
 static Future<void> makePayment(int amount, String currency)async{
  try {
  String clientSecret=await
   _getClientSecret((amount * 100).toString(), currency);
  await initialize(clientSecret);
  await Stripe.instance.presentPaymentSheet();
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
 static Future<String> _getClientSecret(String amount,String currency)async{
 Dio dio=Dio();
 final response= await dio.post('https://api.stripe.com/v1/payment_intents',
 options: Options(
  headers: {
    'Authorization': 'Bearer ${ApiKeys.publisibleKey}',
    'Content-Type':'application/x-www-form-urlencoded'
  }
 ),
 data: {
   'amount':amount,
   'currency':currency,
   'payment_method_types':[
     'card'
   ]
 });
 return response.data['client_secret'];
 }
}