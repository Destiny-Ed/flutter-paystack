import 'package:flutter/material.dart';
import 'package:paystack_app/Payment/paystack_payment_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Create variables
  int selectedIndex;

  int price = 0;

  String email = "//User Email Here";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //Choose a plan
            Container(
              alignment: Alignment.center,
              child: Text(
                "Choose\nYour Plan",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            //GridView
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                children: List.generate(plans.length, (index) {
                  final data = plans[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        price = data["price"];
                      });
                    },
                    child: Card(
                      shadowColor: Colors.purpleAccent,
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: selectedIndex == null
                              ? null
                              : selectedIndex == index
                                  ? Colors.purpleAccent
                                  : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "N ${data["price"]}",
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              "Get ${data["items"]} More",
                            ),
                            Text(
                              "Items",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            GestureDetector(
              onTap: () {
                if (selectedIndex == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a plan")));
                } else {
                  //Call Paystack payment
                  print(price);
                  MakePayment(ctx: context, email: email, price: price)
                      .chargeCardAndMakePayment();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.purpleAccent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //icon
                    Icon(Icons.security, color: Colors.white),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Proceed to payment",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final plans = [
    {"price": 500, "items": 4},
    {"price": 1000, "items": 6},
    {"price": 3500, "items": 9},
    {"price": 5600, "items": 10},
  ];
}
