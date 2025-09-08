import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Flutter layout demo',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Image.asset('assets/image.png'),
          Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              spacing: 32,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(
                          'Oeschinen Lake Campground',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Kandersteg, Switzerland',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          Text('41'),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      spacing: 12,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.deepPurple,
                          size: 32,
                        ),
                        Text(
                          'CALL',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(200, 104, 58, 183),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 12,
                      children: [
                        Icon(
                          Icons.flight,
                          size: 32,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          'ROUTE',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(200, 104, 58, 183),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 12,
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.deepPurple,
                          size: 32,
                        ),
                        Text(
                          'SHARE',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(200, 104, 58, 183),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
