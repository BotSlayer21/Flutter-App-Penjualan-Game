import 'package:flutter/material.dart';
    
class GameGratisDetailPage extends StatefulWidget {
  const GameGratisDetailPage({Key? key}) : super(key: key);

  @override
  _GameGratisDetailPageState createState() => _GameGratisDetailPageState();
}

class _GameGratisDetailPageState extends State<GameGratisDetailPage> {
  @override
  Widget build(BuildContext context) {
    final gamegratis = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(gamegratis['nama_game']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(gamegratis['foto'])),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kode Game : ' + gamegratis['kode_game']),
                Text('Nama Game : ' + gamegratis['nama_game']),
                Text('Kategori : ' + gamegratis['kategori_game']),
                Text('Harga Game : ' + gamegratis['harga_game']),
                Text('Tanggal Rilis : ' + gamegratis['tanggal_rilis']),
              ],
            ),
          )
        ],
      )
    );
  }
}