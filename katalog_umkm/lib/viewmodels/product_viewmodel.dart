import 'package:flutter/material.dart';
import 'package:katalog_umkm/data/models/product_model.dart';
import 'package:katalog_umkm/data/repositories/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = await _repository.getProducts();
    notifyListeners(); // Memberitahu UI untuk render ulang secara otomatis
  }

  Future<void> addProduct(Product product) async {
    await _repository.insertProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _repository.updateProduct(product);
    await fetchProducts();
  }

  Future<void> deleteProduct(int id) async {
    await _repository.deleteProduct(id);
    await fetchProducts();
  }
}
