import 'package:flutter/material.dart';


class ExpansionTileSample extends StatelessWidget {

  Future<String> doOne() async {
    Future.delayed(Duration(seconds: 10));
    return 'done one';
  }

  Future<void> doTwo(String input) async {
    print('done two after $input');
  }

  doMethods() async {
    print('going to start');
    String s = await doOne();
    await doTwo(s);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: FutureBuilder(
          future: doMethods(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  EntryItem(data[index]),
              itemCount: data.length,
            );
          },
        )
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, this.text);

  final String title;
  final String text;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'How to dispose/recycle',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco '
        'laborisnisiutaliquip ex ea commodo consequat. Duis aute irure dolor '
        'in reprehenderit in voluptate velit esse cillum dolore eu fugiat '
        'nulla pariatur. Excepteur sint occaecat cupidatat non proident, '
        'sunt in culpa qui officia deserunt mollit anim id est laborum.',
  ),
  Entry(
    'Alternatives',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco '
        'laborisnisiutaliquip ex ea commodo consequat. Duis aute irure dolor '
        'in reprehenderit in voluptate velit esse cillum dolore eu fugiat '
        'nulla pariatur. Excepteur sint occaecat cupidatat non proident, '
        'sunt in culpa qui officia deserunt mollit anim id est laborum.',
  )
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.text.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: [Text(root.text)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample());
}