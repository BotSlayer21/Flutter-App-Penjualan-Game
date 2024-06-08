import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PelangganEditPage extends StatefulWidget {
  const PelangganEditPage({Key? key}) : super(key: key);

  @override
  _PelangganEditPageState createState() => _PelangganEditPageState();
}

class _PelangganEditPageState extends State<PelangganEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _kodeplgnController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _simpanForm(context, id) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      var data = {
        'kode_admin': _kodeplgnController.text,
        'nama': _usernameController.text,
        'no_hp': _emailController.text,
      };
      try {
        final supabase = Supabase.instance.client;
        await supabase.from('pelanggan').update(data).match({'id': id});
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
    final dataplgn = ModalRoute.of(context)!.settings.arguments as Map;
    _kodeplgnController.text = dataplgn['kode_pelanggan'];
    _usernameController.text = dataplgn['username'];
    _emailController.text = dataplgn['email'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Pelanggan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _kodeplgnController,
                  decoration: InputDecoration(
                    labelText: 'Kode Pelangggan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kode Pelanggan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _simpanForm(context, dataplgn['id']),
                  child: Text('Simpan')
                )
              ],
            )
          ),
      ),
    );
  }
}
