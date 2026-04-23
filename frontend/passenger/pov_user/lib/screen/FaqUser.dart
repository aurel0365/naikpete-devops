import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primaryColor: Color(0xFF42C8DC),
      ),
      home: const HelpCenterScreen(),
    );
  }
}

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF42C8DC),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan background biru
          Container(
            color: Color(0xFF42C8DC),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bagaimana kami dapat membantu?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                // TextField untuk pencarian
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Cari artikel bantuan',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          // Bagian isi dengan ListView
          Expanded(
            child: ListView(
              children: [
                _buildSectionHeader('Pembayaran'),
                _buildHelpItem(context, 'Metode pembayaran apa saja yang diterima?'),
                _buildHelpItem(context, 'Bagaimana cara membayar dengan QRIS?'),
                _buildHelpItem(context, 'Bagaimana cara membayar dengan OVO?'),
                const Divider(height: 20.0, color: Colors.grey), // Garis pembatas
                const SizedBox(height: 10.0),
                _buildSectionHeader('Keamanan dan Kenyamanan'),
                _buildHelpItem(context, 'Apa saja tips aman saat menggunakan Naik Pete?'),
                _buildHelpItem(context, 'Bagaimana cara melaporkan masalah di aplikasi?'),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Latar belakang bagian isi menjadi putih
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HelpDetailScreen(title: title),
              ),
            );
          },
        ),
        const Divider(height: 1.0, color: Colors.grey), // Garis pembatas setiap item
      ],
    );
  }
}
class HelpDetailScreen extends StatelessWidget {
  final String title;

  const HelpDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF42C8DC),
        title: const Text(
          'Artikel Bantuan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Silakan baca artikel ini untuk mendapatkan informasi lebih lanjut tentang topik yang Anda pilih.",
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
            const SizedBox(height: 16.0),
            const Divider(height: 32.0),
            const Text(
              'Artikel terkait',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildRelatedArticle(context, 'Bagaimana cara mengubah metode pembayaran?'),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Background diubah menjadi putih
    );
  }

  Widget _buildRelatedArticle(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, color: Color(0xFF42C8DC)),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HelpDetailScreen(title: title),
              ),
            );
          },
        ),
        const Divider(height: 1.0, color: Colors.grey), // Garis pembatas artikel terkait
      ],
    );
  }
}
