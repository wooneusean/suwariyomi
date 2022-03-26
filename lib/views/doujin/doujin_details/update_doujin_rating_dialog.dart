import 'package:flutter/material.dart';

class UpdateRatingDialog extends StatefulWidget {
  final double prevRating;

  const UpdateRatingDialog({Key? key, required this.prevRating}) : super(key: key);

  @override
  State<UpdateRatingDialog> createState() => _UpdateRatingDialogState();
}

class _UpdateRatingDialogState extends State<UpdateRatingDialog> {
  double rating = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      rating = widget.prevRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 20,
        child: Slider(
          value: rating,
          max: 5,
          divisions: 5,
          label: rating.round().toString(),
          onChanged: (val) {
            setState(() {
              rating = val;
            });
          },
        ),
      ),
      title: Text('Update Rating'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, -1),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, rating.round()),
          child: const Text('Save'),
        ),
      ],
    );
  }
}