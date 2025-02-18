import 'package:clothshop/core/widgets/product_item.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:clothshop/features/home/presentation/screens/details_view.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewInProducts extends StatelessWidget {
  const NewInProducts({super.key, required this.screenHeight});
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                       Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsView(product: state.products[index]),
                                      ),
                                    );
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
