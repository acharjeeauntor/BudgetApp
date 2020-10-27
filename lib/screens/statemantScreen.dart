import 'package:budgetapp/helpers/index.dart';

class StatementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: const Text(
        "No Statement found",
        style: TextStyle(
            color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 20),
      )),
    );
  }
}
