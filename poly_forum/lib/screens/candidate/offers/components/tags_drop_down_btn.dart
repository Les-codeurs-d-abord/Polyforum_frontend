import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/drop_down_offer_tag_cubit.dart';
import 'package:poly_forum/data/models/tag_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsDropDownBtn extends StatefulWidget {
  const TagsDropDownBtn({Key? key}) : super(key: key);

  @override
  _TagsDropDownBtnState createState() => _TagsDropDownBtnState();
}

class _TagsDropDownBtnState extends State<TagsDropDownBtn> {
  late Tag _selectedValue;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DropDownOfferTagCubit>(context).offerTagsEvent();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DropDownOfferTagCubit, DropDownOfferTagState>(
      listener: (context, state) {
        if (state is DropDownOfferTagLoaded) {
          _selectedValue = state.tags[0];
        }
      },
      builder: (context, state) {
        if (state is DropDownOfferTagLoaded) {
          if (state.tags.isNotEmpty) {
            return buildScreen(state.tags);
          } else {
            return const SizedBox();
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildScreen(List<Tag> tags) {
    List<DropdownMenuItem<Tag>> items = tags.map((item) {
      return DropdownMenuItem<Tag>(
        child: Text(item.label),
        value: item,
      );
    }).toList();

    return DecoratedBox(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<Tag>(
          value: _selectedValue,
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.black,
          ),
          underline: const SizedBox(),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
          hint: const Text("Tags"),
          items: items,
          onChanged: (value) {
            setState(() {
              _selectedValue = value!;
            });
          },
        ),
      ),
    );
  }
}
