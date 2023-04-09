import 'package:flutter/material.dart';

import '../../../../common/ui/app_colors.dart';

class NumberToWordsConverterDrawer extends StatelessWidget {
  const NumberToWordsConverterDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
            ),
            child: Text(
              'Number to Words Converter App',
              style: theme.textTheme.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
          ListTile(
            title: const Text('App Info'),
            onTap: () async {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('About App'),
                    content: const Text(
                      'This is a Number to Words converter app. Created by @zharfan104',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
