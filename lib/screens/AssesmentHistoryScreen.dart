import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class AssessmentHistoryPage extends StatefulWidget {
  @override
  _AssessmentHistoryPageState createState() => _AssessmentHistoryPageState();
}

class _AssessmentHistoryPageState extends State<AssessmentHistoryPage>
    with SingleTickerProviderStateMixin {
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

    // Define your custom blue color
    final customBlue = PdfColor.fromInt(0xFFBCD5DF);

    // Load the logo image
    final logoImage = await imageFromAssetBundle('assets/images/logo.jpeg');

    // Use a delay to ensure widgets are fully rendered
    await Future.delayed(Duration(milliseconds: 500));

    // Capture the widget images
    final tableImage = await _captureWidgetAsImage(_graph1Key);
    final graphImage = await _captureWidgetAsImage(_graph2Key);

    // Check if the images are null and handle it gracefully
    if (tableImage == null || graphImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing graphs. Please try again.')),
      );
      return; // Exit if images cannot be captured
    }

    // First page - All the tables
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
// Logo and Title Section
            if (logoImage != null)
              pw.Center(
                child: pw.Image(
                  pw.MemoryImage(logoImage),
                  width: 80,
                  height: 80,
                ),
              ), // Insert logo here
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Text(
                "VITAL STEP",
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center, // Center text
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Text(
                "ASSESSMENT HISTORY",
                style:
                    pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center, // Center text
              ),
            ),
            pw.SizedBox(height: 20),

            // Rest of the content (tables, graphs, etc.)
            pw.TableHelper.fromTextArray(
              headers: ["Patient's Detail", ""],
              data: [
                ["Patient's Name", "John Doe"],
                ["Assessment", "Hand Strength Test"],
                ["Date", "2024-09-24"],
                ["Time", "14:30"],
              ],
            ),

                        pw.SizedBox(height: 20),
            // Right Hand Table
            pw.Text("1. Right hand Table",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.TableHelper.fromTextArray(
              headers: [
                "ID",
                "Date",
                "Trial 1 (Kg)",
                "Trial 2 (Kg)",
                "Trial 3 (Kg)",
                "Average"
              ],
              data: [
                ["58", "2024-09-23", "1.497", "5.401", "-", "3.449"],
              ],
              headerDecoration: pw.BoxDecoration(
                color: customBlue, // Custom blue background for header
              ),
              border: pw.TableBorder.all(width: 1, color: PdfColors.black),
            ),
            pw.SizedBox(height: 20),

            // Left Hand Table
            pw.Text("2. Left hand Table",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.TableHelper.fromTextArray(
              headers: [
                "ID",
                "Date",
                "Trial 1 (Kg)",
                "Trial 2 (Kg)",
                "Trial 3 (Kg)",
                "Average"
              ],
              data: [
                ["60", "2024-09-23", "3.230", "2.337", "-", "2.784"],
                ["56", "2024-09-23", "1.670", "1.646", "-", "1.658"],
              ],
              headerDecoration: pw.BoxDecoration(
                color: customBlue, // Custom blue background for header
              ),
              border: pw.TableBorder.all(width: 1, color: PdfColors.black),
            ),
            pw.SizedBox(height: 20),

            // Latest Test Difference Table
            pw.Text("3. Latest Test Difference",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.TableHelper.fromTextArray(
              headers: ["Right Hand", "Left Hand", "Difference"],
              data: [
                ["3.93", "2.38", "-1.55"],
              ],
              headerDecoration: pw.BoxDecoration(
                color: customBlue, // Custom blue background for header
              ),
              border: pw.TableBorder.all(width: 1, color: PdfColors.black),
            ),
            pw.SizedBox(height: 20),
          ],
        ),
      ),
    );

    // Second page - All the graphs
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("4. Graph",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Image(pw.MemoryImage(tableImage),
                width: double.infinity, height: 200),
            pw.SizedBox(height: 20),
            pw.Text("5. Latest Test Graph",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Image(pw.MemoryImage(graphImage),
                width: double.infinity, height: 200),
          ],
        ),
      ),
    );

    // Generate the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Future<Uint8List> imageFromAssetBundle(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List?> _captureWidgetAsImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
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
          const Text("Right Hand Table",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          const Text("Left Hand Table",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          const Text("Latest Test",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            const Text("Right Hand Graph",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            const Text("Latest Test Graph",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
