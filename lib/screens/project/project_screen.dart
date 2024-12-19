import 'package:flutter/material.dart';
import 'package:db_app/screens/project/ticket_screen.dart';
import 'package:db_app/screens/project/create_new_ticket.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Cần cài thư viện percent_indicator
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanItem {
  final String title;
  final String total;
  final String approved;
  final String processing;
  final double progress; // Phần trăm tiến độ

  PlanItem({
    required this.title,
    required this.total,
    required this.approved,
    required this.processing,
    required this.progress, // Phần trăm tiến độ (giá trị từ 0.0 đến 1.0)
  });
}

class TodoListItem{
  final String content;
  final String date;

  TodoListItem({
    required this.content,
    required this.date,
  });
}

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  // Dữ liệu mẫu
  List<PlanItem> planitems = [
    PlanItem(title: '3D', total: '1', approved: '1', processing: '0', progress: 1),
    PlanItem(title: 'MATERIAL', total: '25', approved: '20', processing: '2', progress: 0.75),
    PlanItem(title: 'SHOP DRAWINGS', total: '1', approved: '1', processing: '1', progress: 0.95),
    PlanItem(title: 'DOCUMENTS', total: '1', approved: '1', processing: '1', progress: 1),
  ];


  
  List<TodoListItem> todoitems = [
    TodoListItem(content: 'Bắn tấm nền MDF', date: '01 Aug'),
    TodoListItem(content: 'Thi công hệ sắt gia cố vách', date: '01 Aug'),
    TodoListItem(content: 'Hoàn thiện trần ốp gỗ laminate', date: '01 Aug'),
    TodoListItem(content: 'Bả xả, hoàn thiện sơn nước trần thạch cao, khe rèm', date: '01 Aug'),
  ];



    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(5, 34, 36, 1),
        titleSpacing: 16,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PROJECT NAME',
              style: TextStyle(
                color: Color(0xFFFFD700),
                fontSize: 18,
              ),
            ),
            Text(
              'Customer Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
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
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.lightBlue,
              child: Icon(
                Icons.face,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề cho danh sách cuộn ngang
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 9.0),
                child: const Text(
                  'HÌNH ẢNH DỰ ÁN HÔM QUA',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Danh sách cuộn ngang
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: InstaImageViewer(
                            child: Image.asset('assets/images/project_img_1.png'),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: InstaImageViewer(
                            child: Image.asset('assets/images/project_img_2.png'),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: InstaImageViewer(
                            child: Image.asset('assets/images/project_img_3.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Danh sách cuộn dọc
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: planitems.map((project) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Row(
                          children: [
                            // Cột thông tin dự án
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text('Total: ${project.total}'),
                                  SizedBox(height: 2),
                                  Text('Approved: ${project.approved}'),
                                  SizedBox(height: 2),
                                  Text('Processing: ${project.processing}'),
                                ],
                              ),
                            ),
                            SizedBox(width: 16), // Khoảng cách giữa cột 1 và cột 2
                            
                            // Cột tiến độ (vòng tròn)
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: CircularPercentIndicator(
                                  radius: 50.0,
                                  lineWidth: 4.0,
                                  percent: project.progress,
                                  center: Text(
                                    '${(project.progress * 100).toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  progressColor: const Color.fromRGBO(254, 211, 106, 1),
                                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                  
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  
                ),
              ),
              const SizedBox(height: 8),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 9.0),
                  child: const Text(
                    'TO DO LIST - TODAY',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: todoitems.map((todo) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        color: const Color.fromRGBO(69, 90, 100, 1),
                        child: Row(
                          children: [
                            Expanded(  // Cho phép nội dung chiếm không gian còn lại
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 16),
                                  Text(
                                    todo.content,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    softWrap: true,  // Cho phép text xuống dòng khi dài
                                  ),
                                  Text(
                                    'Due on: ${todo.date}', // Lấy chỉ phần ngày
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    softWrap: true,  // Cho phép text xuống dòng khi dài
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(5, 34, 36, 1),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: Drawer(
        backgroundColor: const Color.fromARGB(176, 0, 0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                title: const Text(
                  'THÔNG TIN DỰ ÁN',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 164, 80, 1),
                    fontSize: 26,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TicketScreen()));
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                title: const Text(
                  'TIẾN ĐỘ DỰ ÁN',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 164, 80, 1),
                    fontSize: 26,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TicketScreen()));
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                title: const Text(
                  'TÀI CHÍNH DỰ ÁN',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 164, 80, 1),
                    fontSize: 26,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TicketScreen()));
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                title: const Text(
                  'HÀNG HÓA DỰ ÁN',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 164, 80, 1),
                    fontSize: 26,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TicketScreen()));
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                title: const Text(
                  'LƯU Ý - NHẮC NHỞ',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 164, 80, 1),
                    fontSize: 26,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewTicketScreen()));
                },
              ),
            ],
          ),
        ),
      ),
      )

    );
  }
}
