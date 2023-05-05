import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machinetest/screens/navitems.dart';
import 'package:machinetest/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedData = prefs.getString('userData');
  Widget homeScreen = storedData != null ? NavItems() : LoginScreen();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: homeScreen,
  ));
}
