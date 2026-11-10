import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:katalog_umkm/data/models/product_model.dart';
import '../viewmodels/product_viewmodel.dart';

class ProductFormView extends StatefulWidget {
  final Product? product;
  const ProductFormView({super.key, this.product});

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _stockController.text = widget.product!.stock.toString();
      _descController.text = widget.product!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;
    final productVM = Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Ubah Produk' : 'Tambah Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                validator: (val) => val == null || val.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Harga (Rp)'),
                validator: (val) => val == null || val.isEmpty ? 'Harga tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Stok'),
                validator: (val) => val == null || val.isEmpty ? 'Stok tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Deskripsi Produk'),
                validator: (val) => val == null || val.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newProduct = Product(
                      id: widget.product?.id,
                      name: _nameController.text,
                      price: int.parse(_priceController.text),
                      stock: int.parse(_stockController.text),
                      description: _descController.text,
                    );

                    if (isEdit) {
                      productVM.updateProduct(newProduct);
                    } else {
                      productVM.addProduct(newProduct);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Produk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
