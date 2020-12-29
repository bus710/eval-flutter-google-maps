import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'rootPage.dart';
import 'rootModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pacific",
      // theme: ,
      home: ChangeNotifierProvider<RootModel>(
        create: (_) => RootModel(),
        child: RootPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
