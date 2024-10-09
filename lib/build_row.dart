import 'package:flutter/material.dart';

class BuildRow extends StatelessWidget {
  final String title;
  final String value;
  BuildRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title ?? '-',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
              ),
              Text(':  '),
              Expanded(child: Text(value ?? '-',textAlign: TextAlign.right,style: TextStyle(fontSize: 16))),

            ],
          ),
        ),
        //Expanded(child: Text(value ?? '-')),
      ],
    );
  }
}