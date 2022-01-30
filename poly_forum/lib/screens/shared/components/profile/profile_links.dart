import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_link_modal.dart';
import 'sized_btn.dart';

class ProfileLinks extends StatefulWidget {
  final int maxLinks = 6;
  final List<String> links;
  const ProfileLinks({required this.links, Key? key}) : super(key: key);

  @override
  _ProfilTagsState createState() => _ProfilTagsState();
}

class _ProfilTagsState extends State<ProfileLinks> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.link_outlined),
              const SizedBox(width: 5),
              const Text("Liens"),
              const SizedBox(width: 5),
              Text(
                "${widget.links.length}/${widget.maxLinks}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (var link in widget.links)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.link_outlined),
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
            ),
          SizedBox(height: widget.links.isNotEmpty ? 20 : 0),
          Center(
            child: SizedBtn(
              text: "Ajouter un lien",
              fontSize: 14,
              onPressed: widget.links.length < widget.maxLinks
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddLinkModal(links: widget.links);
                        },
                      ).then(
                        (value) {
                          if (value != null) {
                            setState(
                              () {
                                widget.links.add(value);
                              },
                            );
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
