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
      name: "Maybelle Smith",
      picture: "assets/images/avatar2.jpeg",
      job: "Project Manager",
    ),
    Employee(
      name: "Alice Johnson",
      picture: "assets/images/avatar.jpeg",
      job: "Software Engineer",
    ),
    Employee(
      name: "Maybelle Smith",
      picture: "assets/images/avatar2.jpeg",
      job: "Project Manager",
    ),
    Employee(
      name: "Alice Johnson",
      picture: "assets/images/avatar.jpeg",
      job: "Software Engineer",
    ),
    Employee(
      name: "Maybelle Smith",
      picture: "assets/images/avatar2.jpeg",
      job: "Project Manager",
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
                      title: Text(
                        employee.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(employee.job),
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
            return SizedBox(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250, // max width per tile
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
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
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        children: [
                          Text(
                            employee.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(employee.job),
                          // tileColor: Colors.blue.shade200,
                          // selectedTileColor: Colors.blue.shade100,
                          ClipRRect(
                            //so clipRect does have a border radius
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              employee.picture,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

/*
=============================================
🔹 Flutter List/Grid/Widgets Knowledge Recap
=============================================

1. SliverChildListDelegate
--------------------------
- Used internally by scrollable widgets like ListView/GridView to manage children.
- Example: ListView(children: <Widget>[...]) uses SliverChildListDelegate.
- You rarely use it directly, instead Flutter exposes builders (ListView.builder, GridView.builder).

2. ListView
-----------
Main constructors:
- ListView() → takes children (SliverChildListDelegate).
- ListView.builder() → builds items lazily with itemBuilder.
- ListView.separated() → like builder but with a separatorBuilder.
- ListView.custom() → full control with delegate.

Important ListView properties:
- scrollDirection: Axis.horizontal / Axis.vertical.
- reverse: flips scroll direction.
- controller: ScrollController for manual scrolling.
- primary: whether it’s the primary scroll view.
- physics: ScrollPhysics (e.g., BouncingScrollPhysics).
- shrinkWrap: true = size fits content (expensive!).
- padding: EdgeInsets for spacing.
- itemExtent: fixed height for optimization.
- childrenDelegate: low-level control.
- cacheExtent: pre-caches items.

✅ ListView vs ListView.builder:
- ListView: all children created upfront → heavy for large lists.
- builder: builds lazily → efficient for large/infinite lists.
- Both share same props.

3. GridView
-----------
- GridView works like ListView but in a grid layout.
- Constructors:
  - GridView.count() → fixed # of columns.
  - GridView.extent() → max pixel width per tile.
  - GridView.builder() → lazy loading.
  - GridView.custom() → with custom delegate.

Important GridView props:
- gridDelegate (MUST HAVE):
  - SliverGridDelegateWithFixedCrossAxisCount:
      crossAxisCount, mainAxisSpacing, crossAxisSpacing, childAspectRatio.
  - SliverGridDelegateWithMaxCrossAxisExtent:
      maxCrossAxisExtent, mainAxisSpacing, crossAxisSpacing, childAspectRatio.
- scrollDirection, physics, shrinkWrap, padding → same as ListView.

Grid Delegate:
- Determines how grid children are laid out.
- WithFixedCrossAxisCount → exact column count.
- WithMaxCrossAxisExtent → auto decides # of columns based on screen width.

4. Wrapping ListView/GridView
-----------------------------
- In a Column → must wrap in Expanded/Flexible to avoid infinite height errors.
- In a fixed size → can wrap in SizedBox(height: …) or Container with height.
- Otherwise → overflow errors.

5. ListTile
-----------
- Common widget for rows with leading/trailing widgets.
Properties:
- leading: Widget before title (e.g., Icon, CircleAvatar, ClipRRect).
- title: main text.
- subtitle: secondary text.
- trailing: widget at end (e.g., Icon).
- isThreeLine: allows 3-line layout.
- dense: reduces padding.
- contentPadding: controls inner spacing.
- onTap/onLongPress: callbacks.
- enabled: toggle interactivity.
- selected: mark as selected.
- horizontalTitleGap, minVerticalPadding, minLeadingWidth: fine spacing controls.

Background/border:
- No direct backgroundColor or border.
- Wrap in Container or Card:
  Container(
    decoration: BoxDecoration(
      color: Colors.blue[50],
      border: Border.all(color: Colors.black, width: 1),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6, offset: Offset(0, 3))],
    ),
    child: ListTile(...),
  );

Spacing between ListTiles:
- ListView.separated() with separatorBuilder.
- Or SizedBox(height: …) between items.

Circular images in ListTile:
- Use ClipOval, CircleAvatar, or ClipRRect(borderRadius: BorderRadius.circular(…)).

6. BoxShadow
------------
- Used in BoxDecoration.
- Syntax:
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 8,
      spreadRadius: 2,
      offset: Offset(2, 4),
    )
  ];

7. Grid Overflow Issue (your screenshot)
----------------------------------------
Cause:
- childAspectRatio too wide vs tile content → vertical overflow.
- Example: 1.2 forces width > height, but text+image need more height.

Solutions:
- Adjust childAspectRatio (0.7–1.0 for vertical cards).
- Wrap children with Expanded/Flexible so they resize.
- Or use SingleChildScrollView inside tile (last resort).

Example fix:
gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 200,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  childAspectRatio: 0.8, // taller tiles
);

Inside each card:
Column(
  children: [
    Expanded(child: Image.asset(employee.picture, height: 60)),
    SizedBox(height: 8),
    Text(employee.name, style: TextStyle(fontWeight: FontWeight.bold)),
    Text(employee.job, style: TextStyle(color: Colors.grey[700])),
  ],
);

8. Dart Class Example
---------------------
class Employee {
  String name;
  String picture;
  String job;

  Employee({
    required this.name,
    required this.picture,
    required this.job,
  });
}

final List<Employee> personnel = [];

9. Image Display in List/Grid
-----------------------------
- ListTile(leading: ClipOval(child: Image.asset(...))) → circular.
- ClipRRect → rounded rectangles.
- Can combine with SizedBox to fix sizes.

=============================================
END OF KNOWLEDGE RECAP
=============================================
*/
