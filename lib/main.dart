import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fooddeliveryapp/admin/admin_login.dart';
import 'package:flutter_fooddeliveryapp/pages/onboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCYjarDU9cjje70KLsz-YzRxq2BBSEqw_c",
            authDomain: "taxiproj-b2f9d.firebaseapp.com",
            projectId: "taxiproj-b2f9d",
            storageBucket: "taxiproj-b2f9d.appspot.com",
            messagingSenderId: "638749066043",
            appId: "1:638749066043:web:0f7cd2437db1fd09cced1e"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Onboard(),
    );
  }
}
