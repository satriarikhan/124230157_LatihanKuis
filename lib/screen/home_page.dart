import 'package:flutter/material.dart';
import 'package:pt3_mobile/auth/login_page.dart';
import 'package:pt3_mobile/data/data_menu.dart';
import 'package:pt3_mobile/screen/detail_menu.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Halo, @$username",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              "Mau makan apa hari ini ???",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
                (route) => false,
              );
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              "https://tse1.mm.bing.net/th/id/OIP.TcJkprJqvJZ5ViItvIRj6wHaEp?pid=Api&P=0&h=220",
            ),
            Text("Daftar Menu:"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return _listMenu(context, index);
                  },
                  itemCount: menuList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listMenu(BuildContext context, int index) {
    // Gunakan InkWell untuk membuat seluruh card bisa diklik (seperti yang sudah Anda lakukan)
    return InkWell(
      // onTap ini akan membawa ke DetailPage ketika area card disentuh (bukan tombol Pesan)
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailPage(index: index);
            },
          ),
        );
      },
      child: Card(
        // Mengganti Container dengan Card untuk elevasi/bayangan yang lebih baik
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4, // Memberikan efek bayangan
        child: Container(
          // Ganti warna di sini jika Anda tidak menggunakan Material/Card default
          // decoration: BoxDecoration(
          //   color: const Color.fromARGB(255, 209, 231, 241),
          //   borderRadius: BorderRadius.circular(20),
          // ),
          child: Column(
            // Gunakan spaceBetween untuk mendorong tombol ke bagian bawah card
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Agar gambar dan tombol melebar
            children: [
              // Bagian Atas: Gambar (dengan border radius)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  menuList[index].imageUrls[0],
                  fit: BoxFit.cover,
                  // Pastikan gambar memiliki tinggi tertentu jika diperlukan
                  height: 100,
                ),
              ),

              // Bagian Tengah: Nama dan Harga
              Padding(
                // Memberikan jarak horizontal dan vertikal
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Column(
                  children: [
                    Text(
                      menuList[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Rp ${menuList[index].price}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Bagian Bawah: Tombol Pesan
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi untuk tombol PESAN: Navigasi ke halaman pemesanan
                    // Pastikan OrderPage Anda menerima data menu yang dipesan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // Ganti OrderPage dengan nama halaman pemesanan Anda
                          return DetailPage(index: index);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    // Ubah warna latar belakang tombol menjadi biru (sesuai gambar)
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ), // Padding tombol
                  ),
                  child: const Text(
                    'Pesan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
