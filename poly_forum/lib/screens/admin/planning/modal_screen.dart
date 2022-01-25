import 'package:poly_forum/cubit/admin/planning/admin_fill_slot_modal_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/pop_up_fill_slot.dart';

class FillSlotModalScreen extends StatelessWidget {
  final String period;

  const FillSlotModalScreen({Key? key, required this.period}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => AdminFillSlotModalCubit(),
          child: FillSlotModal(period: period)),
    );
  }
}
