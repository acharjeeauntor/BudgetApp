import 'package:budgetapp/helpers/index.dart';

class BouncyPageRoute extends PageRouteBuilder {
  final Widget widget;
  Curve crv;

  BouncyPageRoute({this.widget, this.crv})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(parent: animation, curve: crv);

              return ScaleTransition(
                  alignment: Alignment.center, scale: animation, child: child);
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
