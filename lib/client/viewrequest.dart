import 'package:cutzhub/client/manageproject.dart';
import 'package:cutzhub/client/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Viewrequest extends StatefulWidget {
  const Viewrequest({super.key});

  @override
  State<Viewrequest> createState() => _ViewrequestState();
}

ValueNotifier<List<dynamic>> request = ValueNotifier([]);
int? reqid;

Future<void> get_request(context) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? loginid = prefs.getInt('login_id');

    if (loginid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final response = await dio.get('$baseurl/Req_APi/$loginid');
    print('Response data: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data is List) {
        request.value = List.from(response.data);
        reqid = response.data[0]['id'];
      } else if (response.data is Map &&
          response.data['data'] != null &&
          response.data['data'] is List) {
        request.value = List.from(response.data['data']);
      } else {
        request.value = [];
      }
    }
  } catch (e) {
    print('Error fetching request: $e');
  }
}

Future<void> Update_Accept(context) async {
  try {
    final response = await dio.get('$baseurl/Accept_Api/$reqid');
    print('Response data: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Request Accepted')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Operation Failed')));
    }
  } catch (e) {
    print('Error fetching request: $e');
  }
}

Future<void> Update_reject(context) async {
  try {
    final response = await dio.get('$baseurl/Reject_Api/$reqid');
    print('Response data: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Request Rejected')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Operation Failed')));
    }
  } catch (e) {
    print('Error fetching request: $e');
  }
}

class _ViewrequestState extends State<Viewrequest> {
  @override
  void initState() {
    super.initState();
    get_request(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'VIEW REQUESTS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<dynamic>>(
                valueListenable: request,
                builder: (context, requestList, _) {
                  if (requestList.isEmpty) {
                    return const Center(
                      child: Text(
                        'No requests found',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: requestList.length,
                    itemBuilder: (context, index) {
                      final req = requestList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Card(
                          color: const Color.fromARGB(192, 82, 103, 94),
                          child: ListTile(
                            leading: Image.network(
                              'https://imgs.search.brave.com/WCQxs5nOoyESRaHKubhVXwtFkKrzt2nTKSSBxhdBEos/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5hc3NldHR5cGUu/Y29tL2VkZXhsaXZl/L2ltcG9ydC8yMDE3/LzEwLzE2L29yaWdp/bmFsLzQuanBnP3c9/NDgwJmF1dG89Zm9y/bWF0LGNvbXByZXNz/JmZpdD1tYXg',
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                req['Name'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                const SizedBox(height: 10),
                                buildRow('Proposal :', req['proposal']),
                                const SizedBox(height: 10),
                                buildRow(
                                    'Proposal Amount :',
                                    req['proposalamount']
                                        .toString()),
                                const SizedBox(height: 10),
                                buildRow('Project Name :', req['project']),
                                const SizedBox(height: 10),
                                buildRow(
                                    'Portfolio URL :',
                                    req['Portfoliourl'].toString()),
                                const SizedBox(height: 10),
                                buildRow('Phone :', req['Phone']),
                                const SizedBox(height: 10),
                                buildRow('Email :', req['Email']),
                                const SizedBox(height: 10),
                                buildRow('Experience :',
                                    '${req['experianceyear']} Years'),
                                const SizedBox(height: 5),
                                // --- STATUS DISPLAY IN PLACE OF BUTTONS ---
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Builder(
                                        builder: (_) {
                                          final status = req['Status'] ?? '';

                                          if (status.isNotEmpty) {
                                            return Text(
                                              status,
                                              style: TextStyle(
                                                color: status == 'accepted'
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            );
                                          } else {
                                            return Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await Update_Accept(
                                                        context);
                                                    setState(() {
                                                      req['Status'] = 'accepted';
                                                    });
                                                  },
                                                  child: const Text('Accept'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 5,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 101, 164, 103),
                                                    foregroundColor: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await Update_reject(
                                                        context);
                                                    setState(() {
                                                      req['Status'] = 'rejected';
                                                    });
                                                  },
                                                  child: const Text('Reject'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 5,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 249, 1, 1),
                                                    foregroundColor: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                // --- END STATUS DISPLAY ---
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
