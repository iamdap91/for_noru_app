import 'package:flutter/material.dart';
import 'package:for_noru_app/constants/vote-type.dart';
import 'package:for_noru_app/stores/content.store.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class PercentageIndicator extends StatelessWidget {
  final String text;
  final double percentage;
  final int code;
  final VOTE_TYPE voteType;

  PercentageIndicator({
    Key? key,
    required String this.text,
    required VOTE_TYPE this.voteType,
    required double this.percentage,
    required int this.code,
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
                context
                    .read<ContentStore>()
                    .vote(
                      code: this.code,
                      voteType: this.voteType,
                      castType: VOTE_CAST_TYPE.INCREMENT,
                    )
                    .then((String message) => {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              duration: Duration(milliseconds: 500),
                            ),
                          ),
                        });
              },
              icon: Icon(Icons.circle_outlined),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                context
                    .read<ContentStore>()
                    .vote(
                      code: this.code,
                      voteType: this.voteType,
                      castType: VOTE_CAST_TYPE.DECREMENT,
                    )
                    .then((String message) => {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              duration: Duration(milliseconds: 500),
                            ),
                          ),
                        });
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
