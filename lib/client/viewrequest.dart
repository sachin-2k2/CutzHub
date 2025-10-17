import 'package:flutter/material.dart';

class Viewrequest extends StatefulWidget {
  const Viewrequest({super.key});

  @override
  State<Viewrequest> createState() => _ViewrequestState();
}

class _ViewrequestState extends State<Viewrequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Text(
              'VIEW REQUESTS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
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
                          'https://imgs.search.brave.com/WCQxs5nOoyESRaHKubhVXwtFkKrzt2nTKSSBxhdBEos/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5hc3NldHR5cGUu/Y29tL2VkZXhsaXZl/L2ltcG9ydC8yMDE3/LzEwLzE2L29yaWdp/bmFsLzQuanBnP3c9/NDgwJmF1dG89Zm9y/bWF0LGNvbXByZXNz/JmZpdD1tYXg',
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Name',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'portfolio url',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Skills',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Phone Number',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Experience',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Accept'),
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Reject'),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 5,

                                      backgroundColor: const Color.fromARGB(255, 249, 1, 1),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
