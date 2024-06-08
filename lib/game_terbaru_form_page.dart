import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class GameTerbaruFormPage extends StatefulWidget {
  const GameTerbaruFormPage({Key? key}) : super(key: key);

  @override
  _GameTerbaruFormPageState createState() => _GameTerbaruFormPageState();
}

class _GameTerbaruFormPageState extends State<GameTerbaruFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _kodegameController = TextEditingController();
  final TextEditingController _namagameController = TextEditingController();
  final TextEditingController _hargagameController = TextEditingController();
  final TextEditingController _kategorigameController = TextEditingController();
  final TextEditingController _tanggalrilisController = TextEditingController();
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
        _tanggalrilisController.text =
            DateFormat('dd-MM-yyyy').format(_selectedDate!);
      });
    }
  }

  void _simpanForm(context) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      var data = {
        'kode_game': _kodegameController.text,
        'nama_game': _namagameController.text,
        'harga_game': _hargagameController.text,
        'kategori_game': _kategorigameController.text,
        'tanggal_rilis': _tanggalrilisController.text,
      };
      try {
        final supabase = Supabase.instance.client;
        await supabase.from('game_terbaru').insert(data);
        EasyLoading.showSuccess('Data Berhasil Disimpan');
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.showError('Ooooops terjadi kesalahan' + e.toString());
      }
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Game Terbaru'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                  TextFormField(
                    controller: _hargagameController,
                    decoration: InputDecoration(
                      labelText: 'Harga Game',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Harga game tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _kategorigameController,
                    decoration: InputDecoration(
                      labelText: 'Kategori Game',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kategori game tidak boleh kosong';
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
                      _tanggalrilisController.text = formattedDate;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _tanggalrilisController,
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
                      onPressed: () => _simpanForm(context),
                      child: Text('Simpan'))
                ],
              )),
        ));
  }
}
