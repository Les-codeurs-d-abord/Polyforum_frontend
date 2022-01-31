import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/image_cubit.dart';
import 'package:poly_forum/screens/shared/components/user/initials_avatar.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePicture extends StatelessWidget {
  final String uri;
  final String name;
  final bool withListenerEventOnChange;

  const ProfilePicture({
    Key? key,
    required this.uri,
    required this.name,
    this.withListenerEventOnChange = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (withListenerEventOnChange) {
      return BlocConsumer<ImageCubit, ImageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ImageLoading) {
            return const CircularProgressIndicator();
          } else if (state is ImageLoaded) {
            return CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage:
                  NetworkImage("http://" + kServer + "/api/res/" + state.uri),
            );
          }

          if (uri.isEmpty) {
            return InitialsAvatar(
              name,
              color: kPrimaryColor!,
              fontSize: 24,
            );
          } else {
            return CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage:
                  NetworkImage("http://" + kServer + "/api/res/" + uri),
            );
          }
        },
      );
    } else {
      if (uri.isEmpty) {
        return InitialsAvatar(
          name,
          color: kPrimaryColor!,
          fontSize: 24,
        );
      } else {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage:
              NetworkImage("http://" + kServer + "/api/res/" + uri),
        );
      }
    }

    // return CachedNetworkImage(
    //   imageUrl: uri.isNotEmpty ? 'http://$kServer/api/res/$uri' : '',
    //   placeholder: (context, url) => Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           width: width * 0.5,
    //           height: height * 0.5,
    //           child: const CircularProgressIndicator(),
    //         )
    //       ]),
    //   errorWidget: (context, url, error) => InitialsAvatar(defaultText),
    //   width: width,
    //   height: height,
    //   imageBuilder: (context, imageProvider) => Container(
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       image: DecorationImage(
    //         image: imageProvider,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    // );
  }
}
