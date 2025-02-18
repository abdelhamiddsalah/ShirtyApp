import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/widgets/custom_bottom_nav.dart';
import 'package:clothshop/features/authintication/presentation/screens/forgetpassword_view.dart';
import 'package:clothshop/features/authintication/presentation/screens/login_view.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/cart/presentation/screens/cart_view.dart';
import 'package:clothshop/features/checkout/presentation/screens/checkout_view.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/presentation/screens/details_view.dart';
import 'package:clothshop/features/home/presentation/screens/search_view.dart';
import 'package:clothshop/features/home/presentation/widgets/shop_by_categories.dart';
import 'package:clothshop/features/onboarding/presentation/screens/onboarding_view.dart';
import 'package:clothshop/features/profile/presentation/screens/profile_view.dart';
import 'package:clothshop/features/splashscreen/presentation/screens/splashscreen_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashscreenView(),
        );
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (context) => const SignupView());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const Salmon());
      case Routes.search:
        return MaterialPageRoute(builder: (context) => const SearchView());
      case Routes.forgetpassword:
        return MaterialPageRoute(
          builder: (context) => const ForgetpasswordView(),
        );
      case Routes.onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingView());
      case Routes.cart:
        return MaterialPageRoute(
          builder:
              (context) => const CartView(),
        );
      case Routes.details:
        final product = settings.arguments as ProductEntity?;
        if (product == null) {
          return _errorRoute(settings.name);
        }
        return MaterialPageRoute(
          builder:
              (context) => DetailsView(product: product),
        );
      case Routes.shopbycategories:
        return MaterialPageRoute(
          builder: (context) => const ShopByCategories(),
        );
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => const ProfileView());
      case Routes.checkout:
        return MaterialPageRoute(builder: (context) => const CheckoutView());

      default:
        return _errorRoute(settings.name);
    }
  }

  Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (context) => ErrorPage(routeName: routeName),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String? routeName;
  const ErrorPage({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'No route defined for $routeName',
          style: TextStyles.authtitle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
