import 'package:driver_app/features/export_features.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case SplashScreen.screenName:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case OtpVerifyScreen.routeName:
        return MaterialPageRoute(builder: (context) => const OtpVerifyScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case OrderScreen.routeName:
        return MaterialPageRoute(builder: (context) => const OrderScreen());
      case PedingOrderScreen.routeName:
        return MaterialPageRoute(builder: (context) => const PedingOrderScreen());
      case DeliveryHistoryScreen.routeName:
        return MaterialPageRoute(builder: (context) => const DeliveryHistoryScreen());
      case NotificationScreen.routeName:
        return MaterialPageRoute(builder: (context) => const NotificationScreen());
      case IncomeStatisticScreen.routeName:
        return MaterialPageRoute(builder: (context) => const IncomeStatisticScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (context) => const AuthScreen());
      default:
        return null;
    }
  }
}