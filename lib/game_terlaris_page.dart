import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameTerlarisPage extends StatefulWidget {
  const GameTerlarisPage({Key? key}) : super(key: key);

  @override
  _GameTerlarisPageState createState() => _GameTerlarisPageState();
}

class _GameTerlarisPageState extends State<GameTerlarisPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void deleteData(id) async {
    EasyLoading.show();
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('game_terlaris').delete().match({'id': id});
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
    final data = await supabase.from('game_terlaris').select();
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
            Text('Game Terlaris'),
            SizedBox(width: 10),
            Icon(Icons.gamepad)
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/gl-form');
            },
            icon: Icon(Icons.add_box_outlined)
          ),
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
                      Navigator.pushNamed(context, '/gl-edit',
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
              Navigator.pushNamed(context, '/gl-detail',
                arguments: listData[index]);
            },
            title: Text(listData[index]['nama_game']),
            subtitle: Text(listData[index]['harga_game']),
          );
        },
      ),
    );
  }
}
