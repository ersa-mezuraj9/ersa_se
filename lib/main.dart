import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:nukdi4/features/admin/screens/admin_screen.dart';
import 'package:nukdi4/features/home/screens/home_screen.dart';
import 'package:nukdi4/features/auth/screens/auth_screen.dart';
import 'package:nukdi4/features/auth/services/auth_service.dart';
import 'package:nukdi4/constants/global_variables.dart';
import 'package:nukdi4/common/widgets/bottom_bar.dart';
import 'package:nukdi4/common/widgets/onboarding_screen.dart';
import 'package:nukdi4/provider/user_provider.dart';
import 'package:nukdi4/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'carapp',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),

      // 👇 Always show onboarding screen first
      home: const OnboardingScreen(),
    );
  }
}
