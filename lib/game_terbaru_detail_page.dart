import 'package:flutter/material.dart';

class GameTerbaruDetailPage extends StatefulWidget {
  const GameTerbaruDetailPage({Key? key}) : super(key: key);

  @override
  _GameTerbaruDetailPageState createState() => _GameTerbaruDetailPageState();
}

class _GameTerbaruDetailPageState extends State<GameTerbaruDetailPage> {
  @override
  Widget build(BuildContext context) {
    final gamebaru = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(gamebaru['nama_game']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(gamebaru['foto'])),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kode Game : ' + gamebaru['kode_game']),
                Text('Nama Game : ' + gamebaru['nama_game']),
                Text('Kategori : ' + gamebaru['kategori_game']),
                Text('Harga Game : ' + gamebaru['harga_game']),
                Text('Tanggal Rilis : ' + gamebaru['tanggal_rilis']),
              ],
            ),
          )
        ],
      )
    );
  }
}
