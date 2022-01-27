import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';

// ignore: must_be_immutable
class EditableAvatar extends StatefulWidget {
  String initials = "";
  User user;

  EditableAvatar({required this.user, Key? key}) : super(key: key) {
    if (user.role == 'CANDIDAT') {
      CandidateUser candidateUser = user as CandidateUser;
      initials = candidateUser.firstName[0] + candidateUser.lastName[0];
    } else if (user.role == 'ENTREPRISE') {
      CompanyUser companyUser = user as CompanyUser;
      var nameparts = companyUser.companyName.split(" ");
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
  ImageProvider? _imageProvider;
  bool isErrorFileToBig = false;
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
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          withReadStream: true,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpeg', 'jpg'],
                          withData: true,
                        );

                        if (result != null) {
                          if (result.files.single.size < 4000000) {
                            setState(() {
                              isErrorFileToBig = false;
                            });

                            String uri = "";
                            if (widget.user.role == 'CANDIDAT') {
                              uri =
                                  'http://$kServer/api/candidates/${widget.user.id}/uploadLogo';
                            } else if (widget.user.role == 'ENTREPRISE') {
                              uri =
                                  'http://$kServer/api/companies/${widget.user.id}/uploadLogo';
                            }

                            var request =
                                http.MultipartRequest('POST', Uri.parse(uri));
                            request.files.add(http.MultipartFile(
                                'logo',
                                result.files.single.readStream!.cast(),
                                result.files.single.size,
                                filename: result.files.single.name,
                                contentType: MediaType.parse(lookupMimeType(
                                    result.files.single.name)!)));
                            var response = await request.send();
                            // TODO handle response
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
}
