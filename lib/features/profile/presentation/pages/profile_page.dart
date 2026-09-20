import 'package:bloc_cubit_tailored_eats/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => sl<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));

            context.read<ProfileCubit>().loadProfile();
          }

          if (state is ProfileFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const AppLoader();
          }

          if (state is ProfileFailure) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ProfileCubit>().loadProfile();
              },
            );
          }

          final profile = switch (state) {
            ProfileLoaded(:final profile) => profile,
            ProfileActionLoading(:final profile) => profile,
            _ => null,
          };

          if (profile == null) {
            return const AppLoader();
          }

          return RefreshIndicator(
            onRefresh: () {
              return context.read<ProfileCubit>().loadProfile();
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _ProfileHeader(
                  name: profile.name.isNotEmpty
                      ? profile.name
                      : '${profile.firstName} ${profile.lastName}'.trim(),
                  email: profile.email,
                  imageUrl: profile.profileImage.isNotEmpty
                      ? '${AppConstants.baseUrl}${profile.profileImage}'
                      : profile.image,
                ),
                const SizedBox(height: 24),
                _Section(
                  title: 'Personal Information',
                  children: [
                    _InfoTile(label: 'First Name', value: profile.firstName),
                    _InfoTile(label: 'Last Name', value: profile.lastName),
                    _InfoTile(label: 'Email', value: profile.email),
                    _InfoTile(label: 'Gender', value: profile.gender),
                    _InfoTile(label: 'Age', value: profile.age.toString()),
                  ],
                ),
                const SizedBox(height: 16),
                _Section(
                  title: 'Body Information',
                  children: [
                    _InfoTile(
                      label: 'Height',
                      value: profile.height.toString(),
                    ),
                    _InfoTile(
                      label: 'Weight',
                      value: profile.weight.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _Section(
                  title: 'Nutrition & Goals',
                  children: [
                    _InfoTile(
                      label: 'Activity Level',
                      value: profile.activityLevel,
                    ),
                    _InfoTile(label: 'Food Vibe', value: profile.foodVibe),
                    _InfoTile(label: 'Main Goal', value: profile.mainGoal),
                    _InfoTile(label: 'Result', value: profile.result),
                    _InfoTile(label: 'Training', value: profile.training),
                    _InfoTile(
                      label: 'Daily Calories',
                      value: profile.calorie.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _Section(
                  title: 'Account',
                  children: [
                    _InfoTile(
                      label: 'Subscription Plan',
                      value: profile.subscriptionPlan,
                    ),
                    _InfoTile(
                      label: 'Two-Factor Authentication',
                      value: profile.isTwoFactor ? 'Enabled' : 'Disabled',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  final String name;
  final String email;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
          child: imageUrl.isEmpty ? const Icon(Icons.person, size: 48) : null,
        ),
        const SizedBox(height: 12),
        Text(
          name.isNotEmpty ? name : 'User',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        if (email.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(email, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '-',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
