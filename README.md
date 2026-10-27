# KasirKu

**Mahasiswa:** M. Assidiqi Diyaul Haq  
**NIM:** 2410651001

## Deskripsi
KasirKu adalah prototype aplikasi kasir sederhana yang dikembangkan untuk milestone **Form & Validation v0.2** pada BAB 6 Pemrograman Bergerak.

## Screen
- Home
- Daftar Barang
- Form Transaksi
- Tentang Aplikasi

## Fitur BAB 6
- Form transaksi menggunakan `Form` dan `GlobalKey<FormState>`.
- Empat input menggunakan `TextFormField`.
- Validasi kolom wajib diisi.
- Validasi nama minimal 3 karakter.
- Validasi harga dan jumlah harus berupa angka bulat lebih dari 0.
- Pesan error tampil pada field yang tidak valid.
- `SnackBar` memberi umpan balik setelah tombol ditekan.
- `StatefulWidget` dan `setState` memperbarui status transaksi.
- `TextEditingController` dibersihkan melalui `dispose()`.
- Navigasi antar-screen tetap tersedia.

## Cara Menjalankan
1. Pastikan Flutter SDK dan Google Chrome sudah terpasang.
2. Buka folder project di VS Code.
3. Jalankan `flutter pub get`.
4. Jalankan `flutter run -d chrome`.

## Skenario Uji
1. Klik Proses Transaksi dengan semua kolom kosong: pesan error harus tampil.
2. Isi nama pelanggan dengan `Al`: pesan minimal 3 karakter harus tampil.
3. Isi harga dengan `abc`: pesan harga harus berupa angka bulat harus tampil.
4. Isi jumlah dengan `0`: pesan jumlah harus lebih dari 0 harus tampil.
5. Isi semua data dengan benar: SnackBar berhasil muncul dan status menampilkan total.
6. Coba navigasi dari Home ke Daftar Barang/Form Transaksi dan kembali.

## Batasan Prototype
Data transaksi hanya ditampilkan pada layar dan belum disimpan permanen ke database/local storage.

## Bukti Running
Tambahkan screenshot aplikasi berjalan dan screenshot untuk skenario input kosong, input tidak valid, dan input valid.

## Catatan Penggunaan AI
AI digunakan sebagai **Explainer/Reviewer** untuk membantu memahami struktur form, validator, `setState`, `dispose()`, dan skenario pengujian. Kode harus dijalankan, diperiksa, dan dipahami kembali oleh mahasiswa.
