import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhaseIndicator extends StatelessWidget {
  const PhaseIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildItem(
          context,
          "1",
          "Inscription",
          BlocProvider.of<PhaseCubit>(context).getCurrentPhase() ==
              Phase.inscription,
          const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        const SizedBox(width: 5),
        buildItem(
          context,
          "2",
          "Vœux",
          BlocProvider.of<PhaseCubit>(context).getCurrentPhase() == Phase.wish,
          const BorderRadius.all(Radius.zero),
        ),
        const SizedBox(width: 5),
        buildItem(
          context,
          "3",
          "Planning",
          BlocProvider.of<PhaseCubit>(context).getCurrentPhase() ==
              Phase.planning,
          const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ],
    );
  }

  Widget buildItem(BuildContext context, String nb, String text, bool active,
      BorderRadius borderRadius) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: active ? kPrimaryColor : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: kButtonColor,
              radius: 20,
              child: Text(
                nb,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: active ? Colors.white : Colors.black,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
