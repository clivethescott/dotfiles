/**
 * Medical Records System (MRS)
 * ---------------------------------------------------------------------
 * Copyright (C) 2017 - 2021 Ministry of Health and Child Care (Zimbabwe)
 * ---------------------------------------------------------------------
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:ehr_mobile/view/widgets/patient_appbar.dart';
import 'package:flutter/material.dart';
import 'package:ehr_mobile/repository/person_repository.dart';
import 'package:ehr_mobile/model/person.dart';

import 'package:ehr_mobile/view/widgets/main_appbar_title.dart';
import 'package:ehr_mobile/view/widgets/appbar_background.dart';

class MenuScreen extends StatefulWidget {
  final String visitId;
  MenuScreen(this.visitId);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Person person;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _loadData);
  }

  Future<void> _loadPerson() async {
    final response = await findPersonByVisit(widget.visitId);
    setState(() {
      this.person = response;
    });
  }

  Future<void> _loadData() async {
    await _loadPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const AppBarBackground(),
          const MainAppBarTitle(),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: const Text(
                      'Page Title',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                  ),
                  PatientAppBar(patient: person),
                  Expanded(
                    child: Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Placeholder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
