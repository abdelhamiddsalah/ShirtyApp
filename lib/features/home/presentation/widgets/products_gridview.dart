import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/widgets/product_item.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:clothshop/features/home/presentation/screens/details_view.dart';
import 'package:clothshop/features/home/presentation/widgets/product_grid_skeleton.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.path2,
    required this.documentId,
  });

  final String path2;
  final String documentId;

  // Helper method to safely parse price
  double _parsePrice(String? price) {
    if (price == null || price.isEmpty) {
      return 0.0;
    }
    try {
      return double.parse(price);
    } catch (e) {
      log('Error parsing price: $price');
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocProvider(
                create: (context) =>
                    sl<ProductsCubit>()..getProducts('categories', path2, documentId),
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                            child: Row(
                              children: [
                                const Text(
                                  'Hoodies',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  ' (${state.products.length})',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: state.products.length,
                              itemBuilder: (context, index) {
                                final ProductEntity product = state.products[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsView(product: product),
                                      ),
                                    );
                                  },
                                  child: ProductItem(
                                    productName: product.name ?? 'Unnamed Product',
                                    price: _parsePrice(product.price),
                                    imageUrl: product.image ?? '',
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is ProductsError) {
                      return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                    }
                    return const ProductGridSkeleton();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}