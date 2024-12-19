import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:image_painter/image_painter.dart';

// Biến trạng thái để lưu giá trị được chọn
String _selectedFloor = 'Floor 1'; // Giá trị mặc định
String _selectedDepartment = 'Living Area'; // Giá trị mặc định
String _floorImage = 'assets/images/layout_floor_1_ticket.png';

class CreateNewTicketScreen extends StatefulWidget {
  const CreateNewTicketScreen({super.key});

  @override
  _CreateNewTicketScreenState createState() => _CreateNewTicketScreenState();
}

class _CreateNewTicketScreenState extends State<CreateNewTicketScreen> {
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
          'Create New Ticket',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromRGBO(5, 34, 36, 1),
      body: SingleChildScrollView(  // Wrap the body in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Task Title',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                child: const TextField(
                  textInputAction: TextInputAction.send,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: Colors.white,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true, // Kích hoạt nền
                    fillColor: Color.fromRGBO(69, 90, 100, 1), // Màu nền mong muốn
                    border: InputBorder.none, // Xóa đường viền
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  ),
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 26,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Task Details
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Task Details',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Floor',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        overflow: TextOverflow.ellipsis, // Cắt ngắn nếu không đủ không gian
                        softWrap: false, // Không xuống dòng
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Khoảng cách giữa nhãn và Dropdown
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(69, 90, 100, 1), // Màu nền
                      ),
                      child: DropdownButton<String>(
                        value: _selectedFloor, // Giá trị mặc định
                        dropdownColor: const Color.fromRGBO(69, 90, 100, 1), // Màu nền của danh sách
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        isExpanded: true, // Mở rộng theo chiều ngang
                        underline: const SizedBox(), // Xóa gạch dưới
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFloor = newValue!;
                            if (_selectedFloor == 'Floor 1') {
                              _floorImage = 'assets/images/layout_floor_1_ticket.png';
                            } else if (_selectedFloor == 'Floor 2') {
                              _floorImage = 'assets/images/layout_floor_2_ticket.png';
                            } else if (_selectedFloor == 'Floor 3') {
                              _floorImage = 'assets/images/layout_floor_3_ticket.png';
                            }
                          });
                        },
                        items: <String>['Floor 1', 'Floor 2', 'Floor 3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18), // Khoảng cách giữa các dòng
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Department',
                        style: TextStyle(
                          fontSize: 26,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        overflow: TextOverflow.ellipsis, // Cắt ngắn nếu không đủ không gian
                        softWrap: false, // Không xuống dòng
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Khoảng cách giữa nhãn và Dropdown
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(69, 90, 100, 1), // Màu nền
                      ),
                      child: DropdownButton<String>(
                        value: _selectedDepartment, // Giá trị mặc định
                        dropdownColor: const Color.fromRGBO(69, 90, 100, 1), // Màu nền của danh sách
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        isExpanded: true, // Mở rộng theo chiều ngang
                        underline: const SizedBox(), // Xóa gạch dưới
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDepartment = newValue!;
                          });
                        },
                        items: <String>['Living Area', 'Kitchen', 'Bedroom']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 9.0),
                child: const Text(
                  'LAYOUT',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 122, 0, 1),
                  ),
                ),
              ),
              Container(
                height: 300,
                width: 600,
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: InstaImageViewer(
                    child: Image.asset(_floorImage),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'List Ticket',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  // Hành động khi nhấn nút
                  
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromRGBO(254, 211, 106, 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 26,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200, // Chiều rộng mong muốn
              child: ElevatedButton(
                onPressed: () {
                  // Hành động khi nhấn nút
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromRGBO(254, 211, 106, 1),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  // Hành động khi nhấn nút
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(1),
                  backgroundColor: const Color.fromRGBO(254, 211, 106, 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.settings,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
