import 'package:buyhive/screens/home.dart';
import 'package:buyhive/screens/login.dart';
import 'package:buyhive/screens/product.dart';
import 'package:buyhive/screens/productlist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProductListPage(),
  ));
}
