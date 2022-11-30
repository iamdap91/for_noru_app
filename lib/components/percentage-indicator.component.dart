import 'package:flutter/material.dart';
import 'package:for_noru_app/stores/content.store.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class PercentageIndicator extends StatelessWidget {
  String text;
  double percentage;

  PercentageIndicator({
    Key? key,
    required String this.text,
    required double this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LinearPercentIndicator(
        animation: true,
        lineHeight: 40.0,
        animationDuration: 500,
        backgroundColor: Colors.white,
        percent: percentage,
        center: Text(text),
        trailing: Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<ContentStore>().vote();
              },
              icon: Icon(Icons.circle_outlined),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                context.read<ContentStore>().vote();
              },
              icon: Icon(Icons.close),
              color: Colors.red,
            ),
          ],
        ),
        barRadius: Radius.circular(100),
        progressColor: percentage > 0.5 ? Colors.orange : Colors.grey,
      ),
    );
  }
}

// 2962FF
