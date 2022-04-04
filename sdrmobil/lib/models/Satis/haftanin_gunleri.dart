
import 'package:flutter/material.dart';
import 'package:sdrmobil/models/Cari/cari_rut.dart';

class HaftaninGunleri {
  final String gun;
  final int gunSira;
  final List<CariRut> contents;  
  final IconData icon;

  HaftaninGunleri(this.gun, this.gunSira, this.contents, this.icon);
}