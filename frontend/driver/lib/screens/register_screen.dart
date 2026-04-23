import 'package:flutter/material.dart';
import 'package:flutter_pete/screens/login_screen.dart';
import '../widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers untuk input data
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variabel untuk menyimpan pilihan peran (Driver/User)
  String? selectedRole;

  // Fungsi untuk validasi input
  bool validateForm() {
    if (firstNameController.text.isEmpty) {
      showError("Nama depan wajib diisi");
      return false;
    }
    if (lastNameController.text.isEmpty) {
      showError("Nama belakang wajib diisi");
      return false;
    }
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      showError("Masukkan email yang valid");
      return false;
    }
    if (phoneController.text.isEmpty || !isNumeric(phoneController.text)) {
      showError("Nomor telepon hanya boleh berisi angka");
      return false;
    }
    if (cityController.text.isEmpty) {
      showError("Kota wajib diisi");
      return false;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      showError("Password harus minimal 6 karakter");
      return false;
    }
    if (selectedRole == null) {
      showError("Silakan pilih peran Anda");
      return false;
    }
    return true;
  }

  // Fungsi untuk mengecek apakah input hanya angka
  bool isNumeric(String value) {
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  // Fungsi untuk menampilkan pesan error
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Fungsi untuk mengirim data ke backend dan navigasi ke halaman login
  void register() {
    if (!validateForm()) {
      return; // Jika validasi gagal, jangan lanjut
    }

    // Simpan data dan lakukan pengiriman ke backend
    print("Registrasi data dikirim ke backend");
    print("Nama depan: ${firstNameController.text}");
    print("Nama belakang: ${lastNameController.text}");
    print("Email: ${emailController.text}");
    print("Nomor telepon: ${phoneController.text}");
    print("Kota: ${cityController.text}");
    print("Password: ${passwordController.text}");
    print("Peran: $selectedRole");

    // Navigasi ke halaman login
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: const Text(
          'Daftar',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Isi Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Daftar menjadi mitra NaikPete\'',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // Input Nama Depan
            CustomTextField(
                hintText: 'Nama depan', controller: firstNameController),

            // Input Nama Belakang
            CustomTextField(
                hintText: 'Nama belakang', controller: lastNameController),

            // Input Email
            CustomTextField(hintText: 'Email', controller: emailController),

            // Input Nomor Telepon
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Nomor telepon',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

            // Input Kota
            CustomTextField(hintText: 'Kota', controller: cityController),

            // Input Password
            CustomTextField(
                hintText: 'Password',
                isPassword: true,
                controller: passwordController),

            const SizedBox(height: 20),

            // Dropdown untuk memilih peran
            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: InputDecoration(
                hintText: 'Pilih peran Anda',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Driver', child: Text('Driver')),
                DropdownMenuItem(value: 'User', child: Text('User')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Tombol Selanjutnya
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: register,
              child: const Text('Selanjutnya',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
