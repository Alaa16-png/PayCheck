import 'package:flutter/material.dart';
import 'pay_data.dart';
import 'hours_page.dart';

class SalaryPage extends StatefulWidget {
  final PayData payData;

  const SalaryPage({
    super.key,
    required this.payData,
  });

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  String payType = 'Monthly salary';
  int workingDays = 5;

  void nextPage() {
    widget.payData.employeeName = nameController.text;
    widget.payData.amount = double.tryParse(amountController.text) ?? 0;
    widget.payData.payType = payType;
    widget.payData.daysPerWeek = workingDays;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HoursPage(payData: widget.payData),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Info'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Employee name'),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter the name',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Pay type'),
                DropdownButton<String>(
                  value: payType,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 'Monthly salary',
                      child: Text('Monthly salary'),
                    ),
                    DropdownMenuItem(
                      value: 'Hourly rate',
                      child: Text('Hourly rate'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      payType = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(payType == 'Monthly salary' ? 'Monthly salary' : 'Hourly rate'),
                TextField(
                  controller: amountController,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: 'Enter the amount',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Work schedule'),
                RadioGroup<int>(
                  groupValue: workingDays,
                  onChanged: (value) {
                    setState(() {
                      workingDays = value!;
                    });
                  },
                  child: const Column(
                    children: [
                      RadioListTile<int>(
                        title: Text('5 days a week'),
                        value: 5,
                      ),
                      RadioListTile<int>(
                        title: Text('6 days a week'),
                        value: 6,
                      ),
                    ],
                  ),
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