import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/main_screen_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<MainScreenProvider>(builder: (context, mainscreen, _) {
        return ListView(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            DrawerListTile(
              // color the selected item
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashboard.svg",
              press: () {
                context.read<MainScreenProvider>().onItemTapped(0);
              },
              selected: (context.read<MainScreenProvider>().selectedIndex == 0)
                  ? true
                  : false,
            ),
            const SizedBox(height: 5),
            DrawerListTile(
              title: "Barang",
              svgSrc: "assets/icons/drop_box.svg",
              press: () {
                context.read<MainScreenProvider>().onItemTapped(1);
              },
              selected: (context.read<MainScreenProvider>().selectedIndex == 1)
                  ? true
                  : false,
            ),
            const SizedBox(height: 5),
            DrawerListTile(
              title: "Penjualan",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                context.read<MainScreenProvider>().onItemTapped(2);
              },
              selected: (context.read<MainScreenProvider>().selectedIndex == 2)
                  ? true
                  : false,
            ),
            const SizedBox(height: 5),
            DrawerListTile(
              title: "Task",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {},
            ),
            const SizedBox(height: 5),
            DrawerListTile(
              title: "Documents",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {},
            ),
            const SizedBox(height: 5),
            DrawerListTile(
              title: "Store",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {},
            ),
            const SizedBox(height: 5),
            DrawerListTile(
              title: "Notification",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {},
            ),
            const SizedBox(height: 5),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {},
            ),
            const SizedBox(height: 5),
            DrawerListTile(
              title: "Settings",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {},
            ),
          ],
        );
      }),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    this.selected = false,
  }) : super(key: key);

  final String title, svgSrc;
  final bool selected;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
        builder: (context, mainscreenprovider, _) {
      return ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        tileColor: selected
            ? const Color.fromARGB(157, 224, 228, 3)
            : Colors.transparent,
        leading: SvgPicture.asset(
          svgSrc,
          colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
          height: 16,
        ),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white54, fontWeight: FontWeight.bold),
        ),
      );
    });
  }
}
