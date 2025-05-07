import 'package:flutter/material.dart';
import 'package:poetry_059/form2.dart';

class FormPage1 extends StatefulWidget {
  const FormPage1({super.key});

  @override
  State<FormPage1> createState() => _FormPage1State();
}

class _FormPage1State extends State<FormPage1> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedAge;
  String? _selectedGender;

  bool _isPegawai = false;
  bool _isStakeholder = false;
  bool _isMasyarakat = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
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
                // Nama
                const Text('Nama (Boleh Samaran)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration('Masukkan nama Anda'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                // Umur
                const Text('Umur', style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButtonFormField<String>(
                  value: _selectedAge,
                  decoration: _inputDecoration('Pilih umur'),
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(value: '< 20', child: Text('< 20 tahun')),
                    DropdownMenuItem(value: '21-25', child: Text('21-25 tahun')),
                    DropdownMenuItem(value: '26-30', child: Text('26-30 tahun')),
                    DropdownMenuItem(value: '31-40', child: Text('31-40 tahun')),
                    DropdownMenuItem(value: '41-50', child: Text('41-50 tahun')),
                    DropdownMenuItem(value: '> 50', child: Text('> 50 tahun')),
                  ],
                  onChanged: (v) => setState(() => _selectedAge = v),
                  validator: (v) => v == null ? 'Umur wajib dipilih' : null,
                ),
                const SizedBox(height: 12),
                // Gender
                const Text('Jenis Kelamin',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: _inputDecoration('Pilih jenis kelamin'),
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(
                        value: 'Laki-laki', child: Text('Laki-laki')),
                    DropdownMenuItem(
                        value: 'Perempuan', child: Text('Perempuan')),
                  ],
                  onChanged: (v) => setState(() => _selectedGender = v),
                  validator: (v) =>
                      v == null ? 'Jenis kelamin wajib dipilih' : null,
                ),
                const SizedBox(height: 12),
                // Pelapor
                 const Text(
                  'Pelapor (boleh pilih lebih dari satu)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Pegawai KPPN Majene'),
                    value: _isPegawai,
                    onChanged: (val) => setState(() => _isPegawai = val!),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Stakeholder KPPN Majene'),
                    value: _isStakeholder,
                    onChanged: (val) => setState(() => _isStakeholder = val!),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Masyarakat'),
                    value: _isMasyarakat,
                    onChanged: (val) => setState(() => _isMasyarakat = val!),
                  ),
                ),
                const SizedBox(height: 12),
                // Email
                const Text('Email',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _emailController,
                  decoration: _inputDecoration('Masukkan email Anda'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email wajib diisi';
                    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    return regex.hasMatch(v) ? null : 'Format email tidak valid';
                  },
                ),
                const SizedBox(height: 12),
                // Telepon
                const Text('Nomor Telepon',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _phoneController,
                  decoration: _inputDecoration('Masukkan nomor telepon Anda'),
                  keyboardType: TextInputType.phone,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Nomor telepon wajib diisi' : null,
                ),
                const SizedBox(height: 20),
                // Button Next
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final pelaporList = <String>[];
                        if (_isPegawai) pelaporList.add('Pegawai KKPN Majene');
                        if (_isStakeholder)
                          pelaporList.add('Stakeholder KPPN Majene');
                        if (_isMasyarakat) pelaporList.add('Masyarakat');
                        final pelapor = pelaporList.join(', ');
        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FormPage2(
                              nama: _nameController.text,
                              umur: _selectedAge!,
                              kelamin: _selectedGender!,
                              pelapor: pelapor,
                              email: _emailController.text,
                              phone: _phoneController.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Selanjutnya'),
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
