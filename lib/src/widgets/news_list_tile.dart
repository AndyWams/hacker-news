import 'package:flutter/material.dart';
// import 'package:news/src/screens/news_detail.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                blurRadius: 3,
                spreadRadius: 0.5,
                offset: Offset(
                  0.0,
                  4.0,
                ),
              )
            ],
          ),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/${item.id}');
            },
            title: Text(
              item.title,
              style: TextStyle(
                color: Colors.lightBlue[200],
              ),
            ),
            subtitle: Text('${item.score} points'),
            trailing: Column(
              children: <Widget>[
                Icon(Icons.comment),
                SizedBox(height: 10),
                Text('${item.descendants}'),
              ],
            ),
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
