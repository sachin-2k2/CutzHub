import 'package:cutzhub/client/manageproject.dart';
import 'package:cutzhub/client/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

TextEditingController cmp = TextEditingController();
final formkey = GlobalKey<FormState>();
List<dynamic> replay = [];

class _ComplaintState extends State<Complaint> {
  Future<void> post_complaint(context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? loginid = prefs.getInt('login_id');

      final response = await dio.post(
        '$baseurl/Complaint_Api/$loginid',
        data: {'Complaint': cmp.text},
      );

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint submitted successfully')),
        );
        cmp.clear();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Submission failed')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred')));
    }
  }

  Future<void> get_replay(context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? loginid = prefs.getInt('login_id');

      final response = await dio.get('$baseurl/Complaint_Api/$loginid');

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('replay fetched')));
        setState(() {
          replay = response.data;
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('failed to fetch replay')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_replay(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                'Raise Your Complaint',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 30),
            Form(
              key: formkey,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: cmp,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your complaint';
                  }
                  return null;
                },
                maxLines: 8,
                decoration: InputDecoration(
                  label: Text(
                    'Complaint.....',
                    style: TextStyle(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    post_complaint(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(180, 50),
                  backgroundColor: const Color.fromARGB(255, 48, 168, 110),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Replay:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            replay.isEmpty
                ? Text(
                    'No replies yet',
                    style: TextStyle(color: Colors.white70),
                  )
                : ListView.builder(
                    shrinkWrap: true, // allow ListView to fit content
                    physics:
                        NeverScrollableScrollPhysics(), // no scroll inside scroll
                    itemCount: replay.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          replay[index]['Reply'] ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
