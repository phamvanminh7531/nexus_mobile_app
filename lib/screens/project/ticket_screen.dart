import 'package:flutter/material.dart';
import 'package:db_app/screens/project/create_new_ticket_screen.dart';
import 'package:db_app/screens/project/task_detail_screen.dart';
import 'package:db_app/screens/project/project_screen.dart';
import 'task_list.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(5, 34, 36, 1),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'TICKET',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            Builder(
              builder: (context) => Container(
                margin: const EdgeInsets.only(right: 16.0),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(5, 34, 36, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'ALL TASK FOR TICKET',
                    style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: tasks.map((task) {
                    return GestureDetector(
                      onTap: () {
                        // Điều hướng tới TaskDetailScreen khi nhấn vào task
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(task: task),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        color: const Color.fromRGBO(69, 90, 100, 1),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 16),
                                  Text(
                                    task["taskTitle"].toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    softWrap: true,
                                  ),
                                  Text(
                                    'Create Date: ${task["create_date"]}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Tooltip(
                                  message: 'View Details',
                                  child: IconButton(
                                    icon: const Icon(Icons.visibility,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    onPressed: () {
                                      // Điều hướng tới TaskDetailScreen khi nhấn biểu tượng
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TaskDetailScreen(task: task),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(38, 50, 56, 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromRGBO(254, 211, 106, 1),
                ),
                child: const Icon(
                  Icons.add,
                  size: 26,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreateNewTicketScreen()));
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromRGBO(254, 211, 106, 1),
                ),
                child: const Text(
                  'Add Ticket',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProjectScreen()));
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromRGBO(254, 211, 106, 1),
                ),
                child: const Icon(
                  Icons.settings,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Drawer(
            backgroundColor: const Color.fromARGB(176, 0, 0, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    title: const Text(
                      'THÔNG TIN DỰ ÁN',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 164, 80, 1),
                        fontSize: 26,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TicketScreen()));
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    title: const Text(
                      'TIẾN ĐỘ DỰ ÁN',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 164, 80, 1),
                        fontSize: 26,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TicketScreen()));
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    title: const Text(
                      'TÀI CHÍNH DỰ ÁN',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 164, 80, 1),
                        fontSize: 26,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TicketScreen()));
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    title: const Text(
                      'HÀNG HÓA DỰ ÁN',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 164, 80, 1),
                        fontSize: 26,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TicketScreen()));
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    title: const Text(
                      'LƯU Ý - NHẮC NHỞ',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 164, 80, 1),
                        fontSize: 26,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreateNewTicketScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
