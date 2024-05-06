import 'package:expense_tracker_app/resources/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BudgetCard extends StatelessWidget {
  final spentAmount;
  final totalAmount;
  final title;
  final color;
  const BudgetCard(
      {super.key,
      required this.title,
      required this.spentAmount,
      required this.totalAmount,
      required this.color});

  @override
  Widget build(BuildContext context) {
    int remainingAmount = totalAmount - spentAmount;
    bool exceed = spentAmount > totalAmount ? true : false;
    if (exceed) {
      remainingAmount = 0;
    }

    double percentage = (spentAmount / totalAmount * 100) / 100;
    if (exceed) {
      percentage = 1;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xff1F1F1F),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // color: Color(0xffF1F1FA),
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color(0xffF1F1FA)
                        : Colors.black,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: color,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xff212325)
                                  : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Remaining \$${remainingAmount}",
                  style: TextStyle(
                      fontSize: Get.width * 0.065,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Color(0xff212325)
                          : Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                LinearPercentIndicator(
                  animation: true,
                  barRadius: Radius.circular(50),
                  lineHeight: 15,
                  percent: percentage,
                  progressColor: color,
                  backgroundColor: Color(0xffF1F1FA),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "\$${spentAmount} of \$${totalAmount}",
                  style: TextStyle(
                      fontSize: Get.width * 0.045,
                      color: Color(0xff91919F),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            spentAmount == totalAmount
                ? Row(
                    children: [
                      Text(
                        "You’ve reached the limit!",
                        style: TextStyle(
                            fontSize: Get.width * 0.04,
                            color: myRed,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                : SizedBox(),
            spentAmount > totalAmount
                ? Row(
                    children: [
                      Text(
                        "You’ve exceed the limit!",
                        style: TextStyle(
                            fontSize: Get.width * 0.04,
                            color: myRed,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
