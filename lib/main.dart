import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/routes/router.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}