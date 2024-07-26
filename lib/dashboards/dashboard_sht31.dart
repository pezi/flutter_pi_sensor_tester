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

class DashboardSHT31 extends Dashboard {
  const DashboardSHT31({super.key, required super.isolateWrapper});

  @override
  Map<int, Widget> buildUI(TaskResult result) {
    var values = result.data!;
    var temperature = values['t']! as double;
    var humidity = values['h']! as double;
    var counter = values['c'] as int;

    var widgetMap = <int, Widget>{};

    widgetMap[0] = Thermometer(
        key: const ValueKey("0"), imageVersion: 5, temperature: temperature);
    widgetMap[1] = Hygrometer(
        key: const ValueKey("1"), imageVersion: 5, humidity: humidity);
    widgetMap[2] = SensorImageBox(
      key: const ValueKey("2"),
      sensor: "Sensor: SHT31",
      interface: "I2C Bus: ${gI2C.toString()}",
      icon: 'thermometer_v4.png',
      counter: counter,
    );
    widgetMap[3] = const Clock(key: ValueKey("3"));
    return widgetMap;
  }
}