import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/header.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/constant/constant.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(children: const [
                    SizedBox(height: defaultPadding),
                    Placeholder(),
                    SizedBox(height: defaultPadding),
                    Placeholder(),
                    SizedBox(height: defaultPadding),
                    Placeholder(),
                    SizedBox(height: defaultPadding),
                    Placeholder(),
                    SizedBox(height: defaultPadding),
                    Placeholder(),
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
