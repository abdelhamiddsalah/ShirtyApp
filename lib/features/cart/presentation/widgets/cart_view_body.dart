import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/cart/presentation/widgets/container_in_cart.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is CartItemRemoved) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم إزالة المنتج من السلة')),
            );
          } else if (state is CartCleared) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم مسح السلة')),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () => _showClearCartDialog(context),
                            child: Text(
                              'إزالة الكل',
                              style: TextStyles.authtitle.copyWith(
                                fontSize: screenWidth * 0.04,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      if (state is CartLoaded) ...[
                        if (state.cart.items.isEmpty)
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.white.withOpacity(0.5)),
                                  SizedBox(height: 16),
                                  Text("السلة فارغة", style: TextStyle(color: Colors.white, fontSize: 18)),
                                ],
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.cart.items.length,
                              itemBuilder: (context, index) {
                                final item = state.cart.items[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                                  child: ContainerIncart(
                                    productId: item.product.productId!,
                                    productName: item.product.name ?? '',
                                    size: item.selectedSize ?? 'XL',
                                    color: item.selectedColor ?? 'black',
                                    price: double.parse(item.product.price ?? '0'),
                                    onRemove: () => context.read<CartCubit>().removeFromCart(item.product.productId!),
                                  ),
                                );
                              },
                            ),
                          ),
                      ] else
                        Expanded(child: Center(child: CircularProgressIndicator())),
                    ],
                  ),
                ),
              ),
              if (state is CartLoaded)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTotalRow('المجموع الفرعي', '${state.cart.subtotal.toStringAsFixed(2)} د.ك'),
                        SizedBox(height: 8),
                        _buildTotalRow('رسوم التوصيل', '${state.cart.shippingCost.toStringAsFixed(2)} د.ك'),
                        Divider(color: Colors.white.withOpacity(0.1), height: 24),
                        _buildTotalRow('المجموع', '${state.cart.total.toStringAsFixed(2)} د.ك', isTotal: true),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: state.cart.items.isEmpty ? null : () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text('متابعة الدفع', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withOpacity(isTotal ? 1 : 0.7), fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(color: Colors.white, fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تأكيد'),
        content: Text('هل أنت متأكد من رغبتك في إزالة جميع المنتجات من السلة؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('إلغاء')),
          TextButton(
            onPressed: () {
              context.read<CartCubit>().clearCart();
              Navigator.pop(context);
            },
            child: Text('تأكيد', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
