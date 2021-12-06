import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'login_label': 'Login',
          'username_label': 'Username',
          'pin_label': 'Pin',
          'forgot_pin_label': 'Forgot Pin?'
        },
        'de_DE': {
          'hello': 'Hallo Welt',
          'login_label': 'Logen',
          'username_label': 'Username',
          'pin_label': 'Pin',
          'forgot_pin_label': 'Forgeto Pino?'
        },
      };
}
