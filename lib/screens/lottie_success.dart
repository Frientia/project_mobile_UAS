import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_uas/pages/home_page.dart';
import 'package:mobile_uas/pages/riwayat_pesanan.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MySuccess extends StatefulWidget {
  final String order_id;
  final String firebaseUid;

  const MySuccess({
    super.key,
    required this.order_id,
    required this.firebaseUid,
  });

   @override
  State<MySuccess> createState() => _MySuccessState();
}


class _MySuccessState extends State<MySuccess> {
  @override
  void initState() {
    super.initState();
    _initNotification();
    _showSuccessNotification();
  }

  Future<void> _initNotification() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await notificationsPlugin.initialize(initSettings);
  }

  Future<void> _showSuccessNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'payment_success',
      'Pembayaran',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      0,
      'Pembayaran Berhasil',
      'Terima kasih, pembayaran Anda telah berhasil',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pembayaran Berhasil',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 113, 50, 202),
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              'Tiket Anda berhasil diproses',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 8),

            Text(
              'Pesanan ID (#${widget.order_id}) berhasil diproses',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 24),
            Lottie.asset(
              'assets/animations/Check_Mark.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              repeat: true,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: 220,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 113, 50, 202),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Kembali ke Home',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: 220,
              height: 40,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 113, 50, 202),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
  builder: (_) => MyRiwayat(
    firebaseUid: widget.firebaseUid,
  ),
)

                  );
                },
                child: const Text('Lihat Riwayat Pesanan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
