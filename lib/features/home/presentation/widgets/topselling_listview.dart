import 'package:clothshop/core/widgets/product_item.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopsellingListview extends StatelessWidget {
  const TopsellingListview({super.key, required this.screenHeight});

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsCubit>()..getNewProducts(),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoaded) {
               return SizedBox(
            height: screenHeight * 0.32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics:
                  const BouncingScrollPhysics(), // تغيير الـ physics للسماح بالـ scroll
              itemCount: state.products.length,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/product_details');
                      },
                      child: ProductItem(
                        productEntity: state.products[index],
                      ),
                    ),
                  ),
            ),
          );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
