import 'package:clock_app/enums.dart';
import 'package:clock_app/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.red,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock),
          child: HomePage(),
      ),
    );
  }
}

