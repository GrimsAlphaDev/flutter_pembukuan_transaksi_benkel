import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/main_screen_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/responsive.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/side_menu.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/dashboardscreen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [
    DashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
        builder: (context, mainscreenprovider, _) {
      return Scaffold(
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                const Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: pageList[mainscreenprovider.selectedIndex],
              ),
            ],
          ),
        ),
      );
    });
  }
}
