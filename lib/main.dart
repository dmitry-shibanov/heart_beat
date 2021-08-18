import 'package:flutter/material.dart';
import 'package:flutter_heart/db/database.dart';
import 'package:flutter_heart/pages/navigation_page.dart';
import 'package:flutter_heart/pages/onBoarding_page.dart';
import 'package:flutter_heart/pages/settings_page.dart';
import 'package:flutter_heart/pages/splash_screen.dart';
import 'package:flutter_heart/providers/data_helper.dart';
import 'package:flutter_heart/providers/main_page_provider.dart';
import 'package:flutter_heart/providers/pulse_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => OnBoarding(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => PulseProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProxyProvider<DatabaseProvider, DbHelper>(
          create: (context) => DbHelper([], null),
          update: (context, db, previous) => DbHelper(previous?.records, db),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Heart Rate Monitor: bpm | bpm',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "Montserrat",
            scaffoldBackgroundColor: Color.fromRGBO(253, 254, 255, 1),
          ),
          home: AnimatedSwitcher(
            duration: Duration(milliseconds: 2000),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(scale: animation, child: child),
            child: MyHomePage(),
          ),
          routes: {
            '/splash': (ctx) => SplashScreen(),
            '/onBoarding': (ctx) => OnBoarding(),
            '/main': (cts) => Intro(),
            '/settings': (ctx) => SettingsPage()
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (ctx, db, child) {
      print("db.isOpen ${db.isOpen}");
      if (db.isOpen) {
        return OnBoarding();
      } else {
        return SplashScreen();
      }
    });
  }
}
