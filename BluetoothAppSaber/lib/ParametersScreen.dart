import 'package:flutter/material.dart';
import './crc.dart';

List identifiant(String id) {
  List<int> identifiant = [];
  if (id == 'couleurdusabre') {
    identifiant = [0x1B];
  }
  if (id == 'couleurduchoc1') {
    identifiant = [0x1E];
  }
  if (id == 'couleurduchoc2') {
    identifiant = [0x1E];
  }
  return identifiant;
}

List typeofid(String type) {
  List<int> typeofid = [];
  if (type == 'write') {
    typeofid = [0x01];
  }
  if (type == 'read') {
    typeofid = [0x02];
  }
  return typeofid;
}

List datatosend(String typeofdata, Color couleurchosie) {
  List<int> datatosendlist = [];
  if (typeofdata == 'couleur') {
    Color couleurcho = couleurchosie;
    print(couleurcho.value);
    //datatosendlist = couleur(data);
  }
  return datatosendlist;
}

List rgb(int rouge, vert, bleu) {
  List<int> rgblist = [bleu, vert, rouge, 0];
  return rgblist;
}

List trame(String type, id, datatype, Color couleurchoisie) {
  List<int> idlist = [];
  List<int> typeofidlist = [];
  List<int> datalist = [];
  List<int> crclist = [];

  typeofidlist = typeofid(type);
  idlist = identifiant(id);
  datalist = datatosend(datatype, couleurchoisie);

  //Manipulation pour extraire le RGB
  Color color = couleurchoisie;
  print(color.value);
  int hexacouleur = color.value - 0xFF000000;
  print(hexacouleur);
  //int couleurvalue = color.value << 8;
  //print(couleurvalue); //extraire la transparence
  //int bleu = (hexacouleur % 256);
  int bleu = hexacouleur & 0xFF;
  //int vert = ((hexacouleur - bleu) ~/ 256) % 256;
  int vert = (hexacouleur >> 8) & 0xFF;
  //int rouge = ((hexacouleur - bleu) ~/ 256) ~/ 256;
  int rouge = (color.value >> 16) & 0xFF;
  datalist = [bleu, vert, rouge, 0]; //renvoi de la couleur

  List<int> trameinitiale =
      [idlist, typeofidlist, datalist].expand((x) => x).toList();
  print('trameinit $trameinitiale');
  crclist = crc(trameinitiale);

  List<int> tramefinale =
      [crclist, idlist, typeofidlist, datalist].expand((x) => x).toList();
  return tramefinale;
}
