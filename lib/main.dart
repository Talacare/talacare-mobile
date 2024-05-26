import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:dio/dio.dart';
import 'package:talacare/core/constants/app_colors.dart';

import 'package:talacare/core/interceptors/dio_interceptor.dart';
import 'package:talacare/presentation/pages/home_page.dart';
import 'package:talacare/presentation/pages/login_page.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/notification_service.dart';
import 'core/utils/bottom_sheet_util.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;
import 'package:talacare/core/utils/time_tracker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  NotificationService().initNotification();

  await di.init();
  di.getIt<Dio>().interceptors.add(DioInterceptor());
  di.getIt<AuthProvider>().getLocalStoredUser();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late TimeTracker _timeTracker;

  @override
  void initState() {
    super.initState();
    _timeTracker = TimeTracker(onTimeUp: _showBottomSheet);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timeTracker.start();
    });
  }

  @override
  void dispose() {
    _timeTracker.stop();
    super.dispose();
  }

  void _showBottomSheet() {
    if (_navigatorKey.currentState != null) {
      BottomSheetUtil.showBottomSheet(
        context: _navigatorKey.currentState!.context,
        title: 'Kamu sudah bermain selama 2 jam',
        description: 'Silakan tutup aplikasi dan bermain lagi besok, ya!',
        textButton: 'Tutup',
        onTap: () => SystemNavigator.pop(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'TalaCare',
      theme: ThemeData(
        fontFamily: 'Digitalt',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: AppColors.purple,
        ),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => di.getIt<AuthProvider>(),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.user != null) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
