import 'package:budgetapp/helpers/index.dart';
import 'package:budgetapp/providers/income.dart';
import 'package:http/http.dart' as http;

class AppData with ChangeNotifier {
  int _totalInc = 0;
  int _totalExp = 0;

  List<Income> _incList = [];
  List<Income> _expList = [];

  // Add Income
  addInc(String value) {
    _totalInc = _totalInc + int.parse(value);

    notifyListeners();
  }

  // Add Expenses
  addExp(String value) {
    _totalExp = _totalExp + int.parse(value);
    //print("$value");
    notifyListeners();
  }

//Remove total inc,exp,explist,inclist
  void removeAll() {
    this._totalInc = 0;
    this._totalExp = 0;
    this._incList = [];
    this._expList = [];
  }

  //get total income and expenses
  int get totalIncome => _totalInc;
  int get totalExpenses => _totalExp;

  //get income and expenses list
  List<Income> get incList {
    return [..._incList.reversed];
  }

  List<Income> get expList {
    return [..._expList.reversed];
  }

//Fetch all Data
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

//Add Income
  Future<String> addIncome({String desc, String amount, String token}) async {
    //print("desc:$desc");
    //print("amount:$amount");
    final url = 'http://10.0.2.2:5000/budget/income';
    try {
      final response = await http.post(url,
          headers: {"Authorization": "$token"},
          body: {"desc": desc, "amount": amount});
      var responseData = json.decode(response.body);
      //print(responseData);
      // print("addncome called");
      if (response.statusCode == 200) {
        //notify income list widget
        _incList.add(Income.fromJson(responseData));
        notifyListeners();
        return 'success';
      } else if (response.statusCode == 400) {
        return "Server Error";
      }
    } catch (error) {
      // print("error called");
      throw error;
    }
  }

//Add Expenses
  Future<String> addExpenses({String desc, String amount, String token}) async {
    //print("desc:$desc");
    // print("amount:$amount");
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
        return 'success';
      } else if (response.statusCode == 400) {
        return "Server Error";
      }
    } catch (error) {
      //print("error called");
      throw error;
    }
  }

  //Delete Expenses
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
      //print("error called");
      throw error;
    }
  }

  //Delete Income
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
      // print("error called");
      throw error;
    }
  }
}
