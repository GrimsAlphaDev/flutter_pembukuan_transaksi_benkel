class Product {
  final int? id;
  // ignore: non_constant_identifier_names
  final String nama_barang;
  final String merek;
  // ignore: non_constant_identifier_names
  final int harga_barang;
  // ignore: non_constant_identifier_names
  final int stok_barang;
  // ignore: non_constant_identifier_names
  final String kategori_barang;
  // ignore: non_constant_identifier_names
  final String deskripsi_barang;
  // ignore: non_constant_identifier_names
  final String created_at;
  // ignore: non_constant_identifier_names
  final String updated_at;

  Product({
    this.id,
    // ignore: non_constant_identifier_names
    required this.nama_barang,
    required this.merek,
    // ignore: non_constant_identifier_names
    required this.harga_barang,
    // ignore: non_constant_identifier_names
    required this.stok_barang,
    // ignore: non_constant_identifier_names
    required this.kategori_barang,
    // ignore: non_constant_identifier_names
    required this.deskripsi_barang,
    // ignore: non_constant_identifier_names
    required this.created_at,
    // ignore: non_constant_identifier_names
    required this.updated_at,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nama_barang: json['nama_barang'],
      merek: json['merek'],
      harga_barang: json['harga_barang'],
      stok_barang: json['stok_barang'],
      kategori_barang: json['kategori_barang'],
      deskripsi_barang: json['deskripsi_barang'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_barang': nama_barang,
      'merek': merek,
      'harga_barang': harga_barang,
      'stok_barang': stok_barang,
      'kategori_barang': kategori_barang,
      'deskripsi_barang': deskripsi_barang,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
