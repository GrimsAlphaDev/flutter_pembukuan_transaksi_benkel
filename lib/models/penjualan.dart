class Penjualan {
  String status;
  List<TransactionData> data;
  String message;

  Penjualan({
    required this.status,
    required this.data,
    required this.message,
  });

  factory Penjualan.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<TransactionData> transactionDataList =
        dataList.map((item) => TransactionData.fromJson(item)).toList();

    return Penjualan(
      status: json['status'],
      data: transactionDataList,
      message: json['message'],
    );
  }
}

class TransactionData {
  int id;
  String noTransaksi;
  int hargaJual;
  int jumlahBarang;
  int totalHarga;
  String namaPembeli;
  String alamatPembeli;
  String createdAt;
  String updatedAt;
  List<Product>? product; // It's a list of products, so it's optional

  TransactionData({
    required this.id,
    required this.noTransaksi,
    required this.hargaJual,
    required this.jumlahBarang,
    required this.totalHarga,
    required this.namaPembeli,
    required this.alamatPembeli,
    required this.createdAt,
    required this.updatedAt,
    this.product, // Optional field
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    var productList = json['product'] as List?;
    List<Product>? products;

    if (productList != null) {
      products = productList.map((item) => Product.fromJson(item)).toList();
    }

    return TransactionData(
      id: json['id'],
      noTransaksi: json['no_transaksi'],
      hargaJual: json['harga_jual'],
      jumlahBarang: json['jumlah_barang'],
      totalHarga: json['total_harga'],
      namaPembeli: json['nama_pembeli'],
      alamatPembeli: json['alamat_pembeli'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      product: products,
    );
  }
}

class Product {
  int id;
  String namaBarang;
  String merek;
  int hargaBarang;
  int stokBarang;
  String kategoriBarang;
  String deskripsiBarang;
  String status;
  String createdAt;
  String updatedAt;

  Product({
    required this.id,
    required this.namaBarang,
    required this.merek,
    required this.hargaBarang,
    required this.stokBarang,
    required this.kategoriBarang,
    required this.deskripsiBarang,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      namaBarang: json['nama_barang'],
      merek: json['merek'],
      hargaBarang: json['harga_barang'],
      stokBarang: json['stok_barang'],
      kategoriBarang: json['kategori_barang'],
      deskripsiBarang: json['deskripsi_barang'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
