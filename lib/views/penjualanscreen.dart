import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/penjualan.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/penjualan_screen_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/header.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/constant/constant.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PenjualanScreen extends StatefulWidget {
  const PenjualanScreen({super.key});

  @override
  State<PenjualanScreen> createState() => _PenjualanScreenState();
}

class _PenjualanScreenState extends State<PenjualanScreen> {
  Future<void> fetchPenjualan() async {
    // get token from shared preferences
    await context.read<PenjualanScreenProvider>().getPenjualan();
  }

  // controller for start date
  final TextEditingController _startDateController = TextEditingController();
  // controller for end date
  final TextEditingController _endDateController = TextEditingController();
  // key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: defaultPadding),
                      // button for tambah transaksi penjualan
                      ElevatedButton.icon(
                        onPressed: () {},
                        // add padding
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 2,
                              vertical: defaultPadding),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text(
                          "Tambah Transaksi Penjualan",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                // create filter start date and end date
                Expanded(
                  flex: 6,
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        // input for start date
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _startDateController,
                            // disabled type
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: 'Start Date',
                            ),
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: (context
                                            .read<PenjualanScreenProvider>()
                                            .startDate ==
                                        null)
                                    ? DateTime.now()
                                    : context
                                        .read<PenjualanScreenProvider>()
                                        .startDate!,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2099),
                                // set value
                              ).then((date) {
                                if (date != null) {
                                  context
                                      .read<PenjualanScreenProvider>()
                                      .filterDate(date, null);
                                  _startDateController.text =
                                      date.toString().substring(0, 10);
                                }
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter start date';
                              }
                              // if the start date is greater than the end date

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        // input for end date
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _endDateController,
                            // disabled type
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: 'End Date',
                            ),
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: (context
                                            .read<PenjualanScreenProvider>()
                                            .endDate ==
                                        null)
                                    ? DateTime.now()
                                    : context
                                        .read<PenjualanScreenProvider>()
                                        .endDate!,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2099),
                              ).then((date) {
                                if (date != null) {
                                  context
                                      .read<PenjualanScreenProvider>()
                                      .filterDate(null, date);
                                  _endDateController.text =
                                      date.toString().substring(0, 10);
                                }
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter end date';
                              }
                              // if the start date is greater than the end date
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        SizedBox(
                          height: 40.0,
                          width: 150.0,
                          child: MaterialButton(
                              color: Colors.blue,
                              child: const Center(
                                  child: Text(
                                'Filter',
                                style: TextStyle(color: Colors.white),
                              )),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
                              }),
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),

                        const SizedBox(
                          width: defaultPadding,
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 60.0,
                            width: 500.0,
                            child: MaterialButton(
                                color: Colors.red,
                                child: const Center(
                                    child: Text(
                                  'Export to Excel',
                                  style: TextStyle(color: Colors.white),
                                )),
                                onPressed: () {}),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: fetchPenjualan(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else {
                          return Consumer<PenjualanScreenProvider>(
                            builder: (context, penjualan, _) {
                              return Expanded(
                                child:
                                    // ListView.builder(
                                    //   itemCount:
                                    //       penjualan.penjualanList[0]!.data.length,
                                    //   itemBuilder: (context, index) {
                                    // create table
                                    SingleChildScrollView(
                                  scrollDirection: Axis
                                      .horizontal, // Allow horizontal scrolling
                                  child: DataTable(
                                      sortAscending: true,
                                      dataRowHeight: 50,
                                      border: const TableBorder(
                                        horizontalInside: BorderSide(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                        ),
                                      ),
                                      columnSpacing: 130,
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text(
                                            'No',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Nomor Transaksi',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Nama Barang',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Harga Barang',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Jumlah',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Total Harga',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Daftar Barang',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Tanggal',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Action',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ],
                                      rows: [
                                        for (var i = 0;
                                            i <
                                                penjualan.penjualanList[0]!.data
                                                    .length;
                                            i++)
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(
                                                  Text((i + 1).toString())),
                                              DataCell(Text(penjualan
                                                      .penjualanList[0]
                                                      ?.data[i]
                                                      .noTransaksi
                                                      .toString() ??
                                                  '')),
                                              DataCell(
                                                Text(penjualan.penjualanList[0]
                                                        ?.data[i].namaPembeli ??
                                                    ''),
                                              ),
                                              DataCell(Text(
                                                // penjualan
                                                //       .penjualanList[i]?.hargaJual
                                                //       .toString() ??
                                                //   '' convert with intl
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp ',
                                                        decimalDigits: 0)
                                                    .format(penjualan
                                                            .penjualanList[0]
                                                            ?.data[i]
                                                            .hargaJual ??
                                                        0),
                                              )),
                                              DataCell(Text(penjualan
                                                      .penjualanList[0]
                                                      ?.data[i]
                                                      .jumlahBarang
                                                      .toString() ??
                                                  '')),
                                              DataCell(Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp ',
                                                        decimalDigits: 0)
                                                    .format(penjualan
                                                            .penjualanList[0]
                                                            ?.data[i]
                                                            .totalHarga ??
                                                        0),
                                              )),
                                              // loop databarang
                                              DataCell(
                                                SizedBox(
                                                  height: 80,
                                                  width: 200,
                                                  child: ListView.builder(
                                                      itemCount: penjualan
                                                          .penjualanList[0]
                                                          ?.data[i]
                                                          .product
                                                          ?.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Text((penjualan
                                                                    .penjualanList[
                                                                        0]
                                                                    ?.data[i]
                                                                    .product?[
                                                                        index]
                                                                    .namaBarang) !=
                                                                null
                                                            ? '- ${penjualan.penjualanList[0]?.data[i].product?[index].namaBarang}'
                                                            : '');
                                                      }),
                                                ),
                                              ),
                                              DataCell(Text(penjualan
                                                      .penjualanList[0]
                                                      ?.data[i]
                                                      .updatedAt ??
                                                  '')),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit),
                                                      onPressed: () {},
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ]),
                                ),
                                //   },
                                // ),
                              );
                            },
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
