import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/product.dart';
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

  ondispose() {
    namaBarangController.dispose();
    merekController.dispose();
    kategoriBarangController.dispose();
    deskripsiBarangController.dispose();
    hargaBarangController.dispose();
    stokBarangController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController namaBarangController = TextEditingController();
  TextEditingController merekController = TextEditingController();
  TextEditingController kategoriBarangController = TextEditingController();
  TextEditingController deskripsiBarangController = TextEditingController();
  TextEditingController hargaBarangController = TextEditingController();
  TextEditingController stokBarangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: 40),
            Text(
              "Table Barang",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // tambah product button
                ElevatedButton.icon(
                  onPressed: () {
                    // open bottom sheet
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    const Text(
                                      "Tambah Barang",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: namaBarangController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Nama Barang",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Nama Barang tidak boleh kosong";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: merekController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Merek",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Merek tidak boleh kosong";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: kategoriBarangController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Kategori Barang",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Kategori Barang tidak boleh kosong";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: deskripsiBarangController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Deskripsi Barang",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Deskripsi Barang tidak boleh kosong";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: hargaBarangController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Harga Barang",
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: stokBarangController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Stok Barang",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Stok Barang tidak boleh kosong";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          // print(namaBarangController.text);
                                          // print(merekController.text);
                                          // print(kategoriBarangController.text);
                                          // print(deskripsiBarangController.text);
                                          // print(hargaBarangController.text);
                                          // print(stokBarangController.text);
                                          context
                                              .read<BarangProvider>()
                                              .createBarang(
                                                  barang: Product(
                                                created_at:
                                                    DateTime.now().toString(),
                                                updated_at:
                                                    DateTime.now().toString(),
                                                nama_barang:
                                                    namaBarangController.text,
                                                deskripsi_barang:
                                                    deskripsiBarangController
                                                        .text,
                                                harga_barang: int.parse(
                                                    hargaBarangController.text),
                                                kategori_barang:
                                                    kategoriBarangController
                                                        .text,
                                                merek: merekController.text,
                                                stok_barang: int.parse(
                                                    stokBarangController.text),
                                              ))
                                              .then((value) {
                                            if (value) {
                                              namaBarangController.clear();
                                              merekController.clear();
                                              kategoriBarangController.clear();
                                              deskripsiBarangController.clear();
                                              hargaBarangController.clear();
                                              stokBarangController.clear();
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Berhasil menambahkan barang'),
                                                ),
                                              );
                                            } else {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Gagal menambahkan barang'),
                                                ),
                                              );
                                            }
                                          });
                                        }
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(20),
                                        ),
                                      ),
                                      child: const Text("Tambah Barang"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah Barang"),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
