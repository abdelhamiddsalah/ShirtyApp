import 'package:clothshop/config/extentions/extension.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/home/presentation/widgets/details_view_body.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartInDetails extends StatelessWidget {
  const AddToCartInDetails({
    super.key,
    required this.selectedSize,
    required this.selectedColor,
    required this.widget,
  });

  final String? selectedSize;
  final String? selectedColor;
  final DetailsViewBody widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrdersCubit>(),
      child: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrdersLoaded) {
            successmessage(context, 'Added to cart successfully');
          } else if (state is OrdersError) {
            errormessage(context, 'Failed to add to cart');
          }
        },
        builder: (context, state) {
          return state is OrdersLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    if (selectedSize == null || selectedColor == null) {
                      errormessage(context, 'Please select size and color');
                      return;
                    }

                    context.read<OrdersCubit>().addtocart(AddtocartModel(
                          productId: widget.product.productId,
                          quantity: 1,
                          productname: widget.product.name,
                          mainprice: widget.product.price.toDouble(),
                          productimage: widget.product.image,
                          productSelectedcolor: selectedColor!,
                          productSelectedsize: selectedSize!,
                          createDate: DateTime.now().toString(),
                          totalprice: widget.product.price.toDouble(),
                          widget.product.salescount ?? 1,
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.product.price}',
                        style: TextStyles.textinhome,
                      ),
                      const Text('Add to Cart', style: TextStyles.textinhome),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
