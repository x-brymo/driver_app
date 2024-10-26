import 'package:driver_app/features/delivery_history_screen/blocs/delivery_history_bloc.dart';
import 'package:driver_app/features/export_features.dart';
import 'package:driver_app/features/income_statistic_screen/blocs/income_statistic_bloc.dart';
import 'package:driver_app/features/login_screen/bloc/auth_bloc.dart';
import 'package:driver_app/features/notification_screen/blocs/driver_notification_bloc.dart';
import 'package:driver_app/features/order_screen/blocs/order_bloc.dart';
import 'package:driver_app/features/participation_screen/blocs/participation_bloc.dart';
import 'package:driver_app/features/peding_order_screen/blocs/peding_order_bloc.dart';
import 'package:driver_app/features/profile_screen/blocs/profile_bloc.dart';
import 'package:driver_app/features/register_screen/blocs/register_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'configs/configs_export.dart';
import 'features/home_screen/blocs/blocs_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  // Bloc.observer = SimpleBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
      
  runApp(DeliveryApp(
    appRouter: AppRouter(),
  ));
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({
    super.key,
    required this.appRouter
  });
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => DrawerBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => PedingOrderBloc()),
        BlocProvider(create: (context) => DeliveryHistoryBloc()),
        BlocProvider(create: (context) => DriverNotificationBloc()),
        BlocProvider(create: (context) => IncomeStatisticBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => ParticipationBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
      ], 
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.screenName,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    )
    ;
  }
}