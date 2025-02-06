import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarGraph extends StatelessWidget {
  final Future<List<ProjectData>> fetchProjectData;

  const BarGraph({Key? key, required this.fetchProjectData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenWidth*0.5,
      child: FutureBuilder<List<ProjectData>>(
        future: fetchProjectData,
        builder: (context, snapshot) {
          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          // Data loaded state
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<ProjectData> projectData = snapshot.data!;
            return SfCartesianChart(
              primaryXAxis: const CategoryAxis(
                title: AxisTitle(
                  text: 'Projects',
                  textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              primaryYAxis: const NumericAxis(
                title: AxisTitle(
                  text: 'Completion (%)',
                  textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                minimum: 0,
                maximum: 100,
                interval: 10,
              ),
              title: const ChartTitle(
                text: 'Project Completion Status',
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                tooltipPosition: TooltipPosition.pointer,
                textStyle: const TextStyle(color: Colors.white),
                color: Colors.blueGrey.shade700,
              ),
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
                enablePinching: true,
              ),
              series: <CartesianSeries<ProjectData, String>>[
                BarSeries<ProjectData, String>(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  dataSource: projectData,
                  xValueMapper: (ProjectData data, _) =>
                  data.projectName.length > 14
                      ? '${data.projectName.substring(0, 14)}...'
                      : data.projectName,

                  yValueMapper: (ProjectData data, _) => data.completionPercentage,
                  gradient: const LinearGradient(
                    colors: [Color(0xff56CCF2), Color(0xff2F80ED)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  name: 'Completion %',
                  dataLabelSettings: const DataLabelSettings(
                    overflowMode: OverflowMode.trim,
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  animationDuration: 1500,
                ),
              ],
            );
          }

          return const Center(
            child: Text(
              'Loading Data',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          );
        },
      ),
    );
  }
}

class ProjectData {
  final String projectName;
  final double completionPercentage;

  ProjectData(this.projectName, this.completionPercentage);
}
