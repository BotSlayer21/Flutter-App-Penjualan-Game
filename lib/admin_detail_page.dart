import 'package:flutter/material.dart';

class AdminDetailPage extends StatefulWidget {
  const AdminDetailPage({Key? key}) : super(key: key);

  @override
  _AdminDetailPageState createState() => _AdminDetailPageState();
}

class _AdminDetailPageState extends State<AdminDetailPage> {
  @override
  Widget build(BuildContext context) {
    final dataAdmin = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(dataAdmin['kode_admin']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(dataAdmin['foto'])),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Kode Admin : ' + dataAdmin['kode_admin'])),
                Center(child: Text('Nama Admin : ' + dataAdmin['nama'])),
                Center(child: Text('No. Telpon : ' + dataAdmin['no_hp'])),
                Center(child: Text('Jenis Kelamin : ' + dataAdmin['jenis_kelamin'])),
              ],
            ),
          )
        ],
      )
    );
  }
}
