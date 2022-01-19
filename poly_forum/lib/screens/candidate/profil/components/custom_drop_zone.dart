import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:poly_forum/screens/candidate/profil/components/sized_btn.dart';
import 'package:poly_forum/utils/constants.dart';

class FileDataModel {
  final String name;
  final String mime;
  final int bytes;
  final String url;
  final Uint8List fileData;

  FileDataModel(
      {required this.name,
      required this.mime,
      required this.bytes,
      required this.url,
      required this.fileData});

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}

class CustomDropZone extends StatefulWidget {
  const CustomDropZone({Key? key}) : super(key: key);

  @override
  State<CustomDropZone> createState() => _CustomDropZoneState();
}

class _CustomDropZoneState extends State<CustomDropZone> {
  late DropzoneViewController controller;
  FileDataModel? fileDataModel;
  bool highlighted = false;

  Future uploadedFile(dynamic event) async {
    final name = event.name;
    final fileData = await controller.getFileData(event);
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    setState(() {
      fileDataModel = FileDataModel(
        name: name,
        mime: mime,
        bytes: bytes,
        url: url,
        fileData: fileData,
      );
      highlighted = false;
    });
  }

  Widget buildRichText(String s1, String s2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: s1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: s2),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.file_copy_outlined),
              const SizedBox(width: 5),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    text: "CV",
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DottedBorder(
            child: Container(
              height: 200,
              color: highlighted ? Colors.grey : Colors.grey.withAlpha(20),
              child: Stack(
                children: [
                  buildZone1(context),
                  fileDataModel != null
                      ? Positioned(
                          bottom: 1,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete_outline),
                                tooltip: 'Supprimer le CV',
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                icon: const Icon(Icons.visibility_outlined),
                                tooltip: 'Ouvrir le CV',
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        fileDataModel == null
                            ? const Text(
                                "Déposez votre CV ici",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : Column(
                                children: [
                                  buildRichText("Nom: ", fileDataModel!.name),
                                  buildRichText("Type: ", fileDataModel!.mime),
                                  buildRichText("Size: ", fileDataModel!.size),
                                ],
                              ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: !highlighted
                              ? () async {
                                  final events = await controller.pickFiles(
                                      mime: [
                                        'image/jpeg',
                                        'image/png',
                                        'application/pdf'
                                      ]);
                                  if (events.isEmpty) return;
                                  uploadedFile(events.first);
                                }
                              : null,
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: kButtonColor,
                            onSurface: Colors.grey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.file_upload_outlined),
                                SizedBox(width: 5),
                                Text(
                                  "Import",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
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
          ),
        ],
      ),
    );
  }

  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => controller = ctrl,
          onLoaded: () => print('Zone 1 loaded'),
          onError: (ev) => print('Zone 1 error: $ev'),
          onHover: () {
            setState(() => highlighted = true);
          },
          onLeave: () {
            setState(() => highlighted = false);
          },
          onDrop: (ev) => uploadedFile(ev),
        ),
      );
}
