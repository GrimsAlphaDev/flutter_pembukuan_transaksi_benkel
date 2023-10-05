import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/main_screen_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/menu_app_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/barangscreen.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/responsive.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/side_menu.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/dashboardscreen.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/penjualanscreen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList = const [
    DashboardScreen(),
    BarangScreen(),
    PenjualanScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<MainScreenProvider>().getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
        builder: (context, mainscreenprovider, _) {
      return Scaffold(
        key: context.read<MenuAppProvider>().scaffoldKey,
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
