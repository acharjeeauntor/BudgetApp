import 'package:budgetapp/helpers/index.dart';
import 'package:budgetapp/providers/appData.dart';

class DashBoardInputShow extends StatefulWidget {
  @override
  _DashBoardInputShowState createState() => _DashBoardInputShowState();
}

class _DashBoardInputShowState extends State<DashBoardInputShow> {
  @override
  Widget build(BuildContext context) {
    final _descController = TextEditingController();
    final _amountController = TextEditingController();
    var _type = 0;

    final userProvider = Provider.of<User>(context, listen: false);
    final appDataProvider = Provider.of<AppData>(context, listen: false);

    void handleSubmit() async {
      FocusScope.of(context).unfocus();
      if (_descController.text.isEmpty || _amountController.text.isEmpty) {
        return Toast.show("Description and Amount is Required", context,
            textColor: Colors.white,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
            backgroundColor: const Color(0xffEC7063));
      } else {
        if (_type == 0) {
          // post request
          //print("handle called");
          //print(_descController.text);
          await appDataProvider
              .addIncome(
                  desc: _descController.text,
                  amount: _amountController.text,
                  token: userProvider.authToken)
              .then((res) {
            if (res == 'success') {
              appDataProvider.addInc(_amountController.text);
              setState(() {
                _descController.clear();
                _amountController.clear();
              });
            } else {
              Toast.show(res, context,
                  textColor: Colors.white,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.TOP,
                  backgroundColor: const Color(0xffEC7063));
            }
          });
        } else if (_type == 1) {
          // post request
          await appDataProvider
              .addExpenses(
                  desc: _descController.text,
                  amount: _amountController.text,
                  token: userProvider.authToken)
              .then((res) {
            if (res == 'success') {
              appDataProvider.addExp(_amountController.text);
              setState(() {
                _descController.clear();
                _amountController.clear();
              });
            } else {
              Toast.show(res, context,
                  textColor: Colors.white,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.TOP,
                  backgroundColor: const Color(0xffEC7063));
            }
          });
        }
      }
    }

    return Card(
      elevation: 12.0,
      shadowColor: Colors.black,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      prefixIcon: Icon(Icons.description)),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Amount',
                      prefixIcon: Icon(Icons.monetization_on)),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToggleSwitch(
                    minWidth: 100.0,
                    fontSize: 15,
                    activeBgColor: Colors.cyan,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    labels: ['Income', 'Expense'],
                    icons: [Icons.add, Icons.remove],
                    onToggle: (index) {
                      //print('switched to: $index');
                      setState(() {
                        _type = index;
                      });
                    },
                  ),
                  IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.arrow_forward),
                      color: Colors.cyan,
                      onPressed: handleSubmit)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
