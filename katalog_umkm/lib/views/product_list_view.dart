import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';
import 'product_form_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productVM = Provider.of<ProductViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Katalog Produk UMKM',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.deepPurple, // Menambahkan background warna ungu utama aplikasi
        elevation: 0,
        // Memastikan ikon status bar ponsel (baterai, wifi, dll) tetap terlihat jelas
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // Ikon warna putih agar kontras di atas warna ungu
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: productVM.products.isEmpty
          ? const Center(child: Text('Belum ada produk. Tambahkan data!'))
          : ListView.builder(
              itemCount: productVM.products.length,
              itemBuilder: (context, index) {
                final product = productVM.products[index];
                return Card(
                  color: const Color(0xFFF5F5F5),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Harga: Rp ${product.price} | Stok: ${product.stock}\n${product.description}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductFormView(product: product))),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Konfirmasi Hapus'),
                              content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                                TextButton(
                                  onPressed: () {
                                    productVM.deleteProduct(product.id!);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductFormView())),
      ),
    );
  }
}
