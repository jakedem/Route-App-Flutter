import 'package:flutter/material.dart';
import 'package:routeapp/routes_dir/map_google.dart';
import 'package:routeapp/authentication_dir/sign_in_screen.dart';
import 'package:routeapp/user_dir/user_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:routeapp/routes_dir/sidenav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const RouteApp());
}

class RouteApp extends StatefulWidget {
  const RouteApp({Key? key}) : super(key: key);

  @override
  State<RouteApp> createState() => _RouteAppState();
}

class _RouteAppState extends State<RouteApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, 
    home: SignInScreen());
  }
}
