// Copyright (c) 2024, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:isolate/isolates/isolate_helper.dart';

import '../components/clock.dart';
import '../components/sensor_box.dart';
import '../components/sensor_image_box.dart';
import '../constants.dart';
import 'dashboard_abstract.dart';

class DashboardBME680 extends Dashboard {
  const DashboardBME680({super.key, required super.isolateWrapper});

  @override
  Map<int, Widget> buildUI(TaskResult result) {
    var values = result.data!;
    var temperature = values['t']! as double;
    var pressure = values['p']! as double;
    var humidity = values['h']! as double;
    var iaq = values['a']! as int;
    var counter = values['c'] as int;

    var widgetMap = <int, Widget>{};

    widgetMap[0] = Thermometer(
        key: const ValueKey("0"), imageVersion: 5, temperature: temperature);
    widgetMap[1] = Barometer(
        key: const ValueKey("1"), imageVersion: 1, pressure: pressure);
    widgetMap[2] = Hygrometer(
        key: const ValueKey("2"), imageVersion: 5, humidity: humidity);
    widgetMap[3] = IAQ(key: const ValueKey("3"), imageVersion: 2, iaq: iaq);
    widgetMap[4] = SensorImageBox(
      key: const ValueKey("4"),
      sensor: "Sensor: BME680",
      interface: "I2C Bus: ${gI2C.toString()}",
      icon: 'sensor_v1.png',
      counter: counter,
    );
    widgetMap[5] = const Clock(key: ValueKey("5"));
    return widgetMap;
  }
}
