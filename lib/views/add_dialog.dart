import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/doujin_helper.dart';
import '../providers/doujin_provider.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final _nukeCode = TextEditingController();
  bool isButtonActive = true;

  SnackBar successSnackBar(doujin) => SnackBar(
        backgroundColor: Color.fromARGB(255, 67, 64, 73),
        content: Text(
          (doujin?.id!.toString())! +
              " - " +
              (doujin?.title!.pretty) +
              " added successfully",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 1500),
      );

  SnackBar failedSnackBar(_nukeCode, String errorMessage) => SnackBar(
        backgroundColor: Color.fromARGB(255, 67, 64, 73),
        content: Text(
          _nukeCode + ' - ' + errorMessage,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 2000),
      );

  @override
  void initState() {
    super.initState();
    _nukeCode.addListener(() {
      final isButtonActive = _nukeCode.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext dialogContext) {
    AlertDialog dialog = AlertDialog(
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Row(
        children: [
          Text('Add New Doujin '),
          Icon(Icons.assignment_outlined),
        ],
      ),
      content: Form(
        child: TextFormField(
          controller: _nukeCode,
          maxLength: 6,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(hintText: '177013'),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('SUBMIT'),
          onPressed: _nukeCode.text.isNotEmpty
              ? () async {
                  try {
                    var doujin = await DoujinHelper.scrape(
                        int.parse(_nukeCode.text.trim()));
                    var doujinProvider = DoujinProvider();
                    await doujinProvider.insert(doujin!);
                    Navigator.of(dialogContext).pop();
                    ScaffoldMessenger.of(dialogContext)
                        .showSnackBar(successSnackBar(doujin));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        failedSnackBar(_nukeCode.text.trim(), e.toString()));
                    Navigator.of(context).pop();
                  }
                }
              : null,
        )
      ],
    );

    return dialog;
  }
}
