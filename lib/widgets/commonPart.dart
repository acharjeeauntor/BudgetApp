import 'package:budgetapp/helpers/index.dart';

class CommonPart extends StatelessWidget {
  var type;

  CommonPart(this.type);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var MQ = MediaQuery.of(context);

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
                width: MQ.orientation == Orientation.landscape
                    ? 100.0
                    : size.width * 0.25,
                height: MQ.orientation == Orientation.landscape
                    ? 100.0
                    : size.height * 0.15,
                fit: BoxFit.cover,
                image: AssetImage("assets/images/logo.png")),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "$type",
                style: TextStyle(
                    fontSize:
                        MQ.orientation == Orientation.portrait ? 20.0 : 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80.0))),
    );
  }
}
