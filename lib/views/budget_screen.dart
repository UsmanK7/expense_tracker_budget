import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker_app/resources/budget_card.dart';
import 'package:expense_tracker_app/resources/theme.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:expense_tracker_app/views/budget_details.dart';
import 'package:expense_tracker_app/views/create_budget_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BudgetScreen extends StatefulWidget {
  BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final List<String> items = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  DBHelper dbHelper = DBHelper();

  Future<int> fetchTotalAmount(int id) async {
    final db = await dbHelper.database;
    id++;
    final amount =
        await db.query('budget_from_form', where: 'id = ?', whereArgs: [id]);

    return amount.first['budget_amount'] as int;
  }

  // Future<List<Map<String, dynamic>>> getBudgets() async {
  //   final db = await dbHelper.database;
  //   return await db.query('budget_from_form');
  // }
  Future<List<Map<String, dynamic>>> getBudgets() async {
    final db = await dbHelper.database;
    return await db.rawQuery('''
SELECT *
FROM budget_from_form
INNER JOIN categories
ON budget_from_form.category_id = categories.category_id
''');
  }

  Future<int> getCategoryId(int id) async {
    final db = await dbHelper.database;

    final amount =
        await db.query('budget_from_form', where: 'id = ?', whereArgs: [id]);

    return amount.first['category_id'] as int;
  }

  Future<int> fetchSpentAmount(int id) async {
    final db = await dbHelper.database;
    // final List<Map<String, dynamic>> budget =
    //     await db.query('budget_from_form');
    // int category = budget[0]['category_id'];

    final List<Map<String, dynamic>> transactions =
        await db.query('transactions');
    // final amounts = transactions
    //     .map((e) => e['category_id'] == cateogry as int)
    //     .toList();
    final amounts = transactions
        .where((e) => e['category_id'] == id)
        .map((e) => e['amount'] as int)
        .toList();
    var sum = amounts.reduce((value, element) => value + element);
    return sum;
  }

  int currentMonth = DateTime.now().month;
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = items[currentMonth - 1];
  }

  @override
  Widget build(BuildContext context) {
    // print(fetchSpentAmount(3));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 16.0), // Adjust the height here as needed
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Monthly Budget',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: myblue,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          // isExpanded: true,
                          hint: Row(
                            children: [
                              Text(
                                'Month',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getBudgets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final List<Map<String, dynamic>> dataList =
                      List<Map<String, dynamic>>.from(snapshot.data!);
                  int currentMonth = items.indexOf(selectedValue);
                  currentMonth++;

                  final list = dataList
                      .where((element) => element['month'] == currentMonth)
                      .toList();

                  if (list.isNotEmpty) {
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: ((context, index) {
                        // fetchTotalAmount(index);
                        final currentList = list[index];
                        print(currentList);
                        return FutureBuilder(
                            future:
                                fetchSpentAmount(currentList['category_id']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                final int? spentAmount = snapshot.data;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BudgetDetails(
                                                  id: currentList['id'],
                                                ))).then(
                                        (value) => setState(() {}));
                                  },
                                  child: Dismissible(
                                    background: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      child: Container(
                                        color: Colors.red,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    key: ValueKey<Map<String, dynamic>>(
                                        list[index]),
                                    onDismissed:
                                        (DismissDirection direction) async {
                                      final db = await dbHelper.database;
                                      await db.delete('budget_from_form',
                                          where: 'id = ?',
                                          whereArgs: [currentList['id']]);
                                      setState(() {
                                        print("delete");
                                      });
                                    },
                                    child: BudgetCard(
                                      spentAmount:
                                          spentAmount == null ? 0 : spentAmount,
                                      title: currentList['category_name'],
                                      color: sectionColors[index],
                                      totalAmount: currentList['budget_amount'],
                                    ),
                                  ),
                                );
                              }
                            });
                      }),
                    );
                  } else {
                    return Center(
                        child: Text("You dont have any budget for this month"));
                  }
                }
              },
            ),
          ),

          // Expanded(
          //     child: ListView.builder(
          //         itemCount: 3,
          //         itemBuilder: (context, index) {
          //           return BudgetCard();
          //         })),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateBudget()))
                  .then((value) => setState(() {}));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Container(
                height: 56,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xff95AEEE)
                      : Color(0xff7F3DFF),
                ),
                child: Center(
                    child: Text("Create a Budget",
                        style: TextStyle(
                            fontSize: Get.width * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
