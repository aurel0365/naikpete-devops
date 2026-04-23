import 'dart:async';
import 'package:flutter/material.dart';
import '../widget/BottomNavBar.dart';
import 'ConfirmInfoPete.dart';
import 'JadwalBerangkat.dart';
import 'Notification.dart';
import 'PencarianPete.dart';
import 'ProfileUser.dart';
import 'Tiket.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key, required String username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreens> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    HomeScreenBody(),
    Jadwalberangkat(),
    TicketScreen(),
    AccountUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final List<String> imageUrls = [
    'assets/images/berita1.jpg',
    'assets/images/berita2.jpg',
  ];

  late PageController _pageController;
  int _currentPage = 0;

  TextEditingController _locationController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Timer untuk mengontrol auto-scroll setiap 3 detik
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(Duration(seconds: 3), (Timer timer) {
        if (_pageController.hasClients) {
          if (_currentPage < imageUrls.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _locationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackgroundCarousel(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                _buildWelcomeSection(context),
                const SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 30),
                const Text(
                  "Layanan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                _buildServiceGrid(context),
                const SizedBox(height: 30),
                _buildInfoSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        viewportFraction: 1.0,
      ),
      items: imageUrls.map((url) {
        return Image.asset(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }).toList(),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selamat Datang",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Ubah warna teks menjadi putih
                fontFamily: 'Montserrat',
                shadows: [
                  Shadow(
                    offset: Offset(1.5, 1.5),
                    blurRadius: 4.0,
                    color: Colors.black54, // Tambahkan bayangan agar teks terlihat lebih jelas
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: const [
                Text(
                  "Kembali",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ubah warna teks menjadi putih
                    fontFamily: 'Montserrat',
                    shadows: [
                      Shadow(
                        offset: Offset(1.5, 1.5),
                        blurRadius: 4.0,
                        color: Colors.black54, // Tambahkan bayangan agar teks terlihat lebih jelas
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6),
              ],
            ),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(150, 66, 200, 220), // Background lebih solid dengan transparansi
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Bayangan lebih tajam
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white, // Ubah ikon menjadi putih
                size: 30, // Perbesar ukuran ikon
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Membuat sudut lebih bulat
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildLocationInput(Icons.location_on, "Lokasi anda saat ini", Colors.cyan, _locationController),
          const SizedBox(height: 16),
          _buildLocationInput(Icons.location_on, "Tujuan anda saat ini", Colors.red, _destinationController),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity, // Membuat tombol selebar container
            child: ElevatedButton(
              onPressed: () {
                String location = _locationController.text; // Ambil data dari controller untuk lokasi
                String destination = _destinationController.text; // Ambil data dari controller untuk tujuan

                if (location.isEmpty || destination.isEmpty) {
                  // Jika salah satu atau kedua input kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Tujuan anda atau lokasi anda kosong!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // Jika keduanya ada inputnya, lanjutkan ke halaman selanjutnya
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Confirmpete(
                        currentLocation: location, // Mengirimkan data yang benar
                        destination: destination,  // Mengirimkan data yang benar
                        location: '', 
                        selectedRoute: '', // Jika perlu mengirimkan data tambahan, pastikan untuk mendefinisikannya
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF42C8DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Cari", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLocationInput(IconData icon, String hintText, Color color, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: color, // Warna ikon sesuai dengan parameter
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Membuat sudut lebih bulat
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

Widget _buildServiceGrid(BuildContext context) {
  return GridView.count(
    crossAxisCount: 3,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [
      _buildServiceCard(context, Icons.directions_bus, "Transportasi", Colors.blue, Pencarianpete()), // Arahkan ke Pencarian Pete-Pete
      _buildServiceCard(context, Icons.location_on, "Halte", Colors.red, Pencarianpete()), // Arahkan ke Halte
    ],
  );
}

Widget _buildServiceCard(BuildContext context, IconData icon, String title, Color color, Widget targetScreen) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: () {
        // Arahkan ke layar yang sesuai saat ditekan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

  Widget _buildInfoSection() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Informasi Penting",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Cek jadwal keberangkatan pete-pete dan layanan lainnya langsung melalui aplikasi kami. Selalu update untuk fitur terbaru!",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      );
    }
  }