import 'package:flutter/material.dart';

class GameTerlarisDetailPage extends StatefulWidget {
  const GameTerlarisDetailPage({Key? key}) : super(key: key);

  @override
  _GameTerlarisDetailPageState createState() => _GameTerlarisDetailPageState();
}

class _GameTerlarisDetailPageState extends State<GameTerlarisDetailPage> {
  @override
  Widget build(BuildContext context) {
    final gamelaris = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(gamelaris['nama_game']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(gamelaris['foto'])),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kode Game : ' + gamelaris['kode_game']),
                Text('Nama Game : ' + gamelaris['nama_game']),
                Text('Kategori : ' + gamelaris['kategori_game']),
                Text('Harga Game : ' + gamelaris['harga_game']),
                Text('Tanggal Rilis : ' + gamelaris['tanggal_rilis']),
              ],
            ),
          )
        ],
      )
    );
  }
}
