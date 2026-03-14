import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/media_providers.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../controllers/jobs_controller.dart';

class JobUpdateScreen extends ConsumerStatefulWidget {
  const JobUpdateScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<JobUpdateScreen> createState() => _JobUpdateScreenState();
}

class _JobUpdateScreenState extends ConsumerState<JobUpdateScreen> {
  final _notesController = TextEditingController();

  String _status = 'in_progress';
  String? _imagePath;
  bool _isSaving = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    final path = await ref
        .read(imageCaptureServiceProvider)
        .captureAndStoreImage();
    if (!mounted || path == null) {
      return;
    }

    setState(() => _imagePath = path);
  }

  Future<void> _saveUpdate() async {
    setState(() => _isSaving = true);

    await ref
        .read(jobsControllerProvider.notifier)
        .submitUpdate(
          jobId: widget.jobId,
          note: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
          status: _status,
          imagePath: _imagePath,
        );

    if (!mounted) {
      return;
    }

    setState(() => _isSaving = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Update')),
      body: ListView(
        padding: AppSpacing.paddingAllLg,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _status,
            decoration: const InputDecoration(labelText: 'Status'),
            items: const [
              DropdownMenuItem(
                value: 'in_progress',
                child: Text('In Progress'),
              ),
              DropdownMenuItem(value: 'completed', child: Text('Completed')),
              DropdownMenuItem(value: 'on_hold', child: Text('On Hold')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _status = value);
              }
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _notesController,
            label: 'Notes',
            hint: 'Add progress notes',
            maxLines: 4,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: _captureImage,
            icon: const Icon(Icons.camera_alt),
            label: Text(_imagePath == null ? 'Capture Image' : 'Retake Image'),
          ),
          if (_imagePath != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Stored image: $_imagePath',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: AppSpacing.xxl),
          PrimaryButton(
            label: 'Save Update',
            onPressed: _saveUpdate,
            isLoading: _isSaving,
          ),
        ],
      ),
    );
  }
}
