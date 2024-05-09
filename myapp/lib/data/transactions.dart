import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> myTransactionData = [
  // January 2024
  {
    'icon': const FaIcon(FontAwesomeIcons.house, color: Colors.white),
    'color': Colors.red,
    'name': 'Mortgage',
    'totalAmount': '£800.00',
    'date': '01/01/2024',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.tv, color: Colors.white),
    'color': Colors.indigo,
    'name': 'Entertainment',
    'totalAmount': '£10.99',
    'date': '02/01/2024',
    'transaction': 'Netflix Subscription',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£50.25',
    'date': '04/01/2024',
    'transaction': 'Tesco',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.car, color: Colors.white),
    'color': Colors.blue,
    'name': 'Transport',
    'totalAmount': '£60.00',
    'date': '06/01/2024',
    'transaction': 'Tank of Gas',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    'color': Colors.yellow[700],
    'name': 'Eat Out',
    'totalAmount': '£65.75',
    'date': '08/01/2024',
    'transaction': 'Dinner at Italian Bistro',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    'color': Colors.purple,
    'name': 'Shopping',
    'totalAmount': '£45.00',
    'date': '10/01/2024',
    'transaction': 'New Jeans',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.tv, color: Colors.white),
    'color': Colors.indigo,
    'name': 'Entertainment',
    'totalAmount': '£100.00',
    'date': '12/01/2024',
    'transaction': 'Concert Tickets',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.moneyBillWave, color: Colors.white),
    'color': Colors.deepOrange,
    'name': 'Investment',
    'totalAmount': '£150.00',
    'date': '15/01/2024',
    'transaction': 'Stock Purchase',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£30.50',
    'date': '18/01/2024',
    'transaction': 'Sainsbury\'s',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£40.00',
    'date': '22/01/2024',
    'transaction': 'Asda',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.moneyBillTransfer, color: Colors.white),
    'color': Colors.brown,
    'name': 'Bills',
    'totalAmount': '£50.00',
    'date': '25/01/2024',
    'transaction': 'Phone Bill',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.car, color: Colors.white),
    'color': Colors.blue,
    'name': 'Transport',
    'totalAmount': '£40.00',
    'date': '28/01/2024',
    'transaction': 'Tank of Gas',
    'bank': 'Mock Bank 1'
  },

  // February 2024
  {
    'icon': const FaIcon(FontAwesomeIcons.house, color: Colors.white),
    'color': Colors.red,
    'name': 'Mortgage',
    'totalAmount': '£800.00',
    'date': '01/02/2024',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.tv, color: Colors.white),
    'color': Colors.indigo,
    'name': 'Entertainment',
    'totalAmount': '£10.99',
    'date': '02/02/2024',
    'transaction': 'Netflix Subscription',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£65.50',
    'date': '05/02/2024',
    'transaction': 'Tesco',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.car, color: Colors.white),
    'color': Colors.blue,
    'name': 'Transport',
    'totalAmount': '£45.00',
    'date': '07/02/2024',
    'transaction': 'Train Tickets',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    'color': Colors.yellow[700],
    'name': 'Eat Out',
    'totalAmount': '£22.50',
    'date': '10/02/2024',
    'transaction': 'Lunch at Cafe',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    'color': Colors.purple,
    'name': 'Shopping',
    'totalAmount': '£85.00',
    'date': '12/02/2024',
    'transaction': 'New Shoes',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.tv, color: Colors.white),
    'color': Colors.indigo,
    'name': 'Entertainment',
    'totalAmount': '£30.00',
    'date': '18/02/2024',
    'transaction': 'Movie Night',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.moneyBillWave, color: Colors.white),
    'color': Colors.deepOrange,
    'name': 'Investment',
    'totalAmount': '£200.00',
    'date': '22/02/2024',
    'transaction': 'Mutual Fund Investment',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£55.25',
    'date': '24/02/2024',
    'transaction': 'Sainsbury\'s',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£65.00',
    'date': '26/02/2024',
    'transaction': 'Asda',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.moneyBillTransfer, color: Colors.white),
    'color': Colors.brown,
    'name': 'Bills',
    'totalAmount': '£70.00',
    'date': '28/02/2024',
    'transaction': 'Energy Bill',
    'bank': 'Mock Bank 2'
  },

  // March 2024
  {
    'icon': const FaIcon(FontAwesomeIcons.house, color: Colors.white),
    'color': Colors.red,
    'name': 'Mortgage',
    'totalAmount': '£800.00',
    'date': '01/03/2024',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.tv, color: Colors.white),
    'color': Colors.indigo,
    'name': 'Entertainment',
    'totalAmount': '£10.99',
    'date': '02/03/2024',
    'transaction': 'Netflix Subscription',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£75.30',
    'date': '05/03/2024',
    'transaction': 'Tesco',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.car, color: Colors.white),
    'color': Colors.blue,
    'name': 'Transport',
    'totalAmount': '£60.00',
    'date': '07/03/2024',
    'transaction': 'Tank of Gas',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    'color': Colors.yellow[700],
    'name': 'Eat Out',
    'totalAmount': '£95.80',
    'date': '11/03/2024',
    'transaction': 'Dinner with Friends',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    'color': Colors.purple,
    'name': 'Shopping',
    'totalAmount': '£70.00',
    'date': '14/03/2024',
    'transaction': 'New Dress',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.tv, color: Colors.white),
    'color': Colors.indigo,
    'name': 'Entertainment',
    'totalAmount': '£60.00',
    'date': '19/03/2024',
    'transaction': 'Comedy Show Tickets',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.moneyBillWave, color: Colors.white),
    'color': Colors.deepOrange,
    'name': 'Investment',
    'totalAmount': '£120.00',
    'date': '25/03/2024',
    'transaction': 'Roth IRA Contribution',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.moneyBillTransfer, color: Colors.white),
    'color': Colors.brown,
    'name': 'Bills',
    'totalAmount': '£30.00',
    'date': '25/03/2024',
    'transaction': 'Electricity',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£40.00',
    'date': '27/03/2024',
    'transaction': 'Sainsbury\'s',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£50.00',
    'date': '29/03/2024',
    'transaction': 'Asda',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.moneyBillTransfer, color: Colors.white),
    'color': Colors.brown,
    'name': 'Bills',
    'totalAmount': '£50.00',
    'date': '31/03/2024',
    'transaction': 'Phone Bill',
    'bank': 'Mock Bank 1'
  },

  // April 2024
  {
    'icon': const FaIcon(FontAwesomeIcons.house, color: Colors.white),
    'color': Colors.red,
    'name': 'Mortgage',
    'totalAmount': '£800.00',
    'date': '01/04/2024',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.tv, color: Colors.white),
    'color': Colors.indigo,
    'name': 'Entertainment',
    'totalAmount': '£10.99',
    'date': '02/04/2024',
    'transaction': 'Netflix Subscription',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Grocery',
    'totalAmount': '£60.75',
    'date': '05/04/2024',
    'transaction': 'Tesco',
    'bank': 'Mock Bank 2'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.car, color: Colors.white),
    'color': Colors.blue,
    'name': 'Transport',
    'totalAmount': '£50.00',
    'date': '07/04/2024',
    'transaction': 'Tank of Gas',
    'bank': 'Mock Bank 1'
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    'color': Colors.yellow[700],
    'name': 'Eat Out',
    'totalAmount': '£40.25',
    'date': '10/04/2024',
    'transaction': 'Lunch at Pub',
    'bank': 'Mock Bank 2'
  },
];