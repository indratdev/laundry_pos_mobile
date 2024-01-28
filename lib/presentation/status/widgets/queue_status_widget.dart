import 'package:flutter/material.dart';

class QuequeStatusWidget extends StatelessWidget {
  const QuequeStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(14, 4, 14, 4),
      separatorBuilder: (context, index) => Divider(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("LELE"),
                  Text("5 KG / Regular"),
                ],
              ),
              Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("ax001231"),
                  Text("Lunas"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
