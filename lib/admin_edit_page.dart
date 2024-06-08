import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminEditPage extends StatefulWidget {
  const AdminEditPage({Key? key}) : super(key: key);

  @override
  _AdminEditPageState createState() => _AdminEditPageState();
}

class _AdminEditPageState extends State<AdminEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _kodeadminController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nohpController = TextEditingController();
  final TextEditingController _listJenisKelaminController =
      TextEditingController();
  String? _selectedJenisKelamin;

  List<String> jenisKelaminOptions = [
    "Laki-Laki",
    "Perempuan",
  ];

  void _simpanForm(context, id) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      var data = {
        'kode_admin': _kodeadminController.text,
        'nama': _namaController.text,
        'no_hp': _nohpController.text,
        'jenis_kelamin': _selectedJenisKelamin,
      };
      try {
        final supabase = Supabase.instance.client;
        await supabase.from('admin').update(data).match({'id': id});
        EasyLoading.showSuccess('Data Berhasil Diupdate');
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.showError('Oooops Terjadi Kesalahan $e');
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
    final dataAdmin = ModalRoute.of(context)!.settings.arguments as Map;
    _kodeadminController.text = dataAdmin['kode_admin'];
    _namaController.text = dataAdmin['nama'];
    _listJenisKelaminController.text = dataAdmin['jenis_kelamin'];
    _nohpController.text = dataAdmin['no_hp'];
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Data Admin'),
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
                    onPressed: () => _simpanForm(context, dataAdmin['id']),
                    child: Text('Simpan'))
              ],
            ),
          ),
        ));
  }
}
