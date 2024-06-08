import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
    
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        leadingWidth: 250,
        leading: Container(
          margin: EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset(
                "gambar/joystick.png",
                color: Colors.grey,
                colorBlendMode: BlendMode.modulate,
              ),
              SizedBox(width: 5),
              Text(
                'Game Store',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto'
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await Supabase.instance.client.auth.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  EasyLoading.showInfo("Terjadi Kesalahan $e");
                }
              },
            icon: Icon(Icons.logout_outlined)
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'Selamat Datang, ${Supabase.instance.client.auth.currentUser!.email!}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context,'/gg');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(140, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.gamepad, size : 40),
                      Text('Game Gratis'),
                    ],
                  ), 
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context,'/gb');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(140, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.gamepad, size : 40),
                      Text('Game Terbaru'),
                    ],
                  ), 
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/gl');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(140,100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.gamepad, size: 40),
                      Text('Game Terlaris'),
                    ],
                  )
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(140, 100),
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 40),
                      Text('Admin'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/pelanggan');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(140,100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_pin_rounded, size: 40),
                      Text('Pelanggan'),
                    ],
                  )
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/penjualan');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(140, 100),
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bar_chart, size: 40),
                      Text('Penjualan'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}