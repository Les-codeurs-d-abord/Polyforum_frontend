import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:async';

// ignore: must_be_immutable
class EditableAvatar extends StatefulWidget {
  String initials = "";

  EditableAvatar(String text, {Key? key}) : super(key: key) {
    if (text.contains(RegExp(r'[A-Z]'))) {
      var nameparts = text.split(" ");
      if (nameparts.isNotEmpty) {
        initials = nameparts[0][0].toUpperCase();
      }
      if (nameparts.length > 1) {
        initials += nameparts[1][0].toUpperCase();
      }
    }
  }

  @override
  State<EditableAvatar> createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> {
  final ImagePicker _picker = ImagePicker();
  ImageProvider? _imageProvider;
  bool isErrorFileToBig = false;

  List<int> _selectedFile = [];
  Uint8List? _bytesData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            children: [
              Positioned.fill(
                child: CircleAvatar(
                  backgroundImage: _imageProvider,
                  child: _imageProvider == null
                      ? Text(
                          widget.initials,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Material(
                    color: kButtonColor,
                    child: InkWell(
                      /*  onTap: () async {
                        /* startWebFilePicker(); */
                      }, */
                      onTap: () async {
                        final XFile? imageFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (imageFile != null) {
                          var f = await imageFile.readAsBytes();
                          File file = File.fromRawPath(f);
                          /* await sendFile(
                              "$kServer/api/candidates/1/uploadLogo", file); */

                          if (f.length < 4000000) {
                            setState(() {
                              _imageProvider = MemoryImage(f);
                              /*  widget.file = file; */
                              isErrorFileToBig = false;
                            });
                          } else {
                            setState(() {
                              isErrorFileToBig = true;
                            });
                          }
                        }
                      },
                      child: const SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        isErrorFileToBig ? const SizedBox(height: 20) : const SizedBox.shrink(),
        isErrorFileToBig
            ? const Text(
                "L'image est trop volumineuse (max. 4 Mo)",
                style: TextStyle(color: Colors.red),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result!);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    /* setState(() { */
    _bytesData = Base64Decoder().convert(result.toString().split(",").last);
    _selectedFile = _bytesData!;
    /*  }); */

    /*  print(_bytesData); */
    print(_selectedFile);

    upload(_selectedFile);
  }

  void upload(List<int> file) async {
    var url = Uri.parse("$kServer/api/candidates/1/uploadLogo");
    var request = new http.MultipartRequest("POST", url);
    request.files.add(http.MultipartFile.fromBytes('file', file,
        contentType: MediaType('application', 'octet-stream'),
        filename: "file_up"));

    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });
  }
}
