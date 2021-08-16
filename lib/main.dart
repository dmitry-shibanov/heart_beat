import 'package:flutter/material.dart';
import 'package:flutter_heart/components/circlePainter.dart';
import 'package:flutter_heart/db/database.dart';
import 'package:flutter_heart/pages/onBoarding.dart';
import 'package:flutter_heart/pages/settings.dart';
import 'package:flutter_heart/pages/splash.dart';
import 'package:flutter_heart/providers/data_helper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProxyProvider<DatabaseProvider, DbHelper>(
          create: (context) => DbHelper([], null),
          update: (context, db, previous) => DbHelper(previous?.recipes, db),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Enjoying Heart Rate Monitor: bpm | bpm',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "Montserrat",
            scaffoldBackgroundColor: Color.fromRGBO(253, 254, 255, 1),
          ),
          home: MyHomePage(),
          routes: {
            '/splash': (ctx) => SplashScreen(),
            '/onBoarding': (ctx) => OnBoarding(),
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
