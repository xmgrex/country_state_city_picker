library japan_state_city_picker;

import 'dart:convert';

import 'package:country_state_city_picker/src/japan_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:country_state_city_picker/src/models.dart' as status_model;

class SelectJapanState extends StatefulWidget {
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;
  final VoidCallback? onCountryTap;
  final VoidCallback? onStateTap;
  final VoidCallback? onCityTap;
  final TextStyle? style;
  final Color? dropdownColor;
  final InputDecoration decoration;
  final double spacing;

  const SelectJapanState(
      {Key? key,
      required this.onStateChanged,
      required this.onCityChanged,
      this.decoration =
          const InputDecoration(contentPadding: EdgeInsets.all(0.0)),
      this.spacing = 0.0,
      this.style,
      this.dropdownColor,
      this.onCountryTap,
      this.onStateTap,
      this.onCityTap})
      : super(key: key);

  @override
  _SelectJapanStateState createState() => _SelectJapanStateState();
}

class _SelectJapanStateState extends State<SelectJapanState> {
  List<City> _cities = [];
  late City _selectedCity;
  late JapanStataModel _selectedState;
  List<JapanStataModel> _states = [];
  var responses;

  @override
  void initState() {
    getState();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/japan_state_city.json');
    return jsonDecode(res);
  }

  Future getState() async {
    var takestate = await getResponse() as List;
    for (var f in takestate) {
      if (!mounted) continue;
      setState(() {
        const state = JapanStataModel(name: 'Choose State/Province');
        _selectedState = state;
        _states = f.map((item) => JapanStataModel.fromMap(item)).toList();
      });
    }

    return _states;
  }

  Future getCity(JapanStataModel value) async {
    var cities = value.city!;
    if (!mounted) return;
    setState(() {
      _cities = cities;
    });
    return _cities;
  }

  void _onSelectedState(JapanStataModel value) {
    if (!mounted) return;
    var city = const City(citycode: '', city: 'Choose City');
    setState(() {
      _selectedCity = city;
      _cities = [city];
      _selectedState = value;
      widget.onStateChanged(value.name!);
      getCity(value);
    });
  }

  void _onSelectedCity(City value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = value;
      widget.onCityChanged(value.city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InputDecorator(
          decoration: widget.decoration,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<JapanStataModel>(
            dropdownColor: widget.dropdownColor,
            isExpanded: true,
            items: _states.map((JapanStataModel dropDownStringItem) {
              return DropdownMenuItem<JapanStataModel>(
                value: dropDownStringItem,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        dropDownStringItem.name!,
                        style: widget.style,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => _onSelectedState(value!),
            onTap: widget.onStateTap,
            value: _selectedState,
          )),
        ),
        SizedBox(
          height: widget.spacing,
        ),
        InputDecorator(
          decoration: widget.decoration,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<City>(
            dropdownColor: widget.dropdownColor,
            isExpanded: true,
            items: _cities.map((City dropDownStringItem) {
              return DropdownMenuItem<City>(
                value: dropDownStringItem,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        dropDownStringItem.city,
                        style: widget.style,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => _onSelectedCity(value!),
            onTap: widget.onCityTap,
            value: _selectedCity,
          )),
        ),
      ],
    );
  }
}
