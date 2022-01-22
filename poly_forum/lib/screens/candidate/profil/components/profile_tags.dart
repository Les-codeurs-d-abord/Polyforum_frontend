import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/profil/components/sized_btn.dart';
import 'package:poly_forum/utils/constants.dart';

import 'add_tag_modal.dart';

class ProfileTags extends StatefulWidget {
  final int maxTags = 10;
  final List<String> tags;
  const ProfileTags({required this.tags, Key? key}) : super(key: key);

  @override
  _ProfilTagsState createState() => _ProfilTagsState();
}

class _ProfilTagsState extends State<ProfileTags> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.tag_outlined),
              const SizedBox(width: 5),
              const Text("Tags"),
              const SizedBox(width: 5),
              Text(
                "${widget.tags.length}/${widget.maxTags}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (var tag in widget.tags)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.tag_outlined),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.tags.remove(tag);
                    });
                  },
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Supprimer le lien',
                ),
              ],
            ),
          SizedBox(height: widget.tags.isNotEmpty ? 20 : 0),
          Center(
            child: SizedBtn(
              text: "Ajouter un tag",
              fontSize: 14,
              onPressed: widget.tags.length < widget.maxTags
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddTagModal(tags: widget.tags);
                        },
                      ).then(
                        (value) {
                          if (value != null) {
                            setState(() {
                              widget.tags.add(value);
                            });
                          }
                        },
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
