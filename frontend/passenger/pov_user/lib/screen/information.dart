import 'package:flutter/material.dart';
import 'dart:async';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  double distance = 1.0; // Jarak awal dalam KM
  Timer? _timer;
  bool isArrived = false;

  @override
  void initState() {
    super.initState();
    // Memulai timer untuk update jarak
    startDistanceUpdate();
  }

  void startDistanceUpdate() {
    // Update setiap 3 detik
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        // Mengurangi jarak sebesar 0.1 KM
        if (distance > 0.1) {
          distance -= 0.1;
        } else {
          // Jika jarak sudah 0, hentikan timer dan set isArrived
          distance = 0;
          isArrived = true;
          _timer?.cancel();
          // Tampilkan dialog pete-pete telah tiba
          showArrivalDialog();
        }
      });
    });
  }

  void showArrivalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pete-pete Telah Tiba'),
          content: const Text('Pete-pete anda telah tiba di lokasi penjemputan'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                // Navigasi ke halaman berikutnya atau kembali
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Membersihkan timer ketika widget di dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Car Illustration Container
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.cyan.withOpacity(0.1),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/AppLogo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Main Text
              const Text(
                'Silahkan Menunggu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              
              // Subtitle
              const Text(
                'Pete-pete akan segera tiba',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              
              // Distance Text
              Text(
                'Jarak pete-pete : ${distance.toStringAsFixed(1)} Km',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}