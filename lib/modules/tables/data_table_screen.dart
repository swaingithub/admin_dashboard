import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../core/invoices/invoice_controller.dart';
import '../../core/theme/fx_colors.dart';

class DataTableScreen extends StatelessWidget {
  const DataTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Standard Fluxy Pattern: Put the controller if not already present
    Fluxy.lazyPut(() => InvoiceController());
    final controller = Fluxy.find<InvoiceController>();
    
    final breakpoint = ResponsiveEngine.of(context);
    final isMobile = breakpoint.index <= Breakpoint.sm.index;

    return Fx.scroll(
      child: Fx.box(
        child: Fx.col(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Fx.row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Fx.col(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Fx.text('Invoices')
                      .fontSize(isMobile ? 24 : 28)
                      .bold()
                      .color(FxColors.textHeading)
                      .animate(fade: 0.0, slide: const Offset(-20, 0)),
                    Fx.box().h(8),
                    Fx.text(isMobile ? 'Manage transactions.' : 'Manage your transactions and monitor payment statuses.')
                      .color(Colors.grey)
                      .fontSize(isMobile ? 14 : 16),
                  ],
                ),
                Fx.button(isMobile ? 'Add' : 'Add Invoice', onTap: () {
                  final newId = 'INV-${2030 + controller.invoices.length}';
                  controller.addInvoice(Invoice(
                    id: newId,
                    status: 'Pending',
                    method: 'Manual Entry',
                    amount: 0.00,
                    date: DateTime.now(),
                  ));
                  Fx.toast(context, 'New Invoice Created: $newId');
                }).rounded.shadowMedium(),
              ],
            ),
            
            Fx.box().h(32),
            
            // Stats Row (Vertical on mobile)
            if (isMobile)
              Fx.col(
                gap: 16,
                children: _buildStatsWidgets(controller),
              )
            else
              Fx.row(
                gap: 20,
                children: Fx.stagger(_buildStatsWidgets(controller)),
              ),

            Fx.box().h(32),
            
            // Table Container
            Fx.box(
              child: Fx(() {
                final list = controller.invoices;
                final table = DataTable(
                  headingRowHeight: 70,
                  dataRowMinHeight: 70,
                  dataRowMaxHeight: 70,
                  horizontalMargin: 24,
                  columnSpacing: isMobile ? 12 : 24,
                  headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: FxColors.textHeading, fontSize: 13),
                  columns: [
                    DataColumn(label: Text('Invoice')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Method')),
                    if (isMobile == false) DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: list.map((invoice) {
                    return DataRow(cells: [
                      DataCell(Fx.text(invoice.id).semiBold().color(FxColors.primary).fontSize(isMobile ? 12 : 14)),
                      DataCell(_buildStatusButton(context, controller, invoice, isMobile)),
                      DataCell(Fx.text(invoice.method).color(FxColors.textBody).fontSize(isMobile ? 12 : 14)),
                      if (isMobile == false) DataCell(Fx.text('\$${invoice.amount.toStringAsFixed(2)}').bold()),
                      DataCell(Fx.row(
                        gap: 8,
                        children: [
                          Fx.icon(Icons.edit_outlined, size: 18, color: Colors.blue, onTap: () {
                             _showEditDialog(context, controller, invoice);
                          }),
                          Fx.icon(Icons.delete_outline, size: 18, color: Colors.redAccent, onTap: () {
                             controller.deleteInvoice(invoice.id);
                             Fx.toast(context, 'Invoice ${invoice.id} deleted');
                          }),
                        ],
                      )),
                    ]);
                  }).toList(),
                );

                if (isMobile) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: table,
                  );
                }
                return table;
              }),
            )
            .background(Colors.white)
            .rounded(20)
            .shadowSmall()
            .animate(fade: 0.0, slide: const Offset(0, 30), delay: 0.2),
          ],
        ).p(isMobile ? 16 : 24),
      ),
    );
  }

  List<Widget> _buildStatsWidgets(InvoiceController controller) {
    return [
      _buildMiniStat('Total Items', () => '${controller.invoices.length}', Icons.list_alt, Colors.blue),
      _buildMiniStat('Paid Total', () => '\$${controller.invoices.where((i) => i.status == 'Paid').fold(0.0, (sum, i) => sum + i.amount).toStringAsFixed(2)}', Icons.check_circle_outline, const Color(0xFF10B981)),
      _buildMiniStat('Unpaid Total', () => '\$${controller.invoices.where((i) => i.status == 'Unpaid').fold(0.0, (sum, i) => sum + i.amount).toStringAsFixed(2)}', Icons.error_outline, Colors.red),
    ];
  }

  Widget _buildStatusButton(BuildContext context, InvoiceController controller, Invoice invoice, bool isMobile) {
    final status = invoice.status;
    final colors = {
      'Paid': const Color(0xFF10B981),
      'Pending': Colors.orange,
      'Unpaid': Colors.red,
      'Processing': Colors.blue,
    };
    final color = colors[status] ?? Colors.grey;

    return Fx.button(
      status,
      onTap: () {
        final statuses = ['Paid', 'Pending', 'Unpaid', 'Processing'];
        final nextIndex = (statuses.indexOf(status) + 1) % statuses.length;
        controller.updateStatus(invoice.id, statuses[nextIndex]);
      },
    )
    .background(color.withValues(alpha: 0.1))
    .color(color)
    .fontSize(isMobile ? 10 : 12)
    .padding(isMobile ? 4 : 6)
    .rounded(4);
  }

  Widget _buildMiniStat(String label, String Function() valueBuilder, IconData icon, Color color) {
    return Fx.expand(
      child: Fx.box(
        child: Fx.row(
          children: [
            Fx.box(
              child: Fx.icon(icon, color: color, size: 20),
            ).p(10).rounded(12).background(color.withValues(alpha: 0.1)),
            Fx.box().w(16),
            Fx.col(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Fx.text(label).textXs().color(Colors.grey),
                Fx(() => Fx.text(valueBuilder()).semiBold().textBase()),
              ],
            ),
          ],
        ),
      )
      .p(16)
      .background(Colors.white)
      .rounded(16)
      .shadowSmall(),
    );
  }

  void _showEditDialog(BuildContext context, InvoiceController controller, Invoice invoice) {
    final amountSignal = flux(invoice.amount.toString());
    
    Fx.modal(context, child: Fx.box(
      child: Fx.col(
        gap: 20,
        children: [
          Fx.text('Edit Invoice ${invoice.id}').bold().fontSize(18),
          Fx.input(
            signal: amountSignal,
            placeholder: 'Amount (\$)',
          ),
          Fx.row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Fx.secondaryButton('Cancel', onTap: () => Fluxy.back()),
              Fx.box().w(12),
              Fx.button('Save Changes', onTap: () {
                final newAmount = double.tryParse(amountSignal.value) ?? invoice.amount;
                final index = controller.invoices.indexWhere((i) => i.id == invoice.id);
                if (index != -1) {
                   controller.invoices[index] = controller.invoices[index].copyWith(amount: newAmount);
                }
                Fluxy.back();
                Fx.snack(
                  context, 
                  'Invoice updated', 
                  width: 400,
                  backgroundColor: const Color(0xFF1E293B),
                );
              }),
            ],
          )
        ],
      ).p(24).pack(),
    ).w(400).bg.white.rounded(20));
  }
}
