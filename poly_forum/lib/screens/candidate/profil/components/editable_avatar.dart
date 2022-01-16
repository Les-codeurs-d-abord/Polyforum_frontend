import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poly_forum/utils/constants.dart';

// ignore: must_be_immutable
class EditableAvatar extends StatefulWidget {
  String initials = "";
  File? file;

  EditableAvatar(String text, {required this.file, Key? key})
      : super(key: key) {
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
                      onTap: () async {
                        final XFile? imageFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (imageFile != null) {
                          var f = await imageFile.readAsBytes();
                          File file = File.fromRawPath(f);

                          if (f.length < 4000000) {
                            setState(() {
                              _imageProvider = MemoryImage(f);
                              widget.file = file;
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

  uploadFileFromDio(File photoFile) async {
    var dio = Dio();
    dio.options.baseUrl = kServer;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    /* dio.options.headers = <Header Json>; */
    FormData formData = FormData();
/*     formData.add("user_id", userProfile.userId);
    formData.add("name", userProfile.name);
    formData.add("email", userProfile.email); */

    if (photoFile != null &&
        photoFile.path != null &&
        photoFile.path.isNotEmpty) {
      var formData = FormData.fromMap({
        'user_picture': photoFile,
      });
/*       // Create a FormData
      String fileName = basename(photoFile.path);
      print("File Name : $fileName");
      print("File Size : ${photoFile.lengthSync()}");
      formData.add("user_picture", UploadFileInfo(photoFile, fileName)); */
    }
    var response = await dio.post("user/manage_profile",
        data: formData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
  }
}
