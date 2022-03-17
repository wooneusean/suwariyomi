import 'package:flutter/material.dart';

class DoujinDetailsRatingSlider extends StatelessWidget {
  DoujinDetailsRatingSlider({Key? key, required this.ratingSliderValue, required this.notifyRatingChanged})
      : super(key: key);

  final double ratingSliderValue;
  final Function(double value) notifyRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your Rating",
            style: Theme.of(context).textTheme.headline6?.merge(
                  TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
          ),
          Row(
            children: [
              Text(
                this.ratingSliderValue.round().toString(),
                style: Theme.of(context).textTheme.bodyText1?.merge(
                      TextStyle(fontSize: 18),
                    ),
              ),
              Icon(
                Icons.star,
                color: Colors.deepPurpleAccent,
                size: 24,
              ),
              Expanded(
                child: Slider(
                  value: this.ratingSliderValue,
                  max: 5,
                  divisions: 5,
                  label: this.ratingSliderValue.round().toString(),
                  onChanged: this.notifyRatingChanged,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
