import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditProfileUser.dart';
import 'FaqUser.dart';
import 'HistoryUser.dart';
import 'Notification.dart';
import 'Tiket.dart';

class AccountUser extends StatelessWidget {
  const AccountUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF42C8DC),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  int _ticketCount = 0; // Menambahkan variabel untuk menyimpan jumlah tiket

  @override
  void initState() {
    super.initState();
    _loadName();
    _loadTicketCount(); // Memuat jumlah tiket saat aplikasi dimulai
  }

  // Mengambil nama pengguna dari SharedPreferences
  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'John Doe';
    });
  }

  // Mengambil jumlah tiket dari SharedPreferences
  Future<void> _loadTicketCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ticketCount = prefs.getInt('ticketCount') ?? 0; // Default 0 jika belum ada data
    });
  }

  Future<void> _navigateToEditProfile() async {
    final updatedName = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );

    if (updatedName != null) {
      setState(() {
        _name = updatedName;
      });
    }
  }

  Future<void> _navigateToNotification() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationScreen()), // Halaman notifikasi
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/profile_image.png'),
          ),
          const SizedBox(height: 10),
          Text(
            _name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _name, // Menampilkan username di sini
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Container(
             margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF42C8DC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Menyusun ikon dengan jarak yang rata
              children: [
                GestureDetector(
                  onTap: _navigateToEditProfile,
                  child: Column(
                    children: [
                      Icon(Icons.person_outline, color: Colors.white, size: 30),
                      const SizedBox(height: 5),
                      Text('Profile', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        '$_ticketCount', // Menampilkan jumlah tiket
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Tickets', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _navigateToNotification,
                  child: Column(
                    children: [
                      Icon(Icons.notifications_outlined, color: Colors.white, size: 30),
                      const SizedBox(height: 5),
                      Text('Notifications', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                ProfileOption(
                  icon: Icons.help_outline,
                  title: 'FAQ',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQPage()),
                    );
                  },
                ),
                ProfileOption(
                  icon: Icons.history,
                  title: 'Purchase History',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()),
                    );
                  },
                ),
                ProfileOption(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onTap: () {
                    // Menambahkan logika log out, misalnya menghapus SharedPreferences
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.remove('name');
                      prefs.remove('ticketCount');
                      // Lakukan logika lainnya yang diperlukan untuk log out
                    });
                  },
                  isLogout: true, // Menandai bahwa ini adalah tombol log out
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const ProfileOption({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLogout ? Colors.red : Colors.white, // Mengubah warna untuk log out
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.white : Colors.black54),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.white : Colors.black,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
