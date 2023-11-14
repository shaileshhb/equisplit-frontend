import 'package:equisplit_frontend/screens/skeleton/components/container.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';

class SkeletonCardBuilder extends StatelessWidget {
  const SkeletonCardBuilder({Key? key}) : super(key: key);
  final double marginLeft = 10.0;
  final double marginBottom = 10.0;
  final double marginTop = 10.0;
  final double marginHorizontal = 10.0;
  final double marginVertical = 5.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.blueGrey[100],
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
        // child: skeletonList(context),
        child: skeletonCard(context),
      ),
    );
  }

  Card skeletonCard(BuildContext context) {
    return Card(
      elevation: 0.2,
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal, vertical: marginVertical),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: marginLeft, top: marginTop),
                child: const SkeletonContainer.square(
                  width: 100,
                  height: 15.0,
                ),
              ),
            ],
          ),
          const Divider(
            color: GlobalColors.cardBorder,
            thickness: 0.8,
          ),
          Container(
            margin: EdgeInsets.only(bottom: marginBottom, left: marginLeft),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SkeletonContainer.square(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 15.0,
                ),
                const SizedBox(
                  height: 10,
                ),
                SkeletonContainer.square(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 15.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile skeletonList(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      leading: Container(
        padding: const EdgeInsets.only(
          right: 12.0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              color: Colors.white24,
            ),
          ),
        ),
        child: const Icon(Icons.account_balance_wallet),
      ),
      title: SkeletonContainer.square(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 15.0,
      ),
      subtitle: SkeletonContainer.square(
        width: MediaQuery.of(context).size.width * 0.2,
        height: 12.0,
      ),
    );
  }
}
