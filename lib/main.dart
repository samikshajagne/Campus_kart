import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/SplashScreen/splash_screen.dart';

Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyD_c6RYFbKniHdstLtzcOnuXChMtLLkR04',
        appId: '1:457428358175:android:a557ac9ec9e85938bbf12a',
        messagingSenderId: '457428358175',
        projectId: 'campus-cart-419414',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Cart',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen(),
    );
  }
}


