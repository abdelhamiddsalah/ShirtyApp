import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/widgets/product_item.dart';
import 'package:clothshop/features/home/presentation/cubit/topsellingandnewin/cubit/topsellingandnewin_cubit.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class TopsellingListview extends StatelessWidget {
  const TopsellingListview({super.key, required this.screenHeight});

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TopsellingandnewinCubit>()..gettopsellingproduct(),
      child: BlocBuilder<TopsellingandnewinCubit, TopsellingandnewinState>(
        builder: (context, state) {
          if (state is TopsellingandnewinLoaded) {
            return SizedBox(
              height: screenHeight * 0.32,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: state.topsellingandnewincubit.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
      Routes.details,
      extra: state.topsellingandnewincubit[index],
    );
                    },
                    child: ProductItem(productEntity: state.topsellingandnewincubit[index]),
                  ),
                ),
              ),
            );
          } else {
            return _buildShimmerListView();
          }
        },
      ),
    );
  }

  Widget _buildShimmerListView() {
    return SizedBox(
      height: screenHeight * 0.32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5, 
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: screenHeight * 0.32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
