import 'package:flutter/material.dart';
import 'chart_bars.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

// ignore_for_file: prefer_const_constructors

class Chart extends StatelessWidget {
  //const Chart({Key key}) : super(key: key);

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  //getters are these properties which are calculated dynamically
  List<Map<String, Object>> get groupedTransactionsValues {

    return List.generate(7, (index) {

      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i=0; i< recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day && 
            recentTransactions[i].date.month == weekDay.month && 
            recentTransactions[i].date.year == weekDay.year) 
            {
              totalSum += recentTransactions[i].amount;
            } 
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {'day' : DateFormat.E().format(weekDay).substring(0, 1), 'amount' : totalSum};
    }).reversed.toList();
  }

  double get totalSpending {

    return groupedTransactionsValues.fold(0.0, (sum, item) {

      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {

    print(groupedTransactionsValues);
    
    return Card(
      elevation: 6, margin: EdgeInsets.all(20), 
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {

          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'], 
              data['amount'], 
              totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending
            ),
          );
        }).toList(),),
      ),
    );
  }
}