import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'login_label': 'Login',
          'username_label': 'Username',
          'pin_label': 'Pin',
          'forgot_pin_label': 'Forgot Pin?',
          'name_label': 'Name',
          'welcome_label': 'Your name is @name',
        },
        'de_DE': {
          'hello': 'Hallo Welt',
          'login_label': 'Logen',
          'username_label': 'Username',
          'pin_label': 'Pin',
          'forgot_pin_label': 'Forgeto Pino?',
          'name_label': 'Nameu',
          'welcome_label': 'Your namelo is @name'
        },
      };
}
