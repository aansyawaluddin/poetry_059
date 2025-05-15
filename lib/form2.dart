import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FormPage2 extends StatefulWidget {
  final String nama, umur, kelamin, pelapor, email, phone;

  const FormPage2({
    super.key,
    required this.nama,
    required this.umur,
    required this.kelamin,
    required this.pelapor,
    required this.email,
    required this.phone,
  });

  @override
  State<FormPage2> createState() => _FormPage2State();
}

class _FormPage2State extends State<FormPage2> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTipe;
  String? _selectedGratifikasi;
  final _taksiranController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _alamatController = TextEditingController();
  final _kotaController = TextEditingController();
  final _provinsiController = TextEditingController();
  final _kodeposController = TextEditingController();
  final _indikasiController = TextEditingController();
  final _caraController = TextEditingController();
  final _terlibatController = TextEditingController();
  final _lokasiPelanggaranController = TextEditingController();

  @override
  void dispose() {
    _taksiranController.dispose();
    _tanggalController.dispose();
    _alamatController.dispose();
    _kotaController.dispose();
    _provinsiController.dispose();
    _kodeposController.dispose();
    _indikasiController.dispose();
    _caraController.dispose();
    _terlibatController.dispose();
    _lokasiPelanggaranController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _tanggalController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _submitData(BuildContext context) async {
    final url = Uri.parse(
        'https://script.google.com/macros/s/AKfycbxLufWN1UBhZSzvq49c6RhgFVf8-_TAP3t9uvdjpBsNhQCY8bF4cChz6_S2xcoWhtsg/exec'); // Ganti URL Anda
    final payload = {
      'nama': widget.nama,
      'umur': widget.umur,
      'kelamin': widget.kelamin,
      'pelapor': widget.pelapor,
      'email': widget.email,
      'phone': widget.phone,
      'tipePelaporan': _selectedTipe,
      'bentukGratifikasi': _selectedGratifikasi,
      'taksiran': _taksiranController.text,
      'tanggal': _tanggalController.text,
      'alamat': _alamatController.text,
      'kota': _kotaController.text,
      'provinsi': _provinsiController.text,
      'kodepos': _kodeposController.text,
      'indikasi': _indikasiController.text,
      'cara': _caraController.text,
      'terlibat': _terlibatController.text,
      'lokasiPelanggaran': _lokasiPelanggaranController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      final respJson = jsonDecode(response.body);
      if (response.statusCode == 200 && respJson['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Data berhasil dikirim ke Spreadsheet')));
      } else {
        throw Exception(respJson['message'] ?? 'Unknown error');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal mengirim data: \$e')));
    }
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Pelaporan',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        titleSpacing: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tipe Pelaporan',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButtonFormField<String>(
                  value: _selectedTipe,
                  decoration: _inputDecoration('Pilih tipe pelaporan'),
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(
                        value: 'Korupsi/Gratifikasi',
                        child: Text('Korupsi/Gratifikasi')),
                    DropdownMenuItem(value: 'Layanan', child: Text('Layanan')),
                    DropdownMenuItem(
                        value: 'Sarana Prasarana',
                        child: Text('Sarana Prasarana')),
                    DropdownMenuItem(
                        value: 'Kekerasan/Bullying',
                        child: Text('Kekerasan/Bullying')),
                    DropdownMenuItem(
                        value: 'Pengadaan Barang dan Jasa (PBJ)',
                        child: Text('Pengadaan Barang dan Jasa (PBJ)')),
                    DropdownMenuItem(
                        value: 'Pungutan Liar', child: Text('Pungutan Liar')),
                    DropdownMenuItem(
                        value: 'Penyalahgunaan Wewenang',
                        child: Text('Penyalahgunaan Wewenang')),
                    DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
                  ],
                  onChanged: (val) => setState(() => _selectedTipe = val),
                  validator: (v) =>
                      v == null ? 'Tipe pelaporan wajib dipilih' : null,
                ),
                const SizedBox(height: 20),
                const Text('Bentuk Gratifikasi',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButtonFormField<String>(
                  value: _selectedGratifikasi,
                  decoration: _inputDecoration('Pilih bentuk gratifikasi'),
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(value: 'Uang', child: Text('Uang')),
                    DropdownMenuItem(value: 'Barang', child: Text('Barang')),
                    DropdownMenuItem(
                        value: 'Rabat (discount)',
                        child: Text('Rabat (discount)')),
                    DropdownMenuItem(value: 'Komisi', child: Text('Komisi')),
                    DropdownMenuItem(
                        value: 'Pinjaman Tanpa Bunga',
                        child: Text('Pinjaman Tanpa Bunga')),
                    DropdownMenuItem(
                        value: 'Tiket Perjalanan',
                        child: Text('Tiket Perjalanan')),
                    DropdownMenuItem(
                        value: 'Fasilitas Penginapan',
                        child: Text('Fasilitas Penginapan')),
                    DropdownMenuItem(
                        value: 'Perjalanan Wisata',
                        child: Text('Perjalanan Wisata')),
                    DropdownMenuItem(
                        value: 'Pengobatan cuma-cuma',
                        child: Text('Pengobatan cuma-cuma')),
                    DropdownMenuItem(
                        value: 'Dan fasilitas lainnya',
                        child: Text('Dan fasilitas lainnya')),
                  ],
                  onChanged: (val) =>
                      setState(() => _selectedGratifikasi = val),
                ),
                const Text('Taksiran Nilai Gratifikasi',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _taksiranController,
                  decoration: _inputDecoration('Masukkan Nilai Taksiran'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                const Text('Tanggal Pelaporan',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _tanggalController,
                  decoration: _inputDecoration('Pilih tanggal'),
                  readOnly: true,
                  onTap: _pickDate,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Tanggal wajib dipilih' : null,
                ),
                const SizedBox(height: 20),
                const Text("Lokasi Kejadian",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('Alamat',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _alamatController,
                  decoration: _inputDecoration('Masukkan alamat lengkap'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Alamat wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                const Text('Kota',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _kotaController,
                  decoration: _inputDecoration('Masukkan nama kota'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Kota wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                const Text('Provinsi',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _provinsiController,
                  decoration: _inputDecoration('Masukkan nama provinsi'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Provinsi wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                const Text('Kode Pos',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _kodeposController,
                  decoration: _inputDecoration('Masukkan kode pos'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Kode pos wajib diisi' : null,
                ),
                const SizedBox(height: 20),
                const Text("Detail Permasalahan/Aduan",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('Indikasi Pelanggaran',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _indikasiController,
                  decoration: _inputDecoration('Jelaskan indikasi pelanggaran'),
                  maxLines: 3,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Indikasi wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                const Text('Cara Pelanggaran Dilakukan',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _caraController,
                  decoration: _inputDecoration(
                      'Ceritakan bagaimana pelanggaran terjadi'),
                  maxLines: 3,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Deskripsi wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                const Text('Pihak Terlibat',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _terlibatController,
                  decoration:
                      _inputDecoration('Sebutkan pihak-pihak yang terlibat'),
                  validator: (v) => v == null || v.isEmpty
                      ? 'Pihak terlibat wajib diisi'
                      : null,
                ),
                const SizedBox(height: 12),
                const Text('Lokasi Pelanggaran',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _lokasiPelanggaranController,
                  decoration: _inputDecoration('Dimana pelanggaran terjadi'),
                  validator: (v) => v == null || v.isEmpty
                      ? 'Lokasi pelanggaran wajib diisi'
                      : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitData(context);
                      }
                    },
                    child: const Text('Kirim'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
