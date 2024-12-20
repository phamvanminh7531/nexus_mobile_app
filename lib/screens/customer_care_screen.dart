import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key? key}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  final List<Map<String, String>> _tickets = []; // List to hold ticket data
  String? _editedImagePath;
  String? _capturedImagePath;
  String? _description;

  Future<void> _openEditDialog() async {
    final ImagePainterController localController = ImagePainterController(
      color: const Color.fromARGB(255, 255, 0, 0),
      strokeWidth: 2,
      mode: PaintMode.rect,
    );

    await showDialog(
      context: context,
      barrierDismissible: false,
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
                            Uint8List? byteArray = await localController.exportImage();
                            if (byteArray != null) {
                              final directory = await getApplicationDocumentsDirectory();
                              final filePath = '${directory.path}/edited_image.png';
                              final file = File(filePath);
                              await file.writeAsBytes(byteArray);

                              setState(() {
                                _editedImagePath = filePath;
                              });

                              Navigator.pop(context);  // Close the dialog after saving
                              _openFormDialog(filePath);  // Open form dialog after saving image
                            }
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: ImagePainter.asset(
                        "assets/images/layout_floor_3_ticket.png",
                        controller: localController,
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

    localController.dispose();
  }

  Future<void> _openFormDialog(String imagePath) async {
    final ImagePicker picker = ImagePicker();

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SizedBox(
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
                            onChanged: (value) {
                              setStateDialog(() {
                                _description = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Vị Trí",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Hình Lỗi",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    if (_editedImagePath != null)
                                      Image.file(
                                        File(_editedImagePath!),
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(width: 1, color: Colors.grey),
                              Expanded(
                                child: Column(
                                  children: [
                                    if (_capturedImagePath != null)
                                      Image.file(
                                        File(_capturedImagePath!),
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    const SizedBox(height: 16),
                                    IconButton(
                                      icon: const Icon(Icons.camera_alt, size: 50),
                                      onPressed: () async {
                                        final XFile? image =
                                            await picker.pickImage(source: ImageSource.camera);
                                        if (image != null) {
                                          setStateDialog(() {
                                            _capturedImagePath = image.path;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_description != null &&
                                    _editedImagePath != null &&
                                    _capturedImagePath != null) {
                                  final ticket = {
                                    "description": _description!,
                                    "editedImagePath": _editedImagePath!,
                                    "capturedImagePath": _capturedImagePath!,
                                  };
                                  setState(() {
                                    _tickets.add(ticket);
                                    print("Ticket added: $_tickets");
                                  });

                                  Navigator.pop(context);  // Close the form dialog
                                } else {
                                  print("Chưa điền đầy đủ thông tin");
                                }
                              },
                              child: const Text("Kết thúc"),
                            ),
                          ),
                        ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Image Example"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _openEditDialog,
            child: const Text("Open Edit Dialog"),
          ),
          Expanded(
            child: _tickets.isEmpty
                ? Center(child: Text("No tickets"))
                : ListView.builder(
                    itemCount: _tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = _tickets[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(ticket["description"] ?? "No Description"),
                          leading: ticket["editedImagePath"] != null
                              ? Image.file(File(ticket["editedImagePath"]!), width: 50, height: 50)
                              : Icon(Icons.image, size: 50),
                          trailing: ticket["capturedImagePath"] != null
                              ? Image.file(File(ticket["capturedImagePath"]!), width: 50, height: 50)
                              : Icon(Icons.camera_alt, size: 50),
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
