import 'dart:convert';

import 'package:budgetapp/providers/income.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Incomes with ChangeNotifier {
  int _totalInc = 0;
  int _totalExp = 0;

  List<Income> _incList = [];
  List<Income> _expList = [];

  addInc(String value) {
    _totalInc = _totalInc + int.parse(value);

    notifyListeners();
  }

  addExp(String value) {
    _totalExp = _totalExp + int.parse(value);
    print("$value");
    notifyListeners();
  }

  int get totalIncome => _totalInc;
  int get totalExpenses => _totalExp;

  List<Income> get incList {
    return [..._incList.reversed];
  }

  List<Income> get expList {
    return [..._expList.reversed];
  }

  Future<void> fetchAndSetAll({String token}) async {
    try {
      //Inc
      final response = await http.get(
          "http://10.0.2.2:5000/budget/income/getincomelist",
          headers: {"Authorization": "$token"});

      var rawData = json.decode(response.body);

      if (rawData == null) {
        return;
      }

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

      // Total inc

      final responseTotalInc = await http.get(
          "http://10.0.2.2:5000/budget/income/gettotalincome",
          headers: {"Authorization": "$token"});

      var totalIncData = json.decode(responseTotalInc.body);
      this.addInc(totalIncData['income'].toString());

      notifyListeners();

      // Total Exp

      final responseTotalExp = await http.get(
          "http://10.0.2.2:5000/budget/exp/gettotalexp",
          headers: {"Authorization": "$token"});

      var totalExpData = json.decode(responseTotalExp.body);
      this.addExp(totalExpData['exp'].toString());

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<String> addIncome({String desc, String amount, String token}) async {
    print("desc:$desc");
    print("amount:$amount");
    final url = 'http://10.0.2.2:5000/budget/income';
    try {
      final response = await http.post(url,
          headers: {"Authorization": "$token"},
          body: {"desc": desc, "amount": amount});
      var responseData = json.decode(response.body);
      print(responseData);
      print("addncome called");
      if (response.statusCode == 200) {
        //notify income list widget
        _incList.add(Income.fromJson(responseData));
        notifyListeners();
      } else if (response.statusCode == 400) {
        return "Description and Amount is required";
      }
    } catch (error) {
      print("error called");
      throw error;
    }
  }

  Future<String> addExpenses({String desc, String amount, String token}) async {
    print("desc:$desc");
    print("amount:$amount");
    final url = 'http://10.0.2.2:5000/budget/exp';
    try {
      final response = await http.post(url,
          headers: {"Authorization": "$token"},
          body: {"desc": desc, "amount": amount});
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        //notify income list widget
        _expList.add(Income.fromJson(responseData));
        notifyListeners();
      } else if (response.statusCode == 400) {
        return "Description and Amount is required";
      }
    } catch (error) {
      print("error called");
      throw error;
    }
  }

  Future<void> deleteExpenses({String id, String token}) async {
    final url = 'http://10.0.2.2:5000/budget/exp/deleteexp/$id';
    try {
      final response =
          await http.delete(url, headers: {"Authorization": "$token"});
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        //notify income list widget
        //_expList.add(Income.fromJson(responseData));
        _expList.removeWhere((element) => element.id == responseData['_id']);

        _totalExp = _totalExp - responseData['amount'];
        notifyListeners();
      }
    } catch (error) {
      print("error called");
      throw error;
    }
  }

  Future<void> deleteIncome({String id, String token}) async {
    final url = 'http://10.0.2.2:5000/budget/income/deleteincome/$id';
    try {
      final response =
          await http.delete(url, headers: {"Authorization": "$token"});
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        //notify income list widget
        //_expList.add(Income.fromJson(responseData));
        _incList.removeWhere((element) => element.id == responseData['_id']);
        _totalInc = _totalInc - responseData['amount'];
        notifyListeners();
      }
    } catch (error) {
      print("error called");
      throw error;
    }
  }
}
