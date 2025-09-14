import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class UploadComplaintScreen extends StatefulWidget {
  const UploadComplaintScreen({super.key});

  @override
  State<UploadComplaintScreen> createState() => _UploadComplaintScreenState();
}

class _UploadComplaintScreenState extends State<UploadComplaintScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _media;
  bool get _isVideo => _media != null && _media!.path.toLowerCase().endsWith('.mp4');

  VideoPlayerController? _videoController;
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  bool _isUploading = false;
  bool _permissionsDenied = false;
  bool _isGeneratingDescription = false;
  bool _isHoveringAutoGenerate = false;
  Position? _currentPosition;
  String _locationString = 'Getting location...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _desc.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _ensurePermissions() async {
    final statuses = await [Permission.camera, Permission.photos, Permission.storage, Permission.locationWhenInUse].request();
    final denied = statuses.values.any((s) => s.isDenied || s.isPermanentlyDenied || s.isRestricted);
    setState(() => _permissionsDenied = denied);
  }

  Future<void> _pickFromCamera() async {
    await _ensurePermissions();
    if (_permissionsDenied) return;
    final file = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1920, imageQuality: 85);
    if (file != null) {
      await _setMedia(file);
    }
  }

  Future<void> _pickFromGallery() async {
    await _ensurePermissions();
    if (_permissionsDenied) return;
    final file = await _picker.pickMedia();
    if (file != null) {
      await _setMedia(file);
    }
  }

  Future<void> _setMedia(XFile file) async {
    _videoController?.dispose();
    _videoController = null;
    setState(() => _media = file);
    if (file.path.toLowerCase().endsWith('.mp4')) {
      final controller = VideoPlayerController.file(File(file.path));
      await controller.initialize();
      controller.setLooping(true);
      setState(() => _videoController = controller);
      unawaited(controller.play());
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final has = await Geolocator.isLocationServiceEnabled();
      if (!has) {
        setState(() => _locationString = 'Location services disabled');
        return;
      }
      
      final perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationString = 'Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, Lng: ${_currentPosition!.longitude.toStringAsFixed(4)}';
      });
    } catch (e) {
      setState(() => _locationString = 'Unable to get location');
    }
  }

  Future<void> _generateDescription() async {
    setState(() => _isGeneratingDescription = true);
    
    // Mock AI API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _isGeneratingDescription = false;
        if (_media != null) {
          _desc.text = 'AI-generated description based on the image and location:\n\n'
              'Issue detected: Infrastructure problem\n'
              'Location: ${_locationString}\n'
              'Severity: Medium\n'
              'Description: This appears to be a municipal infrastructure issue that requires attention. '
              'The problem is visible in the provided media and is located at the specified coordinates.';
        } else {
          _desc.text = 'AI-generated description based on location:\n\n'
              'Issue detected: General municipal concern\n'
              'Location: ${_locationString}\n'
              'Severity: Unknown\n'
              'Description: This is a general description generated based on your current location. '
              'Please add more specific details about the issue you\'re reporting.';
        }
      });
    }
  }

  Future<void> _generatePDF() async {
    if (_media == null) return;
    
    setState(() => _isUploading = true);
    
    try {
      final pdf = pw.Document();
      
      // Add image to PDF
      final imageBytes = await File(_media!.path).readAsBytes();
      final image = pw.MemoryImage(imageBytes);
      
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Municipal Complaint Report',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Location: $_locationString'),
                pw.SizedBox(height: 10),
                pw.Text('Description:'),
                pw.SizedBox(height: 5),
                pw.Text(_desc.text),
                pw.SizedBox(height: 10),
                if (_notes.text.isNotEmpty) ...[
                  pw.Text('Additional Notes:'),
                  pw.SizedBox(height: 5),
                  pw.Text(_notes.text),
                  pw.SizedBox(height: 10),
                ],
                pw.Text('Media:'),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Image(
                    image,
                    width: 300,
                    height: 200,
                    fit: pw.BoxFit.cover,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Generated on: ${DateTime.now().toString()}',
                  style: pw.TextStyle(fontSize: 10),
                ),
              ],
            );
          },
        ),
      );
      
      // Save PDF
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/complaint_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());
      
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF generated successfully: ${file.path}'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () {
                // In a real app, you would open the PDF file
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PDF saved to device')),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating PDF: $e')),
        );
      }
    }
  }

  void _removeMedia() {
    setState(() {
      _media = null;
      _videoController?.dispose();
      _videoController = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Upload Complaint'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Section - Camera and Gallery Boxes
                _buildMediaSelectionBoxes(),
                const SizedBox(height: 24),
                
                // Middle Section - Description
                _buildDescriptionSection(),
                const SizedBox(height: 20),
                
                // Location Section
                _buildLocationSection(),
                const SizedBox(height: 100), // Space for bottom button
              ],
            ),
          ),
          
          // Bottom Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _buildNextButton(),
          ),
          
          // Permissions Overlay
          if (_permissionsDenied)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.privacy_tip, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        const Text(
                          'Permissions Required',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Camera and location permissions are needed to upload complaints.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await openAppSettings();
                            setState(() => _permissionsDenied = false);
                          },
                          child: const Text('Open Settings'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMediaSelectionBoxes() {
    if (_media != null) {
      // Show media preview when selected
      return Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1976D2), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1976D2).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _isVideo && _videoController != null
                  ? VideoPlayer(_videoController!)
                  : Image.file(File(_media!.path), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _pickFromCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _pickFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _removeMedia,
                icon: const Icon(Icons.delete),
                label: const Text('Remove'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
    
    // Show selection boxes when no media selected
    return Row(
      children: [
        // Camera Box
        Expanded(
          child: GestureDetector(
            onTap: _pickFromCamera,
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1976D2), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1976D2).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Gallery Box
        Expanded(
          child: GestureDetector(
            onTap: _pickFromGallery,
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF80DEEA), Color(0xFFE91E63)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1976D2), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1976D2).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.photo_library,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description (Optional)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // Enhanced ChatGPT-style text field
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Text input area
                  TextField(
                    controller: _desc,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: 'Describe the issue in detail...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    ),
                  ),
                  // Bottom row with buttons and icons
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      children: [
                        // Auto Generate button
                        MouseRegion(
                            onEnter: (_) => setState(() => _isHoveringAutoGenerate = true),
                            onExit: (_) => setState(() => _isHoveringAutoGenerate = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              transform: Matrix4.identity()..scale(_isHoveringAutoGenerate ? 1.05 : 1.0),
                              child: ElevatedButton(
                                onPressed: _isGeneratingDescription ? null : _generateDescription,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: _isHoveringAutoGenerate
                                          ? [const Color(0xFFDC2626), const Color(0xFFF87171)]
                                          : [const Color(0xFFE53E3E), const Color(0xFFFC8181)],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: _isHoveringAutoGenerate
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFFE53E3E).withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_isGeneratingDescription)
                                        const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      else
                                        const Icon(Icons.auto_awesome, size: 16),
                                      const SizedBox(width: 6),
                                      Text(
                                        _isGeneratingDescription ? 'Generating...' : 'Auto Generate',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const Spacer(),
                        // Mic icon
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Implement voice recording functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Voice recording feature coming soon!')),
                              );
                            },
                            icon: const Icon(Icons.mic, size: 20, color: Colors.grey),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Upload/Send icon
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1976D2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Implement send/upload functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Send functionality coming soon!')),
                              );
                            },
                            icon: const Icon(Icons.send, size: 20, color: Colors.white),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFF1976D2), size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Location (Optional)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.gps_fixed, size: 20, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _locationString,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    onPressed: _getCurrentLocation,
                    icon: const Icon(Icons.refresh, size: 20, color: Color(0xFF1976D2)),
                    tooltip: 'Refresh location',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1976D2).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isUploading ? null : _generatePDF,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: _isUploading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Generating PDF...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward, size: 24),
                  SizedBox(width: 8),
                  Text('Next', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}