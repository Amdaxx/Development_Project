import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationResourcesPage extends StatelessWidget {
  const EducationResourcesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Education Center'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),

              SizedBox(height: 20),
              ResourceCard(
                title: 'Budgeting Basics',
                description: 'Learn the fundamentals of budgeting to better manage your finances.',
                icon: Icons.book,
                link: 'https://www.investopedia.com/terms/b/budget.asp',
              ),
              ResourceCard(
                title: 'Tracking Your Spending',
                description: 'Find out how tracking your spending can help you save money.',
                icon: Icons.timeline,
                link: 'https://www.nerdwallet.com/blog/finance/how-to-track-your-spending/',
              ),
              ResourceCard(
                title: 'Saving Strategies',
                description: 'Discover effective strategies to boost your savings effortlessly.',
                icon: Icons.savings,
                link: 'https://www.bettermoneyhabits.bankofamerica.com/en/saving-budgeting/ways-to-save-money',
              ),
              ResourceCard(
                title: 'Understanding Credit',
                description: 'Grasp the basics of credit and how it affects your financial life.',
                icon: Icons.credit_card,
                link: 'https://www.consumerfinance.gov/about-us/blog/key-takeaways-understanding-how-credit-works/',
              ),
              ResourceCard(
                title: 'Investment Fundamentals',
                description: 'Explore the essentials of investing and how to start.',
                icon: Icons.show_chart,
                link: 'https://www.investor.gov/introduction-investing/investing-basics',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String link;

  const ResourceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(icon, size: 56.0, color: Theme.of(context).primaryColor),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(description),
          onTap: () async {
            if (await canLaunch(link)) {
              await launch(link);
            } else {
              throw 'Could not launch $link';
            }
          },
        ),
      ),
    );
  }
}
