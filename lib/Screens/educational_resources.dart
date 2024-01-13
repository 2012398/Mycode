import 'package:flutter/material.dart';

class EducationalResources extends StatelessWidget {
  const EducationalResources({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Resources'),
        backgroundColor: const Color(0xff374366),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          BlogCard(
            heading: 'Understanding infant reflux',
            description:
                'Gain comprehensive insights for parents on understanding infant reflux, addressing concerns and promoting a more informed and confident caregiving approach.',
            destinationPage: const FirstPage(),
          ),
          BlogCard(
            heading: 'Identifying rashes in little ones',
            description:
                "Learn to identify rashes in little ones, empowering parents with knowledge to recognize and address common skin concerns for their child's well-being.",
            destinationPage: const SecondPage(),
          ),
          BlogCard(
            heading: 'Neonatal herpes unveiled',
            description:
                'Unveil the nuances of neonatal herpes—providing new parents with essential insights on understanding, prevention, and care for the well-being of their newborns',
            destinationPage: const ThirdPage(),
          ),
          BlogCard(
            heading:
                'Why babies hold their breath and what can you do about them',
            description:
                "Explore why babies hold their breath and discover practical tips for parents on how to respond and ensure their little one's well-being.",
            destinationPage: const FourthPage(),
          ),
          BlogCard(
            heading: 'Dealing with jaundice',
            description:
                'Navigate the complexities of dealing with jaundice with this ultimate guide for new parents, offering essential insights and practical tips for the well-being of your newborn',
            destinationPage: const FifthPage(),
          ),
          BlogCard(
            heading: 'Understanding baby breathing',
            description:
                'Gain insights into understanding baby breathing, focusing on recognizing and addressing respiratory distress in newborns for confident and informed parenting',
            destinationPage: const SixthPage(),
          ),
          BlogCard(
            heading: 'Amazing meal ideas for your toddler',
            description:
                'Unlock a world of amazing meal ideas tailored for toddlers, ensuring nutritious and delightful options that cater to their developing tastes and nutritional needs',
            destinationPage: const SeventhPage(),
          ),
          BlogCard(
            heading:
                'Important safety and hygiene techniques for the well-being of Baby',
            description:
                "Ensure baby's safety with child-proof spaces, secure furniture, and proper hygiene practices, including handwashing and vaccinations, for a healthy and happy upbringing",
            destinationPage: const EighthPage(),
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
    super.key,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff374366),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: const TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Understanding Infant Reflux'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
  const SecondPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Identifying Rashes in Little Ones'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
                      "Many things can cause a rash in babies and children, and they're often nothing to worry about.",
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
                      "This page covers some of the common rashes in babies and children.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "As a new-parent, you may know if your child seems seriously unwell and should trust your judgement.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Blisters on hands and feet plus mouth ulcers",
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
                      "Blisters on the hands and feet, with ulcers in the mouth, could be hand, foot and mouth disease.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "Hand, foot and mouth disease can usually be treated at home."),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Rash on the face and body",
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
                        "A rash of small, raised bumps that feels rough, like sandpaper, could be scarlet fever."),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "Speak to a pediatrician if you think your child has scarlet fever."),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Raised, itchy spots or patches",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Raised, itchy patches or spots could be caused by an allergic reaction (hives).",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Hives can usually be treated at home. But chat with our experienced doctors if there's swelling around your child's mouth or they're struggling to breathe.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Rash without fever or itching",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Very small spots, called milia, often appear on a baby's face when they're a few days old. Milia may appear white or yellow, depending on your baby's skin colour.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "They usually go away within a few weeks and do not need treatment.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Raised red, yellow and white spots (erythema toxicum) can appear on babies when they're born. They usually appear on the face, body, upper arms and thighs.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "The rash can disappear and reappear. It should get better in a few weeks without treatment.",
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
                    child: Text("Pimples on the cheeks, nose and forehead",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Spots that appear on a baby's cheeks, nose or forehead within a month after birth could be baby acne.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "You do not need to treat baby acne. It usually gets better after a few weeks or months.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "In conclusion, while rashes in babies and children may seem concerning, many of them are harmless and can be a normal part of their development. As a new parent, it's essential to trust your judgment and monitor your child's overall well-being. Common rashes, such as those mentioned here, often resolve on their own without the need for extensive treatment. However, if you ever have doubts or notice any worrisome symptoms, consulting with a pediatrician is always a good step to ensure your child's health and provide you with peace of mind. Remember, every child is unique, and if you ever have concerns, seeking professional advice is the best course of action.",
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

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title:
            const Text('Understanding, Prevention, and Care for New Parents'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
                      "Neonatal herpes is a herpes infection in a young baby. The younger the baby, the more vulnerable they are to the harmful effects of infection.",
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
                      "Herpes can be very serious for a young baby, whose immune system will not have fully developed to fight off the virus.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Neonatal herpes, which is rare in the UK, is caused by the herpes simplex virus. This virus is very common and causes cold sores and genital ulcers in adults.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "It is caused by the herpes simplex virus. This virus is very common and causes cold sores and genital ulcers in adults.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Neonatal herpes can be prevented by following some simple advice.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Neonatal herpes can be prevented by following some simple advice.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("How does a newborn baby catch herpes?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "If you had genital herpes for the first time within the last 6 weeks of your pregnancy, your newborn baby is at risk of catching herpes."),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "There's a risk you will have passed the infection on to your baby if you had a vaginal delivery."),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "This risk is much lower if you have had genital herpes before."),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("After birth",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "The herpes simplex virus can be passed to a baby through a cold sore if a person has a cold sore and kisses the baby.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "The herpes virus can also be spread to your baby if you have a blister caused by herpes on your breast and you feed your baby with the affected breast or expressed breast milk from the affected breast.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          "A baby is most at risk of getting a herpes infection in the first 4 weeks after birth.")),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "You should not kiss a baby if you have a cold sore to reduce the risk of spreading infection.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Cold sores and other blisters caused by the herpes virus are at their most contagious when they burst. They remain contagious until completely healed.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "What are the warning signs in babies?",
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
                      "Because newborn babies have underdeveloped immune systems, they can quickly become seriously ill after catching the virus.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Get to your nearest doctor immediately or call an emergency if your baby:",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "is lethargic or irritable",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "is not feeding",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "has a high temperature (fever) – find out how to take your baby's temperature",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "has a rash or sores on the skin, eyes and inside the mouth",
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
                      "How is neonatal herpes treated?",
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
                      "Neonatal herpes is usually treated with antiviral medicines given directly into the baby's vein (intravenously).",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "This treatment may be needed for several weeks.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Any related complications, such as fits (seizures), will also need to be treated.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "You can breastfeed your baby while they're receiving treatment, unless you have herpes sores around your nipples.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If you are taking antiviral treatment too, this can be excreted in your breast milk, but is not thought to cause any harm to your baby.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("How serious is herpes for a baby?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Sometimes neonatal herpes will only affect the baby's eyes, mouth or skin.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "In these cases, most babies will make a complete recovery with antiviral treatment.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "But the condition is much more serious if it has spread to the baby's organs.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Many infants with this type of neonatal herpes will die, even after they have been treated.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If widespread herpes is not treated immediately, there's a high chance the baby will die.",
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

class FourthPage extends StatelessWidget {
  const FourthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Why Babies Hold Their Breath'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
                      "Breath-holding is when a baby or child stops breathing for up to 1 minute and may faint. It can happen when a child is frightened, upset, angry, or has a sudden shock or pain. It's usually harmless but can be scary for parents, particularly when it happens for the first time.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Causes of breath-holding",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Breath-holding is not something a child does deliberately.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "It's usually triggered by a sudden shock or pain, or strong emotions like fear, upset or anger.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("There are 2 types of breath-holding:"),
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
                            "blue breath-holding spells – this is the most common type of breath-holding and happens when a child's breathing pattern changes",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "reflex anoxic seizures – this type of breath-holding happens when a child's heart rate slows down",
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
                    child: Text("What happens during breath-holding",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "During breath-holding, your child may:",
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
                            "cry and then be silent while holding their breath",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "open their mouth as if going to cry but make no sound",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "turn pale, blue or grey",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "be floppy or stiff, or their body may jerk",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "faint for 1 or 2 minutes",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Your child may be sleepy or confused for a short while afterwards.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Breath-holding is usually harmless",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Breath-holding can be scary for parents, but it's usually harmless and your child should grow out of it by the age of 4 or 5.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Breath-holding episodes:",
                    ),
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
                            "usually last for less than 1 minute (if the child faints, they'll usually regain consciousness within 1 or 2 minutes)",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "are not epileptic seizures",
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
                      "Your child is not holding their breath on purpose and cannot control what happens when they have a breath-holding episode.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "What to do when a child has a breath-holding episode",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                      "There are some things you can do when a child has a breath-holding episode.",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "stay calm – it should pass in less than 1 minute",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "lie the child on their side – do not pick them up",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "stay with them until the episode ends",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "make sure they cannot hit their head, arms or legs on anything",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "act normally after an episode, reassure them and ensure they get plenty of rest",
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
                    child: Text("Treatments for breath-holding",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "There's no specific treatment for breath-holding. It should eventually stop by the time your child is 4 or 5 years old.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Medicines are rarely used to treat breath-holding.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Breath-holding is sometimes related to iron deficiency anaemia.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Your child's blood iron levels may be checked. They may need iron supplements if their iron levels are low.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "While breath-holding episodes can be alarming for parents, it's important to remember that they are usually harmless and often a phase that children outgrow by the age of 4 or 5. Stay calm during an episode, provide reassurance, and ensure a safe environment. Remember, your child is not intentionally holding their breath, and these episodes typically last for less than a minute.",
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

class FifthPage extends StatelessWidget {
  const FifthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Dealing With Jaundice'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
                      "Jaundice in newborn babies is common and usually harmless. It causes yellowing of the skin and the whites of the eyes. The medical term for jaundice in babies is neonatal jaundice.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Yellowing of the skin can be more difficult to see in brown or black skin. It might be easier to see on the palms of the hands or the soles of the feet.",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Other symptoms of newborn jaundice can include:",
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
                            "dark, yellow urine (a newborn baby's urine should be colourless)",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "pale-coloured poo (it should be yellow or orange)",
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
                      "The symptoms of newborn jaundice usually develop 2 days after the birth and tend to get better without treatment by the time the baby is about 2 weeks old.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Your baby will be examined for signs of jaundice within 72 hours of being born as part of the newborn physical examination.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If your baby develops signs of jaundice after this time, speak to your midwife, health visitor or a GP as soon as possible for advice.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "While jaundice is not usually a cause for concern, it's important to determine whether your baby needs treatment.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If you're monitoring your baby's jaundice at home, it's also important to contact your midwife straight away if your baby's symptoms quickly get worse or they become very reluctant to feed.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Why does my baby have jaundice?",
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
                      "Jaundice is caused by the build-up of bilirubin in the blood. Bilirubin is a yellow substance produced when red blood cells, which carry oxygen around the body, are broken down.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Jaundice is common in newborn babies because babies have a high number of red blood cells in their blood, which are broken down and replaced frequently.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Also, a newborn baby's liver is not fully developed, so it's less effective at removing the bilirubin from the blood.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "By the time a baby is about 2 weeks old, their liver is more effective at processing bilirubin, so jaundice often corrects itself by this age without causing any harm.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "In a small number of cases, jaundice can be the sign of an underlying health condition. This is often the case if jaundice develops shortly after birth (within the first 24 hours).",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "How common is newborn jaundice?",
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
                      "Jaundice is one of the most common conditions that can affect newborn babies.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "It's estimated 6 out of every 10 babies develop jaundice, including 8 out of 10 babies born prematurely before the 37th week of pregnancy.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "But only around 1 in 20 babies has a blood bilirubin level high enough to need treatment.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "For reasons that are unclear, breastfeeding increases a baby's risk of developing jaundice, which can often persist for a month or longer.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "But in most cases, the benefits of breastfeeding far outweigh any risks associated with jaundice.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Treating newborn jaundice",
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
                      "Treatment for newborn jaundice is not usually needed because the symptoms normally pass within 10 to 14 days, although they can occasionally last longer.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Treatment is usually only recommended if tests show very high levels of bilirubin in a baby's blood.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "This is because there's a small risk the bilirubin could pass into the brain and cause brain damage.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "There are 2 main treatments that can be carried out in hospital to quickly reduce your baby's bilirubin levels.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "These are:",
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
                            "phototherapy – a special type of light shines on the skin, which alters the bilirubin into a form that can be more easily broken down by the liver",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "an exchange transfusion – where your baby's blood is removed using a thin tube (catheter) placed in their blood vessels and replaced with blood from a matching donor; most babies respond well to treatment and can leave hospital after a few days",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
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

class SixthPage extends StatelessWidget {
  const SixthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Understanding Baby Breathing'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
                      "Newborn respiratory distress syndrome (NRDS) happens when a baby's lungs are not fully developed and cannot provide enough oxygen, causing breathing difficulties. It usually affects premature babies",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "It's also known as infant respiratory distress syndrome, hyaline membrane disease or surfactant deficiency lung disease.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Why it happens",
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
                      "NRDS usually occurs when the baby's lungs have not produced enough surfactant",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "This substance, made up of proteins and fats, helps keep the lungs inflated and prevents them collapsing.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "A baby normally begins producing surfactant sometime between weeks 24 and 28 of pregnancy.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Most babies produce enough to breathe normally by week 34.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If your baby is born prematurely, they may not have enough surfactant in their lungs.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Occasionally, NRDS affects babies that are not born prematurely.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "For example, when:",
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
                            "the mother has diabetes",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "the baby is underweight",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "the baby's lungs have not developed properly",
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
                      "Around half of all babies born between 28 and 32 weeks of pregnancy develop NRDS.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "In recent years the number of premature babies born with NRDS has been reduced with the use of steroid injections, which can be given to mothers during premature labour.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Symptoms of NRDS",
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
                      "The symptoms of NRDS are often noticeable immediately after birth and get worse over the following few days.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "They can include:",
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
                            "blue-colored lips, fingers and toes",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "rapid, shallow breathing",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "flaring nostrils",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "a grunting sound when breathing",
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
                      "Diagnosing NRDS",
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
                      "A number of tests can be used to diagnose NRDS and rule out other possible causes.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "These include:",
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
                            "a physical examination",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "blood tests to measure the amount of oxygen in the baby's blood and check for an infection",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "a pulse oximetry test to measure how much oxygen is in the baby's blood using a sensor attached to their fingertip, ear or toe",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "a chest X-ray to look for the distinctive cloudy appearance of the lungs in NRDS",
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
                      "Treating NRDS",
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
                      "The main aim of treatment for NRDS is to help the baby breathe.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Your baby may be transferred to a ward that provides specialist care for premature babies (a neonatal unit).",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If the symptoms are mild, they may only need extra oxygen. It's usually given through an incubator, a small mask over their nose or face or tubes into their nose.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If symptoms are more severe, your baby will be attached to a breathing machine (ventilator) to either support or take over their breathing.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "These treatments are often started immediately in the delivery room before transfer to the neonatal unit.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Your baby may also be given a dose of artificial surfactant, usually through a breathing tube.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Evidence suggests early treatment within 2 hours of delivery is more beneficial than if treatment is delayed.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "They'll also be given fluids and nutrition through a tube connected to a vein.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Some babies with NRDS only need help with breathing for a few days. But some, usually those born extremely prematurely, may need support for weeks or even months.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Premature babies often have multiple problems that keep them in hospital, but generally they're well enough to go home around their original expected delivery date.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "The length of time your baby needs to stay in hospital will depend on how early they were born.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Complications of NRDS",
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
                      "Most babies with NRDS can be successfully treated, although they have a high risk of developing further problems later in life.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Air leaks",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Air can sometimes leak out of the baby's lungs and become trapped in their chest cavity. This is known as a pneumothorax.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "The pocket of air places extra pressure on the lungs, causing them to collapse and leading to additional breathing problems.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Air leaks can be treated by inserting a tube into the chest to allow the trapped air to escape.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Lung scarring",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Sometimes ventilation (begun within 24 hours of birth) or the surfactant used to treat NRDS causes scarring to the baby's lungs, which affects their development.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "This lung scarring is called bronchopulmonary dysplasia (BPD).",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Symptoms of BPD include rapid, shallow breathing and shortness of breath.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Babies with severe BPD usually need additional oxygen from tubes into their nose to help with their breathing.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "This is usually stopped after a few months, when the lungs have healed.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "But children with BPD may need regular medicine, such as bronchodilators, to help widen their airways and make breathing easier.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Developmental disabilities",
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
                      "If the baby's brain is damaged during NRDS, either because of bleeding or a lack of oxygen, it can lead to long-term developmental disabilities, such as learning difficulties, movement problems, impaired hearing and impaired vision.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "But these developmental problems are not usually severe. For example, 1 survey estimated that 3 out of 4 children with developmental problems only have a mild disability, which should not stop them leading a normal adult life.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "If there are severe breathing problems, consult your nearest doctor immediately.",
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

class SeventhPage extends StatelessWidget {
  const SeventhPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Amazing Meal Ideas'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
                      "If you need some inspiration to help you cook healthy and tasty food for your child, try these meal ideas.",
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
                      "These are not suitable as first foods but are fine once your baby is used to eating a wide range of solid foods.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "When preparing food for babies, do not add sugar or salt (including stock cubes and gravy) directly to the food or to the cooking water.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Breakfast ideas for babies and young children",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                            "unsweetened porridge or lower-sugar cereal mixed with whole milk and topped with fruit, such as mashed ripe pear or banana",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "wholewheat biscuit cereal (choose lower-sugar options) with whole milk and fruit",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "lower-sugar breakfast cereal and unsweetened stewed apple with plain, unsweetened yoghurt",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "toast fingers with mashed banana and smooth peanut butter (if possible, choose unsalted and no added sugar varieties)",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "toast fingers with a hard-boiled egg and slices of tomato, banana or ripe peach",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "toast or muffin fingers with scrambled egg and slices of tomato",
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
                    child: Text("Lunch ideas for babies",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                            "lamb curry with rice",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "cauliflower cheese with cooked pasta pieces",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "baked beans (reduced salt and sugar) with toast",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "scrambled egg with toast, chapatti or pitta bread served with vegetable finger foods",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "cottage cheese (full-fat) dip with pitta bread, cucumber and carrot sticks",
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
                      "Dinner ideas for babies and young children",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                            "mashed sweet potato with chickpeas and cauliflower",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "shepherd's pie (made with beef or lamb and/or lentils or vegetarian mince) with green vegetables",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "rice and mashed peas with courgette sticks",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "minced chicken and vegetable casserole with mashed potato",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "mashed canned salmon with couscous and peas",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "fish poached in milk with potato, broccoli and carrot",
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
                    child: Text("Finger foods for babies and young children",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Finger food is food that's cut up into pieces big enough for your child to hold in their fist with a bit sticking out. Pieces about the size of your own finger work well.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Examples of finger foods:",
                    ),
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
                            "soft-cooked vegetables, such as broccoli, cauliflower, courgette, parsnip and sweet potato",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "carrot or cucumber sticks and avocado",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "fresh fruits, such as apple (soft-cooked if needed), banana or soft, ripe peeled pear or peach",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "strips of meat without bones, such as chicken and lamb",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "cheese on toast fingers, made with full-fat cheese, and cucumber",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "hard boiled eggs",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "omelette fingers",
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
                    child: Text("Healthy snacks for young children",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Babies under 12 months do not need snacks; if you think your baby is hungry in between meals, offer extra milk feeds instead.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Once your baby is 1 year old, you can introduce 2 healthy snacks in between meals. For example:",
                    ),
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
                            "vegetables, such as broccoli florets, carrot sticks or cucumber sticks",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "slices of fruit, such as apple, banana or soft, ripe peeled pear or peach",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "pasteurised, plain, unsweetened full-fat yoghurt",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "toast, pitta or chapatti fingers",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "unsalted and unsweetened rice or corn cakes",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "small strips of cheese",
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
                        "Getting your child to eat fruit and vegetables",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "It may take up to 10 tries, or even more, for your child to get used to new foods, flavour and textures.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Be patient and keep offering a variety of fruits and vegetables, including ones with bitter flavours, such as broccoli, cauliflower, spinach and cabbage.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Try to make sure fruits and vegetables are included in every meal.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "To help your child eat more fruit and vegetables:",
                    ),
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
                            "give carrot sticks, cucumber sticks or slices of pepper with hummus as a snack",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "give apple slices with smooth peanut butter as a snack",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "mix chopped or mashed vegetables with rice, mashed potatoes, meat sauces or dhal",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "add vegetables to classic savoury dishes such as cottage or shepherd's pie, spaghetti bolognese or casseroles",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "chop prunes or dried apricots into cereal or plain, unsweetened yoghurt, or add them to a stew",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "for a tasty dessert, try mixing fruit (fresh, canned or stewed) with plain, unsweetened yoghurt",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
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

class EighthPage extends StatelessWidget {
  const EighthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Safety And Hygiene Techniques'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
                      "Keep your child safe from food bugs",
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
                      "Babies and young children are especially vulnerable to bacteria that can cause food poisoning.",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Make sure your child isn't put at risk because of the way you prepare or serve food.",
                    ),
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
                            "Always wash your hands before preparing food and after touching raw meat, chicken, fish and shellfish, raw vegetables and eggs.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Check that your child's hands are clean before feeding.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Teach your children to wash their hands after touching pets and going to the toilet, and before eating.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Keep surfaces clean and keep any pets away from food or surfaces where food is prepared or eaten.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Thoroughly wash all bowls and spoons used for feeding in hot soapy water, and make sure chopping boards and utensils are also kept clean.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Keep raw meats and eggs covered and away from other foods in the fridge, including cooked or ready-to-eat meats – you should always store raw meats in clean, covered containers at the bottom of the fridge to prevent any drips from falling onto other foods.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Cook all food thoroughly and cool it until lukewarm before giving it to your child.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Don't save and reuse foods that your child has half eaten.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Wash and peel fruit and vegetables such as apples and carrots.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Avoid eating raw or lightly cooked shellfish. Babies and children should only eat shellfish that's been thoroughly cooked.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Don't give children food or drink when they're sitting on the potty.",
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
                    child: Text("Storing and reheating food for children",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                            "Cool food as quickly as possible (ideally within 1 to 2 hours) and put it in the fridge or freezer. Food placed in the fridge should be eaten within 2 days.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Cool rice as quickly as possible (within 1 hour) and put it in the fridge or freezer. Rice placed in the fridge should be eaten within 24 hours and never reheated more than once.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "Frozen food should be thoroughly defrosted before reheating. The safest way to do this is to leave it in the fridge overnight or use the defrost setting on a microwave.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "When reheating food, make sure it's steaming hot all the way through, then let it cool down before giving it to your child. If you're using a microwave, always stir the food and check the temperature before feeding it to your child. Don't reheat cooked food more than once.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0, bottom: 0),
                          dense: true,
                          leading: Icon(Icons.arrow_right),
                          title: Text(
                            "To cool food quickly, put it in an airtight container and hold it under a cold running tap. Stir it from time to time so it cools consistently all the way through.",
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
                        "Remember, always stay with your child while they're eating in case they choke."),
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
