import 'package:flutter/material.dart';
import 'package:my_desktop_app/deepseek/dashborad.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartWidget extends StatelessWidget {
  final Color primaryColor;
  const PieChartWidget({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Job Distribution',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: SfCircularChart(
            palette: [
              // primaryColor,
              // primaryColor.withValues(alpha: 0.7),
              // primaryColor.withValues(alpha: 0.5),
              // primaryColor.withValues(alpha: 0.3),
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.deepOrange,
              
            ],
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: [
                  ChartData('Completed', 23),
                  ChartData('Pending', 27),
                  ChartData('Reject', 27),
                  ChartData('Absent', 23),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelSettings: const DataLabelSettings (
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                ),
                explode: true,
                explodeIndex: 0,
                explodeOffset: '15%',
              ),
            ],
          ),
        ),
      ],
    );
  }
}