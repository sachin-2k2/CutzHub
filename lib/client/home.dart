import 'package:cutzhub/client/complaint.dart';
import 'package:cutzhub/client/login.dart';
import 'package:cutzhub/client/findeditors.dart';
import 'package:cutzhub/client/manageproject.dart';
import 'package:cutzhub/client/notification.dart';
import 'package:cutzhub/client/viewrequest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void logout(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text(
          'Are you sure want to Logout ',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: const Color.fromARGB(255, 12, 12, 12)),
            ),
          ),
          TextButton(
            onPressed: () {
              log_out_splash(context);
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> log_out_splash(context) async {
    SharedPreferences logout = await SharedPreferences.getInstance();
    await logout.setBool('logged', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Loginpage()),
    );
  }

  @override
  void initState() {
    get_project(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: const Color.fromARGB(255, 107, 186, 158),
                    ),
                    iconSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                      'Find   your   edits',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'HOME',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Text(
              'Client   Dashboard',
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(203, 255, 255, 255),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 30,
                right: 20,
                left: 20,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Manage_project(),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      width: 160,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(192, 82, 103, 94),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: const Color.fromARGB(
                              255,
                              12,
                              12,
                              12,
                              // ignore: deprecated_member_use
                            ).withOpacity(.5),
                            blurRadius: 4,
                            offset: Offset(4, 4),
                            spreadRadius: 5,
                          ),
                        ],
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'MANAGE \n PROJECT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Icon(
                                      Icons.work_history_outlined,
                                      size: 28,
                                      color: const Color.fromARGB(
                                        255,
                                        107,
                                        186,
                                        158,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                ValueListenableBuilder<List<dynamic>>(
                                  valueListenable: projectDataNotifier,
                                  builder: (context, projects, _) {
                                    return Text(
                                      'Active  : ${projects.length}',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          125,
                                          255,
                                          255,
                                          255,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 22),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Findeditors()),
                      );
                    },
                    child: Container(
                      height: 200,
                      width: 160,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(192, 82, 103, 94),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: const Color.fromARGB(
                              255,
                              12,
                              12,
                              12,
                              // ignore: deprecated_member_use
                            ).withOpacity(.5),
                            blurRadius: 4,
                            offset: Offset(4, 4),
                            spreadRadius: 5,
                          ),
                        ],
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'FIND & BOOK\nEDITORS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                      'https://imgs.search.brave.com/hlR6h88YMP_CcOIOHkc7kOQJ6Ff5r9g7A7TZMbYgyAQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hcnRv/ZmZhdGhlcmhvb2Qu/bmV0L3dwLWNvbnRl/bnQvdXBsb2Fkcy8y/MDI1LzA1L0ZyZWRk/eS1NYWNEb25hbGQu/cG5n',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 36.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                      'https://imgs.search.brave.com/FD5VY97GGE5KD6Sabl-Q4F-kaaimh4DCLex5OfhwNTM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvaGQvb2xp/dmlhLXJvZHJpZ28t/YXQtbWFsZWZpY2Vu/dC1wcmVtaWVyZS15/andvMWZxam9uNGNw/dTkxLmpwZw',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Viewrequest()),
                  );
                },
                child: Container(
                  height: 100,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(192, 82, 103, 94),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: const Color.fromARGB(
                          255,
                          12,
                          12,
                          12,
                          // ignore: deprecated_member_use
                        ).withOpacity(.5),
                        blurRadius: 4,
                        offset: Offset(4, 4),
                        spreadRadius: 5,
                      ),
                    ],
                  ),

                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 30,
                      ),
                      child: Text(
                        'VIEW REQUESTS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Icon(
                        Icons.notifications_active,
                        color: const Color.fromARGB(171, 60, 190, 179),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Complaint()),
                      );
                    },
                    child: Container(
                      height: 110,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(192, 82, 103, 94),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: const Color.fromARGB(
                              255,
                              12,
                              12,
                              12,
                              // ignore: deprecated_member_use
                            ).withOpacity(.5),
                            blurRadius: 4,
                            offset: Offset(4, 4),
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Icon(
                            Icons.draw_sharp,
                            size: 32,
                            color: const Color.fromARGB(171, 60, 190, 179),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'COMPLAINTS',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 34),
                  InkWell(
                    onTap: () {
                      logout(context);
                    },
                    child: Container(
                      height: 110,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(192, 82, 103, 94),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: const Color.fromARGB(
                              255,
                              12,
                              12,
                              12,
                              // ignore: deprecated_member_use
                            ).withOpacity(.5),
                            blurRadius: 4,
                            offset: Offset(4, 4),
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                            size: 33,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'LOGOUT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
