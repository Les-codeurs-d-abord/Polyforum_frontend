import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HTMLDescription extends StatelessWidget {
  final HtmlEditorController descriptionController;

  const HTMLDescription({required this.descriptionController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.article_outlined),
            const SizedBox(width: 5),
            Expanded(
              child: RichText(
                text: const TextSpan(
                  text: "Courte présentation",
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
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                height: 400,
                child: HtmlEditor(
                  controller: descriptionController,
                  htmlEditorOptions: const HtmlEditorOptions(
                    hint: 'Ajoute une courte description ici...',
                    characterLimit: 500,
                  ),
                  htmlToolbarOptions: const HtmlToolbarOptions(
                    toolbarType: ToolbarType.nativeGrid,
                    defaultToolbarButtons: [
                      StyleButtons(),
                      FontSettingButtons(fontName: false, fontSizeUnit: false),
                      FontButtons(
                          clearAll: false,
                          strikethrough: false,
                          superscript: false,
                          subscript: false),
                      ListButtons(listStyles: false),
                      ParagraphButtons(
                          textDirection: false,
                          lineHeight: false,
                          caseConverter: false),
                    ],
                    renderBorder: true,
                  ),
                  otherOptions: const OtherOptions(
                    height: 400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
