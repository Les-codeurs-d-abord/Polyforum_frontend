import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';

// ignore: must_be_immutable
class EditableAvatar extends StatefulWidget {
  String initials = "";

  EditableAvatar(String text, {Key? key}) : super(key: key) {
    var nameparts = text.split(" ");
    if (nameparts.isNotEmpty) {
      initials = nameparts[0][0].toUpperCase();
    }
    if (nameparts.length > 1) {
      initials += nameparts[1][0].toUpperCase();
    }
  }

  @override
  State<EditableAvatar> createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> {
  ImageProvider? _imageProvider;
  bool isErrorFileToBig = false;
  final ImagePicker _picker = ImagePicker();
  XFile? uploadimage;

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
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          withReadStream: true,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpeg', 'jpg'],
                          withData: true,
                        );

                        if (result != null) {
                          var request = http.MultipartRequest(
                              'POST',
                              Uri.parse(
                                  'http://${kServer}/api/candidates/7/uploadLogo'));
                          request.files.add(http.MultipartFile(
                              'logo',
                              result.files.single.readStream!.cast(),
                              result.files.single.size,
                              filename: result.files.single.name,
                              contentType: MediaType(
                                  'image', result.files.single.extension!)));
                          var response = await request.send();
                        } else {
                          // User canceled the picker
                        }

                        // var f = await imageFile.readAsBytes();
                        // File file = File.fromRawPath(f);
                        // /* await sendFile(
                        //       "$kServer/api/candidates/1/uploadLogo", file); */

                        // if (f.length < 4000000) {
                        //   setState(() {
                        //     _imageProvider = MemoryImage(f);
                        //     /*  widget.file = file; */
                        //     isErrorFileToBig = false;
                        //   });
                        // } else {
                        //   setState(() {
                        //     isErrorFileToBig = true;
                        //   });
                        // }
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
