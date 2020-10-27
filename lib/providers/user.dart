import 'package:budgetapp/helpers/index.dart';

class User with ChangeNotifier {
  String _token = '';

  set addToken(newToken) {
    _token = newToken;
    print("Token$newToken");
    notifyListeners();
  }

  set removeToken(newToken) {
    _token = '';
    notifyListeners();
  }

  String get authToken => _token;
  String get userId {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(_token);
    //print("Decoded Token $decodedToken");
    return decodedToken['sub'];
  }
}
