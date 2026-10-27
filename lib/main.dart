import 'package:flutter/material.dart';

void main() {
  runApp(const KasirKuApp());
}

class KasirKuApp extends StatelessWidget {
  const KasirKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KasirKu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KasirKu')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.point_of_sale, size: 80, color: Colors.teal),
          const SizedBox(height: 12),
          const Text('Selamat datang di KasirKu',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Prototype aplikasi kasir sederhana',
              textAlign: TextAlign.center),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: () => _openPage(context, const ProductsPage()),
            icon: const Icon(Icons.inventory_2),
            label: const Text('Lihat Daftar Barang'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _openPage(context, const TransactionFormPage()),
            icon: const Icon(Icons.receipt_long),
            label: const Text('Buat Transaksi'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _openPage(context, const AboutPage()),
            icon: const Icon(Icons.info_outline),
            label: const Text('Tentang Aplikasi'),
          ),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'BAB 6: Form, validasi input, pesan error, SnackBar, dan state sederhana.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      ('Buku Tulis', 'Rp5.000', Icons.menu_book),
      ('Pulpen', 'Rp3.000', Icons.edit),
      ('Pensil', 'Rp2.000', Icons.draw),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Barang')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(product.$3)),
              title: Text(product.$1),
              trailing: Text(product.$2,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('KasirKu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Nama: M. Assidiqi Diyaul Haq'),
            Text('NIM: 2410651001'),
            SizedBox(height: 12),
            Text('KasirKu adalah prototype aplikasi kasir untuk melihat daftar barang dan membuat catatan transaksi sederhana.'),
          ],
        ),
      ),
    );
  }
}

class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({super.key});

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String _statusMessage = 'Belum ada transaksi yang diproses';

  @override
  void dispose() {
    _customerController.dispose();
    _itemController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() {
        _statusMessage = 'Periksa kembali data transaksi';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Input belum valid. Periksa pesan error.')),
      );
      return;
    }

    final customer = _customerController.text.trim();
    final item = _itemController.text.trim();
    final price = int.parse(_priceController.text.trim());
    final quantity = int.parse(_quantityController.text.trim());
    final total = price * quantity;

    setState(() {
      _statusMessage = 'Transaksi $customer: $item x $quantity = ${_rupiah(total)}';
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaksi berhasil diproses!')),
    );
  }

  String _rupiah(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) buffer.write('.');
    }
    return 'Rp$buffer';
  }

  String? _requiredText(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label wajib diisi';
    if (value.trim().length < 3) return '$label minimal 3 karakter';
    return null;
  }

  String? _positiveInteger(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label wajib diisi';
    final number = int.tryParse(value.trim());
    if (number == null) return '$label harus berupa angka bulat';
    if (number <= 0) return '$label harus lebih dari 0';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Transaksi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Data Transaksi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Isi semua data. Data hanya diproses sebagai prototype dan belum disimpan permanen.'),
            const SizedBox(height: 18),
            TextFormField(
              controller: _customerController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Nama pelanggan', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
              validator: (value) => _requiredText(value, 'Nama pelanggan'),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _itemController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Nama barang', border: OutlineInputBorder(), prefixIcon: Icon(Icons.inventory_2)),
              validator: (value) => _requiredText(value, 'Nama barang'),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Harga satuan (Rp)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.payments)),
              validator: (value) => _positiveInteger(value, 'Harga'),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah barang', border: OutlineInputBorder(), prefixIcon: Icon(Icons.numbers)),
              validator: (value) => _positiveInteger(value, 'Jumlah'),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.save),
              label: const Text('Proses Transaksi'),
            ),
            const SizedBox(height: 18),
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_statusMessage, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
