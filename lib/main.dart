import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/src/presentation/state_management/login_provider.dart';
import 'package:task2/src/presentation/state_management/signup_provider.dart';
import 'package:task2/src/presentation/state_management/theme_provider.dart';
import 'package:task2/src/presentation/state_management/user_profile_provider.dart';
import 'package:task2/src/presentation/views/authentication/login_screen.dart';
import 'package:task2/src/presentation/views/authentication/sign_up_screen.dart';
import 'package:task2/src/presentation/views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => LoginProvider()),
            ChangeNotifierProvider(create: (_) => SignupProvider()),
            ChangeNotifierProvider(create: (_) => ThemeChanger()),

          ],

      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(

        builder: (context,_data,child){
          _data.getUser();

    final themeChanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
    title: 'Dark Theme Demo',
    themeMode: themeChanger.getTheme,
    theme: ThemeData(
    brightness: Brightness.light,

      primarySwatch: Colors.blue,
    ),
    darkTheme: ThemeData(
    brightness: Brightness.dark,
    ),
          home:_data.user==null?SignUp(): MyHomePage(),
        );
      }
    );
  }
}
