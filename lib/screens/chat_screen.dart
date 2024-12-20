import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? _savedImagePath;

  Future<void> _openImagePainter() async {
    final ImagePainterController controller = ImagePainterController(
      color: const Color.fromARGB(255, 255, 0, 0),
      strokeWidth: 2,
      mode: PaintMode.rect,
    );

    // Mở BottomSheet
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateBottomSheet) {
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
                          Uint8List? byteArray = await controller.exportImage();
                          if (byteArray != null) {
                            final directory = await getApplicationDocumentsDirectory();
                            final filePath = '${directory.path}/edited_image.png';
                            final file = File(filePath);

                            await file.writeAsBytes(byteArray); // Lưu ảnh
                            setState(() {
                              _savedImagePath = filePath;
                            });

                            Navigator.pop(context); // Đóng BottomSheet
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Image saved successfully!")),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ImagePainter.asset(
                      "assets/images/layout_floor_3_ticket.png",
                      controller: controller,
                      scalable: true,
                      textDelegate: TextDelegate(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    // Hủy controller
    controller.dispose();
  }

  Widget _displaySavedImage() {
    if (_savedImagePath == null) {
      return const Center(
        child: Text(
          "No saved image yet",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      );
    }

    return Column(
      children: [
        const Text(
          "Saved Image:",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Expanded(
          child: Image.file(
            File(_savedImagePath!),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Painter Example"),
      ),
      body: Column(
        children: [
          // Hiển thị ảnh đã lưu
          Expanded(
            child: _displaySavedImage(),
          ),
          // Nút mở ImagePainter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _openImagePainter,
              child: const Text("Open Image Painter"),
            ),
          ),
        ],
      ),
    );
  }
}
