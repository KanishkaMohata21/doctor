import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class AssessmentHistoryPage extends StatefulWidget {
  @override
  _AssessmentHistoryPageState createState() => _AssessmentHistoryPageState();
}

class _AssessmentHistoryPageState extends State<AssessmentHistoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey _graph1Key = GlobalKey();
  final GlobalKey _graph2Key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final tableImage = await _captureWidgetAsImage(_graph1Key);
      final graphImage = await _captureWidgetAsImage(_graph2Key);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Assessment History", style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),

              // Dummy data for the PDF
              pw.Text("User: John Doe", style: const pw.TextStyle(fontSize: 18)),
              pw.Text("Assessment: Hand Strength Test", style: const pw.TextStyle(fontSize: 18)),
              pw.Text("Time: 14:30", style: const pw.TextStyle(fontSize: 18)),
              pw.Text("Date: 2024-09-24", style: const pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 20),

              pw.Text("Right Hand Table", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Table.fromTextArray(
                headers: ["ID", "Trial 1 (Kg)", "Trial 2 (Kg)"],
                data: [
                  ["58", "1.497", "5.401"],
                ],
              ),
              pw.SizedBox(height: 20),

              pw.Text("Left Hand Table", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Table.fromTextArray(
                headers: ["ID", "Trial 1 (Kg)", "Trial 2 (Kg)"],
                data: [
                  ["60", "3.230", "2.337"],
                  ["56", "1.670", "1.646"],
                ],
              ),
              pw.SizedBox(height: 20),

              pw.Text("Latest Test", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Table.fromTextArray(
                headers: ["RH", "LH", "Difference"],
                data: [
                  ["3.93", "2.38", "-1.55"],
                ],
              ),
              pw.SizedBox(height: 20),

              pw.Text("Right Hand Graph", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              if (tableImage != null) pw.Image(pw.MemoryImage(tableImage), width: double.infinity, height: 100),

              pw.SizedBox(height: 20),

              pw.Text("Left Hand Graph", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              if (graphImage != null) pw.Image(pw.MemoryImage(graphImage), width: double.infinity, height: 100),
            ],
          ),
        ),
      );
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    });
  }

  Future<Uint8List?> _captureWidgetAsImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print("Error capturing image: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assessment History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _generatePdf,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Table"),
            Tab(text: "Graph"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Table View
          tableView(),
          // Graph View
          graphView(),
        ],
      ),
    );
  }

  Widget tableView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Right Hand Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DataTable(
            columns: const [
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Trial 1 (Kg)")),
              DataColumn(label: Text("Trial 2 (Kg)")),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("58")),
                DataCell(Text("1.497")),
                DataCell(Text("5.401")),
              ]),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Left Hand Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DataTable(
            columns: const [
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Trial 1 (Kg)")),
              DataColumn(label: Text("Trial 2 (Kg)")),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("60")),
                DataCell(Text("3.230")),
                DataCell(Text("2.337")),
              ]),
              DataRow(cells: [
                DataCell(Text("56")),
                DataCell(Text("1.670")),
                DataCell(Text("1.646")),
              ]),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Latest Test", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DataTable(
            columns: const [
              DataColumn(label: Text("RH")),
              DataColumn(label: Text("LH")),
              DataColumn(label: Text("Difference")),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("3.93")),
                DataCell(Text("2.38")),
                DataCell(Text("-1.55")),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget graphView() {
    return KeepAliveWidget(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Right Hand Graph", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RepaintBoundary(
              key: _graph1Key,
              child: SizedBox(
                height: 200,
                child: LineChart(LineChartData(
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.red,
                      spots: [
                        const FlSpot(1, 3.0),
                        const FlSpot(2, 3.5),
                        const FlSpot(3, 3.9),
                      ],
                      dotData: const FlDotData(show: true),
                    )
                  ],
                )),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Latest Test Graph", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RepaintBoundary(
              key: _graph2Key,
              child: SizedBox(
                height: 200,
                child: BarChart(BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 5, color: Colors.green),
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 4, color: Colors.green),
                    ]),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KeepAliveWidget extends StatefulWidget {
  final Widget child;

  const KeepAliveWidget({required this.child});

  @override
  _KeepAliveWidgetState createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}