import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pete/widgets/custom_textfield.dart';
import 'forgotpassword.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void login() async {
    final name = nameController.text;
    final password = passwordController.text;

    if (name.isNotEmpty && password.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(username: name)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Nama atau kata sandi tidak boleh kosong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/AppLogo.png',
                height: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Selamat datang kembali',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Nama',
                controller: nameController,
                keyboardType: TextInputType.text,
                borderRadius: BorderRadius.circular(10.0), 
                suffixIcon: GestureDetector(  // Adding the required suffixIcon
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Kata sandi',
                isPassword: !_isPasswordVisible, // Toggle password visibility
                controller: passwordController,
                borderRadius: BorderRadius.circular(10.0), 
                keyboardType: TextInputType.text,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0), // Jarak horizontal agar tidak terlalu rapat
                    child: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5), // Jarak antara textfield dan tombol lupa password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'Lupa kata sandi?',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Jarak antara lupa kata sandi dan tombol masuk
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Sudut bulat yang konsisten
                  ),
                  minimumSize: Size(double.infinity, 50), // Membuat tombol sesuai panjang textfield
                ),
                onPressed: login,
                child: const Text('Masuk', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Belum memiliki akun? ',
                        style: TextStyle(color: Colors.black), // Black color for "Belum memiliki akun?"
                      ),
                      TextSpan(
                        text: 'Daftar',
                        style: TextStyle(color: Colors.cyan), // Cyan color for "Daftar"
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
