import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetDetails extends StatelessWidget {
  int id;

  BudgetDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(
      //       kToolbarHeight + 16.0), // Adjust the height here as needed
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(vertical: 16.0),
      //     child: AppBar(
      //       backgroundColor: Theme.of(context).brightness == Brightness.light
      //           ? Color(0xffF0F2F5)
      //           : Color(0xff121212),
      //       centerTitle: true,
      //       title: Text(
      //         'Budget Details',
      //         style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w600,
      //             color: Theme.of(context).brightness == Brightness.light
      //                 ? Colors.black
      //                 : Colors.white),
      //       ),
      //       leading: GestureDetector(
      //         onTap: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: Image(
      //           image: Theme.of(context).brightness == Brightness.light
      //               ? AssetImage('assets/arrow-left-black.png')
      //               : AssetImage('assets/arrow-left.png'),
      //         ),
      //       ),

      //     ),
      //   ),
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 16.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Color(0xffF0F2F5)
              : Color(0xff121212),
          title: Text(
            'Transaction Details',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 16),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Return the AlertDialog widget
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Are you sure you want to delete?'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  // print(id);
                                  // id++;
                                  // print(id);
                                  print(id);
                                  final db = await dbHelper.database;
                                  await db.delete('budget_from_form',
                                      where: 'id = ?', whereArgs: [id]);
                                  print("delete");
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // User cancelled deletion
                                  Get.back(
                                      result:
                                          false); // Return false if user cancels
                                },
                                child: Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Image(
                        image: Theme.of(context).brightness == Brightness.light
                            ? AssetImage('assets/trash-black.png')
                            : AssetImage('assets/trash.png'))))
          ],
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image(
              image: Theme.of(context).brightness == Brightness.light
                  ? AssetImage('assets/arrow-left-black.png')
                  : AssetImage('assets/arrow-left.png'),
            ),
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
