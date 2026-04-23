import 'package:flutter/material.dart';
import 'PembayaranTiket.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedPaymentMethod; // Untuk menyimpan metode pembayaran yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: _buildCustomBackButton(context),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Metode Pembayaran',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            _buildPaymentOption(
              title: 'QRIS Bank',
              value: 'qris_bank',
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              title: 'OVO',
              value: 'ovo',
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: _buildCheckoutButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF42C8DC)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildPaymentOption({required String title, required String value}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: selectedPaymentMethod == value ? const Color(0xFFE0F7FA) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            if (selectedPaymentMethod == value)
              const Icon(Icons.check_circle, color: Color(0xFF42C8DC))
          ],
        ),
      ),
    );
  }

  // Update onPressed di _buildCheckoutButton
Widget _buildCheckoutButton(BuildContext context) {
  return ElevatedButton(
    onPressed: selectedPaymentMethod != null
        ? () {
            // Kirim nilai selectedPaymentMethod ke TicketConfirmationScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketConfirmationScreen(
                  selectedPaymentMethod: selectedPaymentMethod,
                ),
              ),
            );
          }
        : null, // Tombol dinonaktifkan jika belum memilih metode pembayaran
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF42C8DC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      minimumSize: const Size(double.infinity, 50),
    ),
    child: const Text(
      'Selanjutnya',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
}