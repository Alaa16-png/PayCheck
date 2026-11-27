import 'package:flutter/material.dart';
import 'pay_data.dart';
import 'salary_page.dart';

class ReportPage extends StatelessWidget {
  final PayData payData;

  const ReportPage({
    super.key,
    required this.payData,
  });

  // One line of the report: a label on the left and a value on the right
  Widget reportRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Salary Report'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payData.employeeName.isEmpty
                      ? 'Employee'
                      : payData.employeeName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                reportRow('Basic salary', payData.basicPay.toStringAsFixed(2)),
                reportRow('Overtime', payData.overtimePay.toStringAsFixed(2)),
                reportRow('Bonuses', payData.bonuses.toStringAsFixed(2)),
                const Divider(),
                reportRow(
                  'Gross salary',
                  payData.grossSalary.toStringAsFixed(2),
                  bold: true,
                ),
                reportRow(
                  'Deductions',
                  '-${payData.totalDeductions.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE9D9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF08A4B)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Net salary'),
                      Text(
                        payData.netSalary.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC4521A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      payData.reset();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SalaryPage(payData: payData),
                        ),
                            (route) => false,
                      );
                    },
                    child: const Text('NEW CALCULATION'),
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