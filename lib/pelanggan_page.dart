import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
    
class PelangganPage extends StatefulWidget {
  const PelangganPage({Key? key}) : super(key: key);

  @override
  _PelangganPageState createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void deleteData(id) async {
    EasyLoading.show();
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('pelanggan').delete().match({'id': id});
    } catch (e) {
      EasyLoading.showError('Ops there is something wrong$e');
    }
    getData();
    EasyLoading.dismiss();
  }

  List listData = [];
  void getData() async {
    EasyLoading.show();
    final supabase = Supabase.instance.client;
    final data = await supabase.from('pelanggan').select();
    setState(() {
      listData = data;
    });
    EasyLoading.dismiss();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Data Pelanggan'),
            SizedBox(width: 10),
            Icon(Icons.person_pin_rounded)
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/pelanggan-form');
            },
            icon: Icon(Icons.add_box_outlined)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: SizedBox(
              width: 96,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pelanggan-edit',
                        arguments: listData[index]);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteData(listData[index]['id']);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/pelanggan-detail',
                arguments: listData[index]);
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(listData[index]['foto']),
            ),
            title: Text(listData[index]['username']),
            subtitle: Text('Email: ' + listData[index]['email']),
          );
        },
      ),
    );
  }
}