import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

class ChartBar extends StatelessWidget {
  //const ChartBar({Key key}) : super(key: key);

  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget> [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'),),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.6, width: 10,
            child: Stack(children: <Widget> [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 200, 1), 
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentageOfTotal, 
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor, 
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label)),
          ),
        ],
      );
    },); 
  }
}