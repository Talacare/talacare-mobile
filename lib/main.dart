import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/core/interceptors/dio_interceptor.dart';
import 'package:talacare/presentation/pages/home_page.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';

import 'firebase_options.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await di.init();
  di.getIt<Dio>().interceptors.add(DioInterceptor());
  di.getIt<AuthProvider>().getLocalStoredUser();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              return const HomePage();
            }
          },
        ),
      ),
    );
  }
}
