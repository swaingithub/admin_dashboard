import 'package:fluxy/fluxy.dart';

class Invoice {
  final String id;
  final String status;
  final String method;
  final double amount;
  final DateTime date;

  Invoice({
    required this.id,
    required this.status,
    required this.method,
    required this.amount,
    required this.date,
  });

  Invoice copyWith({
    String? id,
    String? status,
    String? method,
    double? amount,
    DateTime? date,
  }) {
    return Invoice(
      id: id ?? this.id,
      status: status ?? this.status,
      method: method ?? this.method,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}

class InvoiceController {
  final invoices = fluxList<Invoice>([
    Invoice(id: 'INV-2031', status: 'Paid', method: 'Credit Card', amount: 250.00, date: DateTime.now()),
    Invoice(id: 'INV-2032', status: 'Pending', method: 'PayPal', amount: 150.00, date: DateTime.now()),
    Invoice(id: 'INV-2033', status: 'Unpaid', method: 'Bank Transfer', amount: 350.00, date: DateTime.now()),
    Invoice(id: 'INV-2034', status: 'Processing', method: 'Credit Card', amount: 450.00, date: DateTime.now()),
    Invoice(id: 'INV-2035', status: 'Paid', method: 'PayPal', amount: 550.00, date: DateTime.now()),
  ]);

  void addInvoice(Invoice invoice) {
    invoices.add(invoice);
  }

  void deleteInvoice(String id) {
    invoices.removeWhere((i) => i.id == id);
  }

  void updateStatus(String id, String newStatus) {
    final index = invoices.indexWhere((i) => i.id == id);
    if (index != -1) {
      invoices[index] = invoices[index].copyWith(status: newStatus);
    }
  }
}
