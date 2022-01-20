import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'initials_avatar.dart';

class ProfilePicture extends StatelessWidget {
  final String uri;
  final String defaultText;
  final double? width;
  final double? height;

  const ProfilePicture({
    Key? key,
    required this.uri,
    required this.defaultText,
    this.width = 50,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: uri.isNotEmpty == true ? 'http://localhost:8080/api/res/$uri' : '',
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => InitialsAvatar(defaultText),
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
