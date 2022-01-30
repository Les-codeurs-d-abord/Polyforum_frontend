import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/image_cubit.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class EditableAvatar extends StatefulWidget {
  final String name;
  final String uri;
  final User user;

  const EditableAvatar(
      {required this.name, required this.uri, required this.user, Key? key})
      : super(key: key);

  @override
  State<EditableAvatar> createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> {
  bool isErrorFileToBig = false;

  @override
  void initState() {
    super.initState();
  }

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
                child: BlocConsumer<ImageCubit, ImageState>(
                  listener: (context, state) {
                    if (state is ImageLoaded) {
                      showTopSnackBar(
                        context,
                        Padding(
                          padding: kTopSnackBarPadding,
                          child: const CustomSnackBar.success(
                            message: "Sauvegarde effectuée avec succès !",
                          ),
                        ),
                      );
                    } else if (state is ImageError) {
                      showTopSnackBar(
                        context,
                        Padding(
                          padding: kTopSnackBarPadding,
                          child: const CustomSnackBar.error(
                            message:
                                "Un problème est survenue, la sauvegarde ne s'est pas effectuée...",
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ImageLoaded) {
                      return ProfilePicture(
                        uri: state.pathLogo,
                        name: widget.name,
                        withListenerEventOnChange: true,
                      );
                    }

                    return ProfilePicture(
                      uri: widget.uri,
                      name: widget.name,
                      withListenerEventOnChange: true,
                    );
                  },
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
                          // PlatformFile file = result.files.first;

                          if (result.files.single.size < 4000000) {
                            BlocProvider.of<ImageCubit>(context)
                                .uploadLogo(result.files.single, widget.user);
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
