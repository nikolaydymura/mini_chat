import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../cubits/user_cubit/user_cubit.dart';
import '../module/di_root.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget implements AutoRouteWrapper {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: registry.get<UserCubit>()..load(),
      child: this,
    );
  }
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat.yMMMd();

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    final userProfile = context.read<UserCubit>().state.userProfile;
    _firstNameController.text = userProfile?.firstName ?? '';
    _lastNameController.text = userProfile?.lastName ?? '';
    _selectedDate = userProfile?.dateOfBirth;
    _dateOfBirthController.text = _selectedDate != null
        ? _dateFormatter.format(_selectedDate!)
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              context.read<UserCubit>().updateProfile(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                dateOfBirth: _selectedDate,
              );
              context.pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            InkWell(
              radius: 48,
              onTap: () async {
                final picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  context.read<UserCubit>().updateProfilePhoto(image.path);
                }
              },
              child: CircleAvatar(
                radius: 48,
                child: Text(
                  context
                          .read<UserCubit>()
                          .state
                          .userProfile
                          ?.firstName
                          ?.substring(0, 1)
                          .toUpperCase() ??
                      '',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _dateOfBirthController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
              readOnly: true,
              onTap: () async {
                final newDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: _selectedDate,
                  lastDate: DateTime.now().subtract(Duration(days: 365 * 14)),
                );
                if (newDate != null) {
                  _selectedDate = newDate;
                  _dateOfBirthController.text = _dateFormatter.format(newDate);
                } else {
                  _selectedDate = null;
                  _dateOfBirthController.text = '';
                }
                setState(() {});
              },
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                context.read<UserCubit>().logout();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
