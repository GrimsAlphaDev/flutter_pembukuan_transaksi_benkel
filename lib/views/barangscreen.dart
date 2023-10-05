import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/barang_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/header.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/constant/constant.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BarangScreen extends StatefulWidget {
  const BarangScreen({super.key});

  @override
  State<BarangScreen> createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<BarangProvider>().getBarang();
    });
  }

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
            Text(
              "Table Barang Stok",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(children: [
                    Consumer<BarangProvider>(
                      builder: (context, barang, _) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text("No")),
                              DataColumn(label: Text("Nama Barang")),
                              DataColumn(label: Text("Merek")),
                              DataColumn(label: Text("Kategori Barang")),
                              DataColumn(label: Text("Deskripsi Barang")),
                              DataColumn(label: Text("Harga Barang")),
                              DataColumn(label: Text("Stok")),
                              DataColumn(label: Text("Total Harga")),
                              DataColumn(label: Text("Dibuat Pada")),
                              DataColumn(label: Text("Diupdate Terakhir")),
                              DataColumn(label: Text("Aksi")),
                            ],
                            rows: [
                              for (var i = 0;
                                  i < barang.barangResponse.length;
                                  i++)
                                DataRow(cells: [
                                  DataCell(Text((i + 1).toString())),
                                  DataCell(Text(
                                      barang.barangResponse[i].nama_barang)),
                                  DataCell(
                                      Text(barang.barangResponse[i].merek)),
                                  DataCell(Text(barang
                                      .barangResponse[i].kategori_barang)),
                                  DataCell(Text(barang
                                      .barangResponse[i].deskripsi_barang)),
                                  DataCell(Text((NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(barang
                                          .barangResponse[i].harga_barang)))),
                                  DataCell(Text(barang
                                      .barangResponse[i].stok_barang
                                      .toString())),
                                  DataCell(Text(
                                    (NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(barang.barangResponse[i]
                                                .harga_barang *
                                            barang.barangResponse[i]
                                                .stok_barang)),
                                  )),
                                  DataCell(Text(
                                      barang.barangResponse[i].created_at)),
                                  DataCell(Text(
                                      barang.barangResponse[i].updated_at)),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )),
                                ]),
                            ], // Your data rows go here
                          ),
                        );
                      },
                    ),
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
