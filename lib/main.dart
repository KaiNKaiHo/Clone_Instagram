import 'package:clone_again/resources/auth_methods.dart';
import 'package:clone_again/responsive/mobile_screen_layout.dart';
import 'package:clone_again/responsive/responsive_layout_screen.dart';
import 'package:clone_again/responsive/web_creen_layout.dart';
import 'package:clone_again/screen/login_screen.dart';
import 'package:clone_again/screen/signup_screen.dart';
import 'package:clone_again/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCqWbWlBOFTmODXlLLe0kNRH7NxsYXBnS4",
        appId: "1:99857749079:web:844e3e79a074cac208ff12",
        messagingSenderId: "99857749079",
        projectId: "new-insta-clone-4ece3",
        storageBucket: "new-insta-clone-4ece3.appspot.com",
      ),
    );
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
      debugShowCheckedModeBanner: false,
      title: 'Instagram clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      //home: ResponsiveLayout(
      //  mobileScreenLayout: MobileScreenLayout(),
      //  webScreenLayout: WebScreenLayout(),
      //),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
