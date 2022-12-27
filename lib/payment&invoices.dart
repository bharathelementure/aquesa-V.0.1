// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:otp_auth/Pages/inVoicePage.dart' show InvoicePage;
import 'package:otp_auth/Pages/paymentHistoryPage.dart';

class PaymentInvoices extends StatefulWidget {
  const PaymentInvoices({Key? key}) : super(key: key);

  @override
  State<PaymentInvoices> createState() => _PaymentInvoicesState();
}

class _PaymentInvoicesState extends State<PaymentInvoices> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'Payments & Invoices',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'raleway',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF)),
            ),
            bottom: const PreferredSize(
              preferredSize: Size.square(53),
              child: Material(
                color: Color(0xFF72AFDE),
                child: TabBar(
                  labelColor: Color(0xFFFFFFFF),
                  unselectedLabelColor: Color(0xFF676C77),
                  indicatorColor: Color(0xFFFFFFFF),
                  indicatorWeight: 2,
                  tabs: [
                    Tab(
                      text: 'INVOICES',
                    ),
                    Tab(
                      text: 'PAYMENT HISTORY',
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: const Color(0xFF72AFDE),
          ),
          body: const TabBarView(children: [
            InvoicePage(),
            PaymentHistoryPage(),
          ]),
        ));
  }
}
