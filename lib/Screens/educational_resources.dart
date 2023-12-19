import 'package:flutter/material.dart';

class EducationalResources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Resources'),
        backgroundColor: Color(0xff374366),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          BlogCard(
            heading: 'Understanding infant reflux',
            description:
                'Gain comprehensive insights for parents on understanding infant reflux, addressing concerns and promoting a more informed and confident caregiving approach.',
            destinationPage: FirstPage(),
          ),
          BlogCard(
            heading: 'Identifying rashes in little ones',
            description:
                "Learn to identify rashes in little ones, empowering parents with knowledge to recognize and address common skin concerns for their child's well-being.",
            destinationPage: SecondPage(),
          ),
          BlogCard(
            heading: 'Neonatal herpes unveiled',
            description:
                'Unveil the nuances of neonatal herpes—providing new parents with essential insights on understanding, prevention, and care for the well-being of their newborns',
            destinationPage: ThirdPage(),
          ),
          BlogCard(
            heading:
                'Why babies hold their breath and what can you do about them',
            description:
                "Explore why babies hold their breath and discover practical tips for parents on how to respond and ensure their little one's well-being.",
            destinationPage: FourthPage(),
          ),
          BlogCard(
            heading: 'Dealing with jaundice',
            description:
                'Navigate the complexities of dealing with jaundice with this ultimate guide for new parents, offering essential insights and practical tips for the well-being of your newborn',
            destinationPage: FourthPage(),
          ),
          BlogCard(
            heading: 'Understanding baby breathing',
            description:
                'Gain insights into understanding baby breathing, focusing on recognizing and addressing respiratory distress in newborns for confident and informed parenting',
            destinationPage: FourthPage(),
          ),
          BlogCard(
            heading: 'Amazing meal ideas for your toddler',
            description:
                'Unlock a world of amazing meal ideas tailored for toddlers, ensuring nutritious and delightful options that cater to their developing tastes and nutritional needs',
            destinationPage: FourthPage(),
          ),
          BlogCard(
            heading:
                'Important safety and hygiene techniques for the well-being of Baby',
            description:
                "Ensure baby's safety with child-proof spaces, secure furniture, and proper hygiene practices, including handwashing and vaccinations, for a healthy and happy upbringing",
            destinationPage: FourthPage(),
          ),
        ],
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String heading;
  final String description;
  final Widget destinationPage;

  BlogCard({
    required this.heading,
    required this.description,
    required this.destinationPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a different page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Card(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff374366),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff374366),
        title: Text('Understanding Infant Reflux'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Understanding Infant Reflux: A Comprehensive Insight for Parents",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Reflux is when a baby brings up milk, or is sick, during or shortly after feeding. It's very common and usually gets better on its own.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Causes of reflux",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Reflux usually happens because your baby's food pipe (oesophagus) has not fully developed, so milk can come back up easily.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "Your baby's oesophagus will develop as they get older and the reflux should stop"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Check if your baby has reflux",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "Reflux usually starts before a baby is 8 weeks old and gets better by the time they're 1."),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Symptoms of reflux in babies include:"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Bringing up milk or being sick during or shortly after feeding",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Coughing or hiccupping when feeding",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Being unsettled during feeding",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Swallowing or gulping after burping or feeding",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Crying and not settling",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Not gaining weight as they're not keeping enough food down",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "Sometimes babies may have signs of reflux but will not bring up milk or be sick. This is known as silent reflux."),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Things you can try to ease reflux in babies",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Your baby does not usually need to see a doctor if they have reflux, as long as they're happy, healthy and gaining weight.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "ask a health visitor for advice and support",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "get advice about your baby's breastfeeding position or how to bottle feed your baby",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "hold your baby upright during feeding and for as long as possible after feeding",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "burp your baby regularly during feeds",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "give formula-fed babies smaller feeds more often",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "make sure your baby sleeps flat on their back (they should not sleep on their side or front)",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Consult an immediate appointment to one of our doctors if:",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Is not improving after trying things to ease reflux",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "gets reflux for the first time after they're 6 months old",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Is older than 1 and still has reflux",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Is not gaining weight or is losing weight",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Treatment for reflux in babies",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "A GP or specialist may sometimes recommend treatments for reflux.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If your baby is formula-fed, you may be given:",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "A powder that's mixed with formula to thicken it",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "A pre-thickened formula milk",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If the thickening powder does not help or your baby is breastfed, a GP or specialist might recommend medicines that stop your baby's stomach producing as much acid.",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Very rarely, surgery might be needed to strengthen the muscles to stop food or milk travelling back up. This is usually only after trying other things or if their reflux is severe.",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Text('This is the second page'),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Center(
        child: Text('This is the third page'),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fourth Page'),
      ),
      body: Center(
        child: Text('This is the fourth page'),
      ),
    );
  }
}
