class PayData {
  // Example rates (simple numbers chosen by me)
  static const double socialSecurityRate = 0.075;
  static const double healthInsuranceRate = 0.03;
  static const double transportAllowance = 50;
  static const double performanceBonusRate = 0.10;

  // Screen 1: salary info
  String employeeName;
  String payType; // 'Monthly salary' or 'Hourly rate'
  double amount; // monthly salary or hourly rate
  int daysPerWeek; // 5 or 6
  double hoursPerDay;

  // Screen 2: hours and overtime
  double hoursWorked; // used only for hourly pay
  double overtimeHours;
  double overtimeRate; // 1.25, 1.5 or 2

  // Screen 3: deductions and bonuses
  bool socialSecurity;
  bool healthInsurance;
  double incomeTaxRate; // 0, 0.05 or 0.10
  bool hasTransport;
  bool hasPerformanceBonus;

  PayData({
    this.employeeName = '',
    this.payType = 'Monthly salary',
    this.amount = 0,
    this.daysPerWeek = 5,
    this.hoursPerDay = 8,
    this.hoursWorked = 0,
    this.overtimeHours = 0,
    this.overtimeRate = 1.5,
    this.socialSecurity = false,
    this.healthInsurance = false,
    this.incomeTaxRate = 0,
    this.hasTransport = false,
    this.hasPerformanceBonus = false,
  });

  // Standard hours in one month (22 days or 26 days)
  double get monthlyHours {
    int days = daysPerWeek == 5 ? 22 : 26;
    return days * hoursPerDay;
  }

  double get hourlyRate {
    if (payType == 'Hourly rate') return amount;
    if (monthlyHours <= 0) return 0;
    return amount / monthlyHours;
  }

  double get basicPay {
    if (payType == 'Hourly rate') return amount * hoursWorked;
    return amount;
  }

  double get overtimePay => overtimeHours * hourlyRate * overtimeRate;

  double get bonuses {
    double total = 0;
    if (hasTransport) total += transportAllowance;
    if (hasPerformanceBonus) total += basicPay * performanceBonusRate;
    return total;
  }

  double get grossSalary => basicPay + overtimePay + bonuses;

  double get totalDeductions {
    double rate = incomeTaxRate;
    if (socialSecurity) rate += socialSecurityRate;
    if (healthInsurance) rate += healthInsuranceRate;
    return grossSalary * rate;
  }

  double get netSalary => grossSalary - totalDeductions;

  // Start a new calculation
  void reset() {
    employeeName = '';
    payType = 'Monthly salary';
    amount = 0;
    daysPerWeek = 5;
    hoursPerDay = 8;
    hoursWorked = 0;
    overtimeHours = 0;
    overtimeRate = 1.5;
    socialSecurity = false;
    healthInsurance = false;
    incomeTaxRate = 0;
    hasTransport = false;
    hasPerformanceBonus = false;
  }
}

// One shared object, every screen reads and writes this
final PayData payData = PayData();