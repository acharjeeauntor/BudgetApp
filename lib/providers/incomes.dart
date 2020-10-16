import 'dart:convert';

import 'package:budgetapp/providers/income.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Incomes with ChangeNotifier {
  var _totalInc = '';
  var _totalExp = '';

  List<Income> _incList = [];
  List<Income> _expList = [];

  set addInc(value) {
    _totalInc = value;
    print("$value");
    notifyListeners();
  }

  set addExp(value) {
    _totalExp = value;
    print("$value");
    notifyListeners();
  }

  List<Income> get incList {
    return [..._incList];
  }

  List<Income> get expList {
    return [..._expList];
  }

  Future<void> fetchAndSetAll({String token}) async {
    try {
      //Inc
      final response = await http.get(
          "http://10.0.2.2:5000/budget/income/getincomelist",
          headers: {"Authorization": "$token"});

      var rawData = json.decode(response.body);
      for (var inc in rawData) {
        _incList.add(Income.fromJson(inc));
        notifyListeners();
      }

      //Exp

      final responseExp = await http.get(
          "http://10.0.2.2:5000/budget/exp/getexplist",
          headers: {"Authorization": "$token"});

      var expData = json.decode(responseExp.body);
      for (var exp in expData) {
        _expList.add(Income.fromJson(exp));
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }
}
