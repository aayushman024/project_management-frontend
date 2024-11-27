// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarGraph extends StatefulWidget {
  const BarGraph({super.key});

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {

  // Data for projects
  final List<ProjectData> projectData = [
    ProjectData('TS Hot Issues Dashboard', 70),
    ProjectData('sTSI v2.0', 50),
    ProjectData('NMS Care', 90),
    ProjectData('NI CareAssist', 30),
    ProjectData('TS Bot', 80),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: 'Projects'),
              maximumLabelWidth: 100,
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Completion (%)'),
          maximum: 100,
        ),
        title: ChartTitle(text: 'Project Completion Status'),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<ProjectData, String>>[
          ColumnSeries<ProjectData, String>(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            dataSource: projectData,
            xValueMapper: (ProjectData data, _) => data.projectName,
            yValueMapper: (ProjectData data, _) => data.completionPercentage,
            color: Colors.blue,
            animationDuration: 2,
            name: 'Completion %',
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside
            ),
          ),
        ],
      );
  }
}

class ProjectData {
  ProjectData(this.projectName, this.completionPercentage);
  final String projectName;
  final double completionPercentage;
}
