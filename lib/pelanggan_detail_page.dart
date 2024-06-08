import 'package:flutter/material.dart';

class PelangganDetailPage extends StatefulWidget {
  const PelangganDetailPage({Key? key}) : super(key: key);

  @override
  _PelangganDetailPageState createState() => _PelangganDetailPageState();
}

class _PelangganDetailPageState extends State<PelangganDetailPage> {
  @override
  Widget build(BuildContext context) {
    final dataPelanggan = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(dataPelanggan['username']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(dataPelanggan['foto'])),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kode Pelanggan : ' + dataPelanggan['kode_pelanggan']),
                Text('Username : ' + dataPelanggan['username']),
                Text('Email : ' + dataPelanggan['email']),
              ],
            ),
          )
        ],
      )
    );
  }
}
