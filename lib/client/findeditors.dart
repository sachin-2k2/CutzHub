import 'package:cutzhub/client/login.dart';
import 'package:cutzhub/client/manageproject.dart';
import 'package:cutzhub/client/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Findeditors extends StatefulWidget {
  const Findeditors({super.key});

  @override
  State<Findeditors> createState() => _FindeditorsState();
}

List<dynamic> editors = [];

final TextEditingController _proposalController = TextEditingController();
final TextEditingController _amountController = TextEditingController();
int? editorid;

Future<void> post_book(context) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? loginid = prefs.getInt('login_id');
    final response = await dio.post(
      '$baseurl/Book_APi/$loginid',
      data: {
        'PROJECTID': prid,
        'EDITORID': editorid,
        'proposal': _proposalController.text,
        'proposalamount': _amountController.text,
      },
    );
    print(_proposalController.text);
    print(_amountController.text);
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _proposalController.clear();
      _amountController.clear();

      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('book request  succesfull')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(' failed')));
    }
  } catch (e) {
    print(e);
  }
}

class _FindeditorsState extends State<Findeditors> {
  Future<void> get_editors(context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? loginid = prefs.getInt('login_id');

      if (loginid == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('User not logged in')));
        return;
      }

      final response = await dio.get('$baseurl/Editor_APi/');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          if (response.data is List) {
            editors = response.data;
            print(editors);
            editorid = int.parse(editors[0]['id'].toString());
            print(editorid);
          } else if (response.data is Map &&
              response.data['data'] != null &&
              response.data['data'] is List) {
            editors = response.data['data'];
          } else {
            editors = [];
          }
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to fetch editors')));
      }
    } catch (e) {
      print('Error fetching editors: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_editors(context);
  }

  @override
  Widget build(BuildContext context) {
    void showProposalDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 40, 40, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              "Send Proposal",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _proposalController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Proposal Details",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Proposal Amount",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  post_book(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Request"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Text(
              'FIND & BOOK EDITORS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: editors.length,
                itemBuilder: (context, index) {
                  final editor = editors[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Card(
                      color: Color.fromARGB(192, 82, 103, 94),
                      child: ListTile(
                        leading: Image.network(
                          '$baseurl${editor['Img']}',
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            editor['Name'] ?? 'Unknown',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  editor['Portfoliourl'] ??
                                      'portfolio not available',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  editor['Skill'] ?? 'Skills not available',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  editor['Phone'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  editor['Email'] ?? 'Email not available',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            SizedBox(height: 5),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              showProposalDialog(context);
                            },
                            child: Text('Book'),
                            style: ElevatedButton.styleFrom(
                              elevation: 5,

                              backgroundColor: const Color.fromARGB(
                                255,
                                101,
                                164,
                                103,
                              ),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
