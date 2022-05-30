import 'package:country_state_city_picker/japan_state_city_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('', (widgetTester) async {
    await widgetTester.pumpWidget(SelectJapanState(
      onStateChanged: (v) {},
      onCityChanged: (v) {},
    ));
  });
}
