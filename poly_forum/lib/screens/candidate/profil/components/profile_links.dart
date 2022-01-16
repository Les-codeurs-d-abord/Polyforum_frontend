import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_link_modal.dart';

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
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Supprimer le lien',
                ),
              ],
            ),
          SizedBox(height: widget.links.isNotEmpty ? 20 : 0),
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
                    onPressed: widget.links.length < widget.maxLinks
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AddLinkModal(links: widget.links);
                              },
                            ).then((value) {
                              setState(() {
                                widget.links.add(value);
                              });
                            });
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Ajouter un lien",
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
