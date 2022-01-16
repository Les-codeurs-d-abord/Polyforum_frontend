import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/utils/constants.dart';

import 'add_tag_modal.dart';

class ProfileTags extends StatefulWidget {
  final int maxTags = 10;
  final List<Tag> tags;
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
              const Text("Tags"),
              const SizedBox(width: 5),
              Text(
                "${widget.tags.length}/${widget.maxTags}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
/*           for (var tag in widget.tags)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.link_outlined,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    child: Text(
                      link,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    onTap: () => launch(link),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.links.remove(link);
                    });
                  },
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Supprimer le lien',
                ),
              ],
            ), */
          SizedBox(height: widget.tags.isNotEmpty ? 20 : 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: kButtonColor,
                      onSurface: Colors.grey,
                    ),
                    onPressed: widget.tags.length < widget.maxTags
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AddTagModal(tags: widget.tags);
                              },
                            ).then((value) {
                              setState(() {
                                widget.tags.add(value);
                              });
                            });
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Ajouter des tags",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
