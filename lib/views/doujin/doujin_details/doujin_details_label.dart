import 'package:flutter/material.dart';

class DoujinDetailsLabel extends StatelessWidget {
  const DoujinDetailsLabel({Key? key, required label})
      : _label = label,
        super(key: key);

  final String _label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Text(
        _label,
        style: Theme.of(context).textTheme.labelMedium?.merge(
              TextStyle(color: Colors.grey.shade500),
            ),
      ),
    );
  }
}
