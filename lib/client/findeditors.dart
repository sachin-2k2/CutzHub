import 'package:flutter/material.dart';

class Findeditors extends StatefulWidget {
  const Findeditors({super.key});

  @override
  State<Findeditors> createState() => _FindeditorsState();
}

class _FindeditorsState extends State<Findeditors> {
  @override
  Widget build(BuildContext context) {
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
                          'https://imgs.search.brave.com/FnjOoBRWn2IEIQuEqH4f7TlaI_V9vmVnOw10__gZmEc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly8xMjFj/bGlja3MuY29tL3dw/LWNvbnRlbnQvdXBs/b2Fkcy8yMDI0LzEx/L3ZhcnVuLWFkaXR5/YS1waG90b2dyYXBo/ZXIuanBn',
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
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
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
