import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class PenjualanEditPage extends StatefulWidget {
  const PenjualanEditPage({Key? key}) : super(key: key);

  @override
  _PenjualanEditPageState createState() => _PenjualanEditPageState();
}

class _PenjualanEditPageState extends State<PenjualanEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _kodepjlController = TextEditingController();
  final TextEditingController _kodegameController = TextEditingController();
  final TextEditingController _kodeplgController = TextEditingController();
  final TextEditingController _namagameController = TextEditingController();
  final TextEditingController _tanggalpjlController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked ?? DateTime.now();
        _tanggalpjlController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  void _simpanForm(context, id) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      var data = {
        'kode_penjualan': _kodepjlController.text,
        'kode_game': _kodegameController.text,
        'kode_pelanggan': _kodeplgController.text,
        'nama_game': _namagameController.text,
        'tanggal_penjualan': _tanggalpjlController.text,
      };
      try {
        final supabase = Supabase.instance.client;
        await supabase.from('penjualan').update(data).match({'id': id});
        EasyLoading.showSuccess('Data Berhasil Diupdate');
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.showError('Oooops Terjadi Kesalahan $e');
      }
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pjl = ModalRoute.of(context)!.settings.arguments as Map;
    _kodepjlController.text = pjl['kode_penjualan'];
    _kodegameController.text = pjl['kode_game'];
    _kodeplgController.text = pjl['kode_pelanggan'];
    _namagameController.text = pjl['nama_game'];
    _tanggalpjlController.text = pjl['tanggal_penjualan'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Penjualan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key : _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _kodepjlController,
                  decoration: InputDecoration(
                    labelText: 'Kode Penjualan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kode Penjualan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              TextFormField(
                  controller: _kodegameController,
                  decoration: InputDecoration(
                    labelText: 'Kode Game',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kode Game tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              TextFormField(
                  controller: _kodeplgController,
                  decoration: InputDecoration(
                    labelText: 'Kode Pelanggan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kode Pelanggan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              TextFormField(
                  controller: _namagameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Game',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama game tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                      String formattedDate =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      _tanggalpjlController.text = formattedDate;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _tanggalpjlController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Rilis',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tanggal Rilis tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _simpanForm(context, pjl['id']),
                child: Text('Simpan'))
            ],
          )
        ),
      )
    );
  }
}
