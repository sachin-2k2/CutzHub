import 'package:cutzhub/client/home.dart';
import 'package:cutzhub/client/registration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}
int? loginid;
class _LoginpageState extends State<Loginpage> {
  

  Dio dio = Dio();
  

  @override
  Widget build(BuildContext context) {

    
    final formkey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    // ignore: non_constant_identifier_names
    Future<void> login_splash(context) async {
      // ignore: non_constant_identifier_names
      SharedPreferences log_in = await SharedPreferences.getInstance();
      await log_in.setBool('logged', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    }

    Future<void> post_login(context) async {
      try {
        final response = await dio.post(
          '$baseurl/LoginAPI/',
          data: {'Username': email.text, 'Password': password.text},
        );
        print(response.data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          loginid = response.data['login_id'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('login_id', loginid!);
          print(loginid);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
          );
          login_splash(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('login succesfull')));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('registration failed')));
        }
      } catch (e) {}
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/cutz.png'),
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'CutzHub',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Find your edits',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Text(
                      'LOG IN TO \n YOUR ACCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Text(
                      'Post Projects. Find Editors',
                      style: TextStyle(
                        color: const Color.fromARGB(191, 255, 255, 255),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        fillColor: const Color.fromARGB(211, 56, 56, 56),
                        filled: true,
                        label: Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 77, 192, 114),
                            width: 3,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 77, 192, 114),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your Password';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        fillColor: const Color.fromARGB(211, 56, 56, 56),
                        filled: true,
                        label: Text(
                          'Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 77, 192, 114),
                            width: 3,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 77, 192, 114),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      post_login(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(180, 50),
                      backgroundColor: const Color.fromARGB(255, 48, 168, 110),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont Have Account ?',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => registrationpage(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 77, 213, 143),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
