import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key? key}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  final ImagePainterController _controller = ImagePainterController(
    color: const Color.fromARGB(255, 255, 0, 0),
    strokeWidth: 2,
    mode: PaintMode.rect,
  );

  String? _savedImagePath;

  Future<void> _openEditDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Không cho phép đóng khi nhấn ra ngoài
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    AppBar(
                      title: const Text("Edit Image"),
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.save_alt),
                          onPressed: () async {
                            Uint8List? byteArray = await _controller.exportImage();
                            if (byteArray != null) {
                              // Lưu ảnh
                              final directory = await getApplicationDocumentsDirectory();
                              final filePath = '${directory.path}/edited_image.png';
                              final file = File(filePath);

                              await file.writeAsBytes(byteArray);

                              // Cập nhật đường dẫn ảnh
                              setState(() {
                                _savedImagePath = filePath;
                              });

                              // Đóng Dialog và mở Form mới
                              Navigator.pop(context); // Close the edit dialog
                              _openFormDialog(filePath); // Open the second dialog
                            }
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: ImagePainter.asset(
                        "assets/images/layout_floor_3_ticket.png",
                        controller: _controller,
                        scalable: true,
                        textDelegate: TextDelegate(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _openFormDialog(String imagePath) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Không cho phép đóng khi nhấn ra ngoài
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  title: const Text("Create Ticket 2"),
                  automaticallyImplyLeading: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Nhập mô tả lỗi...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Vị Trí",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Hình Lỗi",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Image.file(
                              File(imagePath),
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt, size: 50),
                              onPressed: _openEditDialog, // Mở lại dialog chỉnh sửa
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Image Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openEditDialog,
          child: const Text("Open Edit Dialog"),
        ),
      ),
    );
  }
}
