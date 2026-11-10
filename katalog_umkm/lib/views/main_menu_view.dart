import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'product_list_view.dart';
import 'login_view.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  int _currentIndex = 0;

  // Fungsi untuk memisahkan UI Halaman Profil
  Widget _buildProfilePage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profil', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false, // Rata kiri sama seperti halaman katalog
        backgroundColor: Colors.deepPurple, // Menambahkan background warna ungu yang sama
        elevation: 0,
        // Memastikan ikon status bar ponsel (baterai, wifi, dll) tetap terlihat jelas
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // Ikon warna putih di atas warna ungu
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFFF3E5F5),
              child: Icon(Icons.person, size: 50, color: Colors.deepPurple),
            ),
            const SizedBox(height: 16),
            const Text(
              'admin@example.com',
              style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Colors.deepPurple),
                    title: Text('Versi aplikasi', style: TextStyle(fontSize: 14, color: Colors.black54)),
                    subtitle: Text('1.0.0 (Versi Awal)', style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500)),
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16, color: Colors.black12),
                  ListTile(
                    leading: Icon(Icons.storage_outlined, color: Colors.deepPurple),
                    title: Text('Penyimpanan', style: TextStyle(fontSize: 14, color: Colors.black54)),
                    subtitle: Text('SQLite (Penyimpanan Lokal Relasional)', style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginView()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, size: 18, color: Colors.deepPurple),
                label: const Text('Keluar', style: TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3E5F5),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const ProductListView(),
      _buildProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: const Color(0xFFE1BEE7),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.assignment_outlined), label: 'Produk'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}
