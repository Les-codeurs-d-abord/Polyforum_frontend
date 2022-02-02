import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/info_phase_cubit.dart';

class InfoPhase extends StatelessWidget {
  const InfoPhase({
    Key? key,
    required this.context,
    required this.info,
  }) : super(key: key);

  final BuildContext context;
  final Info info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        info.isValid
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            info.text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
