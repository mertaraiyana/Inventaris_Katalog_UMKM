class Product {
  int? id;
  String name;
  int price;
  int stock;
  String description;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
  });

  // Mengubah objek Product menjadi Map untuk disimpan ke SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'description': description,
    };
  }

  // Mengubah Map dari SQLite kembali menjadi objek Product
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      stock: map['stock'],
      description: map['description'],
    );
  }
}
