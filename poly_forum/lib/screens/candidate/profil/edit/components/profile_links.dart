import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/profil/edit/components/sized_btn.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_link_modal.dart';

class ProfileLinks extends StatefulWidget {
  final int maxLinks = 6;
  final List<String> links;
  final bool disabled;

  const ProfileLinks({
    required this.links,
    required this.disabled,
    Key? key
  }) : super(key: key);

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
            Padding(
              padding: EdgeInsets.symmetric(vertical: widget.disabled ? 3.0 : 0.0),
              child: Row(
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
                  if (!widget.disabled)
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
            ),
          if (!widget.disabled)
            SizedBox(height: widget.links.isNotEmpty ? 20 : 0),
          if (!widget.disabled)
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
