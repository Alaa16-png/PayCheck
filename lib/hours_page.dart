import 'package:flutter/material.dart';
import 'pay_data.dart';
import 'deductions_page.dart';

class HoursPage extends StatefulWidget {
  final PayData payData;

  const HoursPage({
    super.key,
    required this.payData,
  });

  @override
  State<HoursPage> createState() => _HoursPageState();
}

class _HoursPageState extends State<HoursPage> {
  final overtimeController = TextEditingController();
  final hoursController = TextEditingController();

  double overtimeRate = 1.5;

  void nextPage() {
    widget.payData.overtimeHours =
        double.tryParse(overtimeController.text) ?? 0;

    widget.payData.overtimeRate = overtimeRate;

    if (widget.payData.payType == 'Hourly rate') {
      widget.payData.hoursWorked =
          double.tryParse(hoursController.text) ?? 0;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeductionsPage(payData: widget.payData),
      ),
    );
  }

  @override
  void dispose() {
    overtimeController.dispose();
    hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hours & Overtime'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.payData.payType == 'Hourly rate') ...[
                  const Text('Hours worked'),
                  TextField(
                    controller: hoursController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      hintText: 'Enter hours worked',
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                const Text('Overtime hours (this month)'),
                TextField(
                  controller: overtimeController,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: 'Enter overtime hours',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Overtime rate'),
                DropdownButton<double>(
                  value: overtimeRate,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 1.25, child: Text('x1.25')),
                    DropdownMenuItem(value: 1.5, child: Text('x1.5')),
                    DropdownMenuItem(value: 2.0, child: Text('x2')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      overtimeRate = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Standard month: '
                      '${widget.payData.monthlyHours.toStringAsFixed(0)} hours',
                ),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: nextPage,
                    child: const Text('NEXT'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}