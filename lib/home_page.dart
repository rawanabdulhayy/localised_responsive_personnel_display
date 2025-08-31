import 'package:flutter/material.dart';
import 'employee.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Employee> personnel = [
    Employee(
      name: "Alice Johnson",
      picture: "assets/images/avatar.jpeg",
      job: "Software Engineer",
    ),
    Employee(
      name: "Michael Smith",
      picture: "assets/images/avatar2.jpeg",
      job: "Project Manager",
    ),
    Employee(
      name: "Sophia Brown",
      picture: "assets/images/avatar.jpeg",
      job: "UI/UX Designer",
    ),
    Employee(
      name: "James Williams",
      picture: "assets/images/avatar2.jpeg",
      job: "Data Scientist",
    ),
    Employee(
      name: "Emma Davis",
      picture: "assets/images/avatar.jpeg",
      job: "QA Engineer",
    ),
    Employee(
      name: "Daniel Wilson",
      picture: "assets/images/avatar2.jpeg",
      job: "DevOps Engineer",
    ),
    Employee(
      name: "Olivia Taylor",
      picture: "assets/images/avatar.jpeg",
      job: "Product Owner",
    ),
    Employee(
      name: "Ethan Martinez",
      picture: "assets/images/avatar2.jpeg",
      job: "Mobile Developer",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //we have a blocBuilder too that takes Bloc Class and STATE, that takes a builder, that takes context  and STATE.
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            //mobile view
            return ListView.separated(
              separatorBuilder:
                  (context, index) => SizedBox(height: 15), // or Divider()
              // all properties apply to both; OG and The named constructor's.
              // Except children: []: only valid for the OG listview without the named constructor .builder
              // shrinkWrap: If true, ListView takes only as much space as needed, instead of expanding infinitely.
              // itemExtent: Fix height (or width if horizontal) for each item → improves performance.
              padding: EdgeInsets.all(16),
              scrollDirection: Axis.vertical,
              itemCount: personnel.length,
              itemBuilder: (context, index) {
                final employee = personnel[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // shadow color
                        spreadRadius: 2, // how wide the shadow spreads
                        blurRadius: 6, // how soft the shadow looks
                        offset: Offset(3, 3), // X,Y movement of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      // tileColor: Colors.blue.shade200,
                      // selectedTileColor: Colors.blue.shade100,
                      leading: ClipRRect(
                        //so clipRect does have a border radius
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          employee.picture,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            //tablet view
            return Container();
          }
        },
      ),
    );
  }
}
