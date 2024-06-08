import 'package:flutter/material.dart';

class PenjualanDetailPage extends StatefulWidget {
  const PenjualanDetailPage({Key? key}) : super(key: key);

  @override
  _PenjualanDetailPageState createState() => _PenjualanDetailPageState();
}

class _PenjualanDetailPageState extends State<PenjualanDetailPage> {
  @override
  Widget build(BuildContext context) {
    final datapjl = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(datapjl['kode_penjualan']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(datapjl['foto'])),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Kode Penjualan : ' + datapjl['kode_penjualan'])),
                Center(child: Text('Kode Game : ' + datapjl['kode_game'])),
                Center(child: Text('Kode Pelanggan : ' + datapjl['kode_pelanggan'])),
                Center(child: Text('Nama Game : ' + datapjl['nama_game'])),
                Center(child: Text('Tanggal Penjualan : ' + datapjl['tanggal_penjualan'])),
              ],
            ),
          )
        ],
      )
    );
  }
}
