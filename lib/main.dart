import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'global/preferences.dart';
import 'locator/locator.dart';
import 'router/app_router.dart';
import 'router/route_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  final Preferences prefs = locator<Preferences>();
  await prefs.init();
  runApp(Phoenix(child: const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Grootan',
    );
  }
}