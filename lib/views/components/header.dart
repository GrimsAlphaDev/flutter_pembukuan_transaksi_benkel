import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/barang_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/logout_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/main_screen_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/menu_app_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/responsive.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/constant/constant.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/loginscreen.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuAppProvider>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            (context.read<MainScreenProvider>().selectedIndex == 0)
                ? "Dashboard"
                : (context.read<MainScreenProvider>().selectedIndex == 1)
                    ? "Barang"
                    : (context.read<MainScreenProvider>().selectedIndex == 2)
                        ? "Penjualan"
                        : "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        // const Expanded(child: SearchFieldProduct()),
        (context.read<MainScreenProvider>().selectedIndex == 1)
            ? const Expanded(child: SearchFieldProduct())
            : const SizedBox(),
        const SizedBox(width: defaultPadding),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ElevatedButton(
        onPressed: () {
          // confirmation alert
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Logout"),
                content: const Text("Are you sure want to logout?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      // user = context.read<MainScreenProvider>().user.id;
                      // remove token from shared preferences
                      await context.read<LogoutProvider>().logout(
                          context: context,
                          id: context.read<MainScreenProvider>().user!.id);
                      // ignore: use_build_context_synchronously
                      if (!context.mounted) return;
                      if (context
                              .read<LogoutProvider>()
                              .logoutResponse['status'] ==
                          'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Berhasil Logout'),
                          ),
                        );
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ));
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Gagal Logout'),
                          ),
                        );
                      }
                    },
                    child: const Text("Logout"),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // dropdown menu
        child: Row(
          children: const [
            Text(
              "Logout ",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchFieldProduct extends StatefulWidget {
  const SearchFieldProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchFieldProduct> createState() => _SearchFieldProductState();
}

class _SearchFieldProductState extends State<SearchFieldProduct> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        // suffixIcon: InkWell(
        //   onTap: () {},
        //   child: Container(
        //     padding: const EdgeInsets.all(defaultPadding * 0.75),
        //     margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        //     decoration: const BoxDecoration(
        //       color: primaryColor,
        //       borderRadius: BorderRadius.all(Radius.circular(10)),
        //     ),
        //     child: SvgPicture.asset("assets/icons/Search.svg"),
        //   ),
        // ),
      ),
      onChanged: (value) {
        context.read<BarangProvider>().searchBarang(value);
      },
    );
  }
}
