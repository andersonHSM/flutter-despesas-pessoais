import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    Key key,
    @required this.transaction,
    @required this.mediaQuery,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final void Function(String p1) deleteTransaction;

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('R\$ ${widget.transaction.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.transaction.date),
        ),
        trailing: widget.mediaQuery.size.width > 400
            ? FlatButton.icon(
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
                textColor: Theme.of(context).errorColor,
                icon: Icon(
                  Icons.delete,
                ),
                label: Text('Excluir'),
              )
            : IconButton(
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
              ),
      ),
    );
  }
}
