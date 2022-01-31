import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:poly_forum/cubit/file_cubit.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDropZone extends StatefulWidget {
  final String uri;
  final String text;
  final bool isEnable;

  const CustomDropZone(
      {required this.text, required this.uri, required this.isEnable, Key? key})
      : super(key: key);

  @override
  State<CustomDropZone> createState() => _CustomDropZoneState();
}

class _CustomDropZoneState extends State<CustomDropZone> {
  late DropzoneViewController controller;
  bool highlighted = false;

  @override
  Widget build(BuildContext context) {
    return buildElement(context);
  }

  Widget buildElement(BuildContext context) {
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
                  text: TextSpan(
                    text: widget.text,
                    children: const [
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
          Container(
            height: 200,
            width: 500,
            decoration: BoxDecoration(
              color: highlighted ? Colors.grey.withAlpha(20) : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: BlocConsumer<FileCubit, FileState>(
              listener: (context, state) {
                if (state is FileLoaded) {
                  showTopSnackBar(
                    context,
                    Padding(
                      padding: kTopSnackBarPadding,
                      child: const CustomSnackBar.info(
                        message: "Le document a été ajouté avec succès.",
                      ),
                    ),
                  );
                } else if (state is FileError) {
                  showTopSnackBar(
                    context,
                    Padding(
                      padding: kTopSnackBarPadding,
                      child: CustomSnackBar.error(
                        message:
                            "Un problème est survenue avec l'upload du document: ${state.msg}",
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is FileLoading) {
                  highlighted = false;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FileLoaded) {
                  return buildLoadedContent(context, state.fileDataModel);
                } else if (state is FileUploaded) {
                  return buildContent(context, state.fileDataModel.uri);
                }

                return buildContent(context, widget.uri);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context, String uri) {
    return Stack(
      children: [
        buildZone1(context),
        uri.isNotEmpty
            ? Positioned(
                bottom: 1,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      launch("http://" + kServer + "/api/res/" + uri);
                    },
                    icon: const Icon(
                      Icons.visibility_outlined,
                      size: 40,
                    ),
                    tooltip: 'Ouvrir le CV',
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              uri.isEmpty
                  ? const Text(
                      "Déposez votre document ici",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : const Text(
                      "Votre document a bien été envoyé.",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: !highlighted
                    ? () async {
                        final events = await controller.pickFiles(mime: [
                          'image/jpeg',
                          'image/png',
                          'application/pdf'
                        ]);
                        if (events.isEmpty) return;
                        BlocProvider.of<FileCubit>(context)
                            .setCV(controller, events.first);
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
    );
  }

  Widget buildLoadedContent(BuildContext context, FileDataModel model) {
    return Stack(
      children: [
        buildZone1(context),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  buildRichText("Nom: ", model.name),
                  buildRichText("Type: ", model.mime),
                  buildRichText("Size: ", model.size),
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: !highlighted
                    ? () async {
                        final events = await controller.pickFiles(mime: [
                          'image/jpeg',
                          'image/png',
                          'application/pdf'
                        ]);
                        if (events.isEmpty) return;
                        BlocProvider.of<FileCubit>(context)
                            .setCV(controller, events.first);
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
    );
  }

  Widget buildRichText(String s1, String s2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: RichText(
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
        ),
      ],
    );
  }

  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => controller = ctrl,
          onHover: () {
            setState(() => highlighted = true);
          },
          onLeave: () {
            setState(() => highlighted = false);
          },
          onDrop: (event) async {
            BlocProvider.of<FileCubit>(context).setCV(controller, event);
          },
        ),
      );
}
