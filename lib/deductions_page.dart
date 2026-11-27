import 'package:flutter/material.dart';
import 'pay_data.dart';
import 'report_page.dart';

class DeductionsPage extends StatefulWidget {
  final PayData payData;

  const DeductionsPage({
    super.key,
    required this.payData,
  });

  @override
  State<DeductionsPage> createState() => _DeductionsPageState();
}

class _DeductionsPageState extends State<DeductionsPage> {
  bool socialSecurity = false;
  bool healthInsurance = false;

  bool hasTransport = false;
  bool hasPerformanceBonus = false;

  double incomeTaxRate = 0;

  void calculate() {
    // Save values
    widget.payData.socialSecurity = socialSecurity;
    widget.payData.healthInsurance = healthInsurance;
    widget.payData.incomeTaxRate = incomeTaxRate;
    widget.payData.hasTransport = hasTransport;
    widget.payData.hasPerformanceBonus = hasPerformanceBonus;

    // Navigate to the report page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPage(payData: widget.payData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deductions & Bonuses'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Deductions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  title: const Text('Social security (7.5%)'),
                  value: socialSecurity,
                  onChanged: (value) {
                    setState(() {
                      socialSecurity = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Health insurance (3%)'),
                  value: healthInsurance,
                  onChanged: (value) {
                    setState(() {
                      healthInsurance = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Income tax',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                RadioGroup<double>(
                  groupValue: incomeTaxRate,
                  onChanged: (value) {
                    setState(() {
                      incomeTaxRate = value!;
                    });
                  },
                  child: const Column(
                    children: [
                      RadioListTile<double>(title: Text('None'), value: 0),
                      RadioListTile<double>(title: Text('5%'), value: 0.05),
                      RadioListTile<double>(title: Text('10%'), value: 0.10),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bonuses',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  title: const Text('Transport allowance (50)'),
                  value: hasTransport,
                  onChanged: (value) {
                    setState(() {
                      hasTransport = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Performance bonus (10%)'),
                  value: hasPerformanceBonus,
                  onChanged: (value) {
                    setState(() {
                      hasPerformanceBonus = value!;
                    });
                  },
                ),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: calculate,
                    child: const Text('CALCULATE'),
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