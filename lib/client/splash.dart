import 'package:cutzhub/client/home.dart';
import 'package:cutzhub/client/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash_page extends StatefulWidget {
  const splash_page({super.key});

  @override
  State<splash_page> createState() => _splash_pasgeState();
}

class _splash_pasgeState extends State<splash_page> {
  Future<void> check_login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool is_loged = pref.getBool('logged') ?? false;
    await Future.delayed(Duration(seconds: 1));
    if (is_loged) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
    }
  }

  @override
  void initState() {
    check_login();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(189, 251, 251, 251),
              radius: 70,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/cutz.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Cutz Hub',
              style: TextStyle(
                color: Colors.green,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 8
              ),
            ),
          ],
        ),
      ),
    );
  }
}
