import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/penjualan_screen_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/components/header.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/constant/constant.dart';
import 'package:provider/provider.dart';

class PenjualanScreen extends StatefulWidget {
  const PenjualanScreen({super.key});

  @override
  State<PenjualanScreen> createState() => _PenjualanScreenState();
}

class _PenjualanScreenState extends State<PenjualanScreen> {
  @override
  void initState() {
    context.read<PenjualanScreenProvider>().test();
    super.initState();
  }

  List<Map<dynamic, dynamic>> sales = [
    {
      'id': 'TRX0001',
      'tanggal': '2021-10-10',
      'nama': 'Budi',
      'nama_barang': 'Ban',
      'jumlah': 2,
      'harga': 100000,
      'total': 200000,
    },
    {
      'id': 'TRX0002',
      'tanggal': '2021-10-10',
      'nama': 'Genda',
      'nama_barang': 'Oli',
      'jumlah': 2,
      'harga': 100000,
      'total': 200000,
    }
  ];
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
            const SizedBox(height: defaultPadding),
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
                  flex: 4,
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
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 60.0,
                    width: 200.0,
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
            const SizedBox(height: defaultPadding),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Allow horizontal scrolling
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
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Id Transaksi',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Nama Barang',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Harga Barang',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Jumlah',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Total Harga',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Tanggal',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Action',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: <DataRow>[
                          // loop sales
                          for (var i = 0; i < sales.length; i++)
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text((i + 1).toString())),
                                DataCell(Text(sales[i]['id'].toString())),
                                DataCell(Text(sales[i]['nama_barang'])),
                                DataCell(Text(sales[i]['harga'].toString())),
                                DataCell(Text(sales[i]['jumlah'].toString())),
                                DataCell(Text(sales[i]['total'].toString())),
                                DataCell(Text(sales[i]['tanggal'])),
                                DataCell(
                                  Row(
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
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
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
