import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'register_page.dart';

//admin
import 'admin_page.dart';
import 'admin_form_page.dart';
import 'admin_edit_page.dart';
import 'admin_detail_page.dart';

//game gratis
import 'game_gratis_page.dart';
import 'game_gratis_edit_page.dart';
import 'game_gratis_form_page.dart';
import 'game_gratis_detail_page.dart';

//game baru
import 'game_terbaru_page.dart';
import 'game_terbaru_edit_page.dart';
import 'game_terbaru_form_page.dart';
import 'game_terbaru_detail_page.dart';

//game laris
import 'game_terlaris_page.dart';
import 'game_terlaris_edit_page.dart';
import 'game_terlaris_form_page.dart';
import 'game_terlaris_detail_page.dart';

//pelanggan
import 'pelanggan_page.dart';
import 'pelanggan_edit_page.dart';
import 'pelanggan_form_page.dart';
import 'pelanggan_detail_page.dart';

//penjualan
import 'penjualan_page.dart';
import 'penjualan_edit_page.dart';
import 'penjualan_form_page.dart';
import 'penjualan_detail_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://hkluwacawczrvdgugqwi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhrbHV3YWNhd2N6cnZkZ3VncXdpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4NjA1MjAsImV4cCI6MjAyMDQzNjUyMH0.7kEGNPfdAggiAlgR4XP_DkEzZ9sZV-YuukrgSqECarQ',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Supabase.instance.client.auth.currentUser == null
          ? LoginPage()
          : HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home' :(context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        
        //admin
        '/admin':(context) => AdminPage(),
        '/admin-detail':(context) => AdminDetailPage(),
        '/admin-edit':(context) => AdminEditPage(),
        '/admin-form':(context) => AdminFormPage(),

        //game gratis
        '/gg':(context) => GameGratisPage(),
        '/gg-detail':(context) => GameGratisDetailPage(),
        '/gg-edit':(context) => GameGratisEditPage(),
        '/gg-form' :(context) => GameGratisFormPage(),
        

        //gamebaru
        '/gb':(context) => GameTerbaruPage(),
        '/gb-detail':(context) => GameTerbaruDetailPage(),
        '/gb-edit':(context) => GameTerbaruEditPage(),
        '/gb-form':(context) => GameTerbaruFormPage(),
        

        //gamelaris
        '/gl':(context) => GameTerlarisPage(),
        '/gl-detail':(context) => GameTerlarisDetailPage(),
        '/gl-edit':(context) => GameTerlarisEditPage(),
        '/gl-form':(context) => GameTerlarisFormPage(),

        //pelanggan
        '/pelanggan':(context) => PelangganPage(),
        '/pelanggan-detail':(context) => PelangganDetailPage(),
        '/pelanggan-edit':(context) => PelangganEditPage(),
        '/pelanggan-form':(context) => PelangganFormPage(),

        //penjualan
        '/penjualan':(context) => PenjualanPage(),
        '/penjualan-detail':(context) => PenjualanDetailPage(),
        '/penjualan-edit':(context) => PenjualanEditPage(),
        '/penjualan-form':(context) => PenjualanFormPage(),

      },
      builder: EasyLoading.init(),
    );
  }
}
