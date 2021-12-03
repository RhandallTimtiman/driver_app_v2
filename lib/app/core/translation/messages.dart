import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'login': 'Login',
        },
        'de_DE': {
          'hello': 'Hallo Welt',
          'login': 'Logen',
        },
      };
}
