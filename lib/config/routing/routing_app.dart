import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/widgets/custom_bottom_nav.dart';
import 'package:clothshop/features/authintication/presentation/screens/forgetpassword_view.dart';
import 'package:clothshop/features/authintication/presentation/screens/login_view.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/cart/presentation/screens/cart_view.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/presentation/screens/details_view.dart';
import 'package:clothshop/features/home/presentation/widgets/shop_by_categories.dart';
import 'package:clothshop/features/notifications/presentation/screens/notification_view.dart';
import 'package:clothshop/features/onboarding/presentation/screens/onboarding_view.dart';
import 'package:clothshop/features/reviews/presentation/screens/reviews_view.dart';
import 'package:clothshop/features/splashscreen/presentation/screens/splashscreen_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashscreenView());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (context) => const SignupView());
      case Routes.home:
        return MaterialPageRoute(builder: (context) =>  Salmon());
      case Routes.forgetpassword:
        return MaterialPageRoute(builder: (context) => const ForgetpasswordView());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingView());
      case Routes.cart:
        return MaterialPageRoute(builder: (context) => const CartView());
      case Routes.detials:
       final product = settings.arguments as ProductEntity;
        return MaterialPageRoute(builder: (context) =>  DetailsView(product: product,));
      case Routes.reviews:
        return MaterialPageRoute(builder: (context) => const ReviewsView());
      case Routes.shopbycategories:
        return MaterialPageRoute(builder: (context) => const ShopByCategories());
      case Routes.notifications:
        return  MaterialPageRoute(builder: (context) => const NotificationView());
      default:
        return MaterialPageRoute(
          builder: (context) => ErrorPage(routeName: settings.name),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  final String? routeName;
  const ErrorPage({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No route defined for $routeName', style: TextStyles.authtitle,),
      ),
    );
  }
}
