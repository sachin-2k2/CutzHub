import 'package:cutzhub/client/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cutzhub/client/manageproject.dart'; // make sure dio & baseurl are defined here

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];

  Future<void> getNotification() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? loginId = prefs.getInt('login_id');

      if (loginId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User not logged in')));
        return;
      }

      final response = await dio.get('$baseurl/Book_APi/$loginId');

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          notifications = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch notifications')),
        );
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('An error occurred')));
    }
  }

  @override
  void initState() {
    super.initState();
    getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const Text(
            'NOTIFICATIONS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: notifications.isEmpty
                ? const Center(
                    child: Text(
                      'No notifications yet',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: Card(
                          color: const Color.fromARGB(192, 82, 103, 94),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                '$baseurl${notification['Img']}',
                              ),
                            ),
                            title: Text(
                              notification['Name'] ?? 'Unknown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  'Project: ${notification['project'] ?? 'N/A'}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Proposal Amount: ${notification['proposalamount']?.toString() ?? 'N/A'}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Status: ${notification['Status'] ?? 'Pending'}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
