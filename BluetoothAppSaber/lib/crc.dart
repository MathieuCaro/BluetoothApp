import 'package:crclib/catalog.dart';

List crc(List<int> crc) {
  List<int> crcfinal = []; //yo
  final crcstring = Crc16Arc().convert(crc).toString();
  int crcint = int.parse(crcstring);
  int hexacrc1 = crcint % 256;
  int hexacrc2 = (crcint - hexacrc1) ~/ 256;
  crcfinal = [hexacrc1, hexacrc2];
  return crcfinal;
}
