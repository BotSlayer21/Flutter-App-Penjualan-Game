import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminFormPage extends StatefulWidget {
  const AdminFormPage({Key? key}) : super(key: key);

  @override
  _AdminFormPageState createState() => _AdminFormPageState();
}

class _AdminFormPageState extends State<AdminFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _kodeadminController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nohpController = TextEditingController();
  String? _selectedJenisKelamin;

  List<String> jenisKelaminOptions = [
    "Laki-Laki",
    "Perempuan",
  ];

  void _simpanForm(context) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      var data = {
        'kode_admin': _kodeadminController.text,
        'nama': _namaController.text,
        'no_hp': _nohpController.text,
        'jenis_kelamin': _selectedJenisKelamin ?? "",
      };
      try {
        final supabase = Supabase.instance.client;
        await supabase.from('admin').insert(data);
        EasyLoading.showSuccess('Data Berhasil Disimpan');
        Navigator.pop(context);
        // Navigator.of(context).pushNamed('/admin');
      } catch (e) {
        EasyLoading.showError('Ooooops terjadi kesalahan' + e.toString());
      }
      EasyLoading.dismiss();
    }
  }

  var listJenisKelamin = [];
  @override
  void initState() {
    super.initState();
    getJenisKelamin();
  }
  void getJenisKelamin() async {
    var data = await Supabase.instance.client.from('jenis_kelamin').select();
    setState(() {
      listJenisKelamin = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Data Admin'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _kodeadminController,
                    decoration: InputDecoration(
                      labelText: 'Kode Admin',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kode Admin tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama Admin',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    isExpanded: true,
                    value: _selectedJenisKelamin,
                    decoration: InputDecoration(
                      labelText: 'Jenis Kelamin',
                    ),
                    items: listJenisKelamin.map((item) {
                      return DropdownMenuItem(
                        value: item['nama'],
                        child: Text(item['singkatan']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedJenisKelamin = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _nohpController,
                    decoration: InputDecoration(
                      labelText: 'No. Hp',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No. Hp tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _simpanForm(context),
                    child: Text('Simpan'),
                  ),
                ],
              )),
        ));
  }
}
