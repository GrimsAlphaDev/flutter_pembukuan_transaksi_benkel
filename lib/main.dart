import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/main_screen_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/menu_app_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/constant/constant.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/mainscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MainScreenProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MenuAppProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pembukuan Bengkel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MainScreen(),
    );
  }
}
