import 'package:flutter/material.dart';
import 'package:pt3_mobile/data/data_menu.dart';
import 'package:pt3_mobile/models/menu.dart';
import 'package:pt3_mobile/screen/home_page.dart';

// 1. UBAH DARI StatelessWidget KE StatefulWidget
class DetailPage extends StatefulWidget {
  final int index;

  // Ubah tipe data ini menjadi MenuModel jika Anda sudah mengirimkan objek dari Home Page
  // final MenuModel menu;

  // Saya akan tetap menggunakan index sesuai kode awal Anda
  const DetailPage({super.key, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // 2. STATE UNTUK JUMLAH DAN TOTAL HARGA
  double _totalHarga = 0.0;
  final TextEditingController _jumlahController = TextEditingController();

  // Ambil data menu berdasarkan index
  late Menu _menu;
  late double _hargaPerSatuan;

  @override
  void initState() {
    super.initState();
    _menu = menuList[widget.index];
    // Asumsi harga disimpan sebagai String, kita perlu mengubahnya ke double
    // Anda mungkin perlu menyesuaikan cara harga diambil dari String (misal, hapus "Rp " dan titik)
    String hargaString = _menu.price.replaceAll('Rp ', '').replaceAll('.', '');
    _hargaPerSatuan = double.tryParse(hargaString) ?? 0.0;
  }

  // 3. LOGIKA PENGHITUNGAN
  void _hitungTotalHarga(String jumlahText) {
    // Pastikan input adalah angka
    int jumlah = int.tryParse(jumlahText) ?? 0;

    // Pastikan tidak ada input negatif
    if (jumlah < 0) jumlah = 0;

    setState(() {
      _totalHarga = jumlah * _hargaPerSatuan;
    });
  }

  @override
  void dispose() {
    _jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ubah title menjadi Detail Order sesuai gambar
      appBar: AppBar(title: const Text("Detail Order")),
      body: SingleChildScrollView(
        // Agar tidak error jika keyboard muncul
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gambar Menu
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _menu.imageUrls[0],
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              const SizedBox(height: 16),

              // Nama dan Harga
              Text(
                _menu.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Harga : ${_menu.price}",
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // 4. INPUT JUMLAH PESANAN
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Masukkan Jumlah',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                ),
                onChanged:
                    _hitungTotalHarga, // Panggil hitung saat teks berubah
              ),
              const SizedBox(height: 20),

              // 5. TOMBOL SUBMIT
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // Ganti OrderPage dengan nama halaman pemesanan Anda
                        return HomePage(username: '');
                      },
                    ),
                  );
                  // Di sini Anda bisa menambahkan logika finalisasi pesanan
                  // Contoh: print('Pesanan ${_jumlahPesanan} ${menu.name} dengan total Rp ${_totalHarga.toStringAsFixed(0)} dikirim');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),

              // 6. TOTAL HARGA
              Center(
                child: Text(
                  // Format total harga menjadi mata uang (tanpa desimal)
                  "Total Harga: Rp ${_totalHarga.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
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
