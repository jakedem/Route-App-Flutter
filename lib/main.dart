import 'package:flutter/material.dart';
//import 'package:routeapp/routes_dir/map_google.dart';
import 'package:routeapp/authentication_dir/sign_in_screen.dart';
//import 'package:routeapp/user_dir/user_profile.dart';

void main() {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
