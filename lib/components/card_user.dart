import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_teste/firestore.dart';
import 'package:fb_teste/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

import '../user.dart';

class CardUser extends StatefulWidget {
  final User user;
  final Function delete;
  final Function atualizar;
  final Function bsUpdate;
  const CardUser(
      {super.key,
      required this.user,
      required this.delete,
      required this.atualizar,
      required this.bsUpdate});

  @override
  State<CardUser> createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.brown[300], borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //informações do usuario
            Container(
              alignment: Alignment.centerLeft,
              //decoration: const BoxDecoration(color: Colors.black12),
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.user.name}, ${widget.user.age} anos",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Create: ${widget.user.createOn}",
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            //botoes
            IconButton(
                color: Colors.green,
                onPressed: () {
                  debugPrint("clicou p editar ${widget.user.id}");
                  widget.bsUpdate(
                      widget.user.id, widget.user.name, widget.user.age);
                },
                icon: const Icon(
                  Icons.edit,
                )),
            IconButton(
                color: Colors.red,
                onPressed: () {
                  debugPrint("clicou p excluir ${widget.user.id}");
                  widget.delete(widget.user.id);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
