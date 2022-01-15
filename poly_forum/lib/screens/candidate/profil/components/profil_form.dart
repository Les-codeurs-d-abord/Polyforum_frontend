import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class ProfilForm extends StatefulWidget {
  const ProfilForm({Key? key}) : super(key: key);

  @override
  _ProfilFormState createState() => _ProfilFormState();
}

class _ProfilFormState extends State<ProfilForm> {
  final _formKey = GlobalKey<FormState>();
  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Prénom"),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    validator: (value) => validateObligatoryField(value!),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 200,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: kButtonColor,
              onSurface: Colors.grey,
            ),
            onPressed: isLoading
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Sauvegarder",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  String? validateObligatoryField(String value) {
    if (value.isEmpty) {
      return "* Champs Requis";
    }

    return null;
  }
}
