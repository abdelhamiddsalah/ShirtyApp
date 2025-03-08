import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/widgets/custom_bottom_nav.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:clothshop/features/reviews/presentation/widgets/reviews_view_body.dart';

import 'package:clothshop/features/authintication/presentation/screens/forgetpassword_view.dart';
import 'package:clothshop/features/authintication/presentation/screens/login_view.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/cart/presentation/screens/cart_view.dart';
import 'package:clothshop/features/checkout/presentation/screens/checkout_view.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/presentation/screens/details_view.dart';
import 'package:clothshop/features/home/presentation/screens/search_view.dart';
import 'package:clothshop/features/home/presentation/widgets/products_gridview.dart';
import 'package:clothshop/features/home/presentation/widgets/shop_by_categories.dart';
import 'package:clothshop/features/onboarding/presentation/screens/onboarding_view.dart';
import 'package:clothshop/features/profile/presentation/screens/profile_view.dart';
import 'package:clothshop/features/splashscreen/presentation/screens/splashscreen_view.dart';

final sl = GetIt.instance;

class AppRouter {
  static final CartCubit cartCubit = sl<CartCubit>();
  static final CategoriesCubit categoriesCubit =
      sl<CategoriesCubit>()..fetchCategories();

  static final ProductsCubit productsCubit = sl<ProductsCubit>();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashscreenView(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: Routes.home,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: cartCubit),
                BlocProvider.value(value: categoriesCubit),
                
              ],
              child: const Salmon(),
            ),
      ),
       GoRoute(
  path: '${Routes.products}/:categoryId',
  builder: (context, state) {
    final categoryId = state.pathParameters['categoryId']!;
    print("Category ID: $categoryId");
    return BlocProvider.value(
      value:  productsCubit..getProducts(categoryId),
      child: ProductsGridView(categoryId: categoryId),
    );
  },
),

      GoRoute(
        path: Routes.search,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: Routes.forgetpassword,
        builder: (context, state) => const ForgetpasswordView(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: Routes.cart,
        builder:
            (context, state) =>
                BlocProvider.value(value: cartCubit, child: const CartView()),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: cartCubit),
              BlocProvider.value(value: productsCubit),
            ],
            child: DetailsView(product: product),
          );
        },
      ),
      GoRoute(
        path: Routes.shopbycategories,
        builder:
            (context, state) => BlocProvider.value(
              value: categoriesCubit,
              child: const ShopByCategories(),
            ),
      ),
      GoRoute(
        path: Routes.profile,
        builder: (context, state) => const ProfileView(),
      ),
  GoRoute(
  path: '/checkout',
  builder: (context, state) => BlocProvider.value(
    value: cartCubit, // استخدام BlocProvider لتوفير CartCubit
    child: const CheckoutView(),
  ),
),


      GoRoute(
        path: '/reviews',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ReviewsView(product: product);
        },
      ),
    ],
    errorBuilder:
        (context, state) => ErrorPage(routeName: state.uri.toString()),
  );
}

class ErrorPage extends StatelessWidget {
  final String? routeName;
  const ErrorPage({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('No route defined for $routeName')),
    );
  }
}
