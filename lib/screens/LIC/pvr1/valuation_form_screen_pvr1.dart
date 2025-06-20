// lib/valuation_form_screen_pvr1.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import for location
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'valuation_data_model_pvr1.dart';
import 'pdf_generator_pvr1.dart';

class ValuationFormScreenPVR1 extends StatefulWidget {
  const ValuationFormScreenPVR1({super.key});
  @override
  _ValuationFormScreenPVR1State createState() => _ValuationFormScreenPVR1State();
}

class _ValuationFormScreenPVR1State extends State<ValuationFormScreenPVR1> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  // Use the new ValuationImage class to store images with their location
  final List<ValuationImage> _valuationImages = [];

  // --- ALL CONTROLLERS AND STATE VARIABLES ---
  final _valuerNameCtrl = TextEditingController(text: 'VIGNESH S');
  final _valuerCodeCtrl = TextEditingController(text: 'TVV0001');
  DateTime _inspectionDate = DateTime(2025, 5, 20);
  final _fileNoCtrl = TextEditingController(text: '5002050002876');
  final _applicantNameCtrl = TextEditingController(text: 'SUBHA A');
  final _ownerNameCtrl = TextEditingController(text: 'SUBHA A');
  final _documentsPerusedCtrl = TextEditingController(text: 'Minor');
  final _propertyLocationCtrl = TextEditingController(text: '121 ARES RS N 277 16 3 BLDG NO 15 66 MARANALLOOR VILLAGE KATTAKADA TALUK RS N 277 16 3 MARANALLOOR MARANALLOOR THIRUVANANTHAPURAM 695501');
  bool _addressTallies = true;
  bool _locationSketchVerified = true;
  final _surroundingDevCtrl = TextEditingController(text: 'Middle Class');
  bool _basicAmenitiesAvailable = true;
  final _negativesToLocalityCtrl = TextEditingController(text: 'NIL');
  final _favorableConsiderationsCtrl = TextEditingController(text: 'NIL');
  final _nearbyLandmarkCtrl = TextEditingController(text: 'RUSSELPURAM');
  final _otherFeaturesCtrl = TextEditingController(text: 'NIL');
  final _northBoundaryCtrl = TextEditingController(text: 'PROPERTY OF GOPAN');
  final _northDimCtrl = TextEditingController(text: '1460 CM');
  final _southBoundaryCtrl = TextEditingController(text: 'PROPERTY OF AYAPPAN NAIR');
  final _southDimCtrl = TextEditingController(text: '1400 CM');
  final _eastBoundaryCtrl = TextEditingController(text: 'PANCHAYATH ROAD HAVING CAR ACCESS');
  final _eastDimCtrl = TextEditingController(text: '850 CM');
  final _westBoundaryCtrl = TextEditingController(text: 'PROPERTY OF AYAPPAN NAIR');
  final _westDimCtrl = TextEditingController(text: '850 CM');
  final _totalExtent1Ctrl = TextEditingController(text: '1.21');
  final _totalExtent2Ctrl = TextEditingController(text: '2.98');
  bool _boundariesTally = true;
  final _existingLandUseCtrl = TextEditingController(text: 'GROUND FLOOR TO BE RENOVATED HAVING A PLINTH AREA OF 393 SQFT');
  final _proposedLandUseCtrl = TextEditingController(text: 'EXTENSION OF GF AND ADDITIONAL FF HAVING A TOTAL PLINTH AREA OF 524 SQFT');
  bool _naPermissionRequired = false;
  final _approvalNoCtrl = TextEditingController(text: 'A1/BA/134572/2025 DATED 26-04-2025');
  final _validityPeriodCtrl = TextEditingController(text: 'VALID UP TO 25-04-2030');
  bool _isValidityExpiredRenewed = false;
  final _approvalAuthorityCtrl = TextEditingController(text: 'MARANALLOOR GRAMA PANCHAYATH');
  final _approvedGfCtrl = TextEditingController(text: '65');
  final _approvedFfCtrl = TextEditingController(text: '459');
  final _approvedSfCtrl = TextEditingController(text: '0');
  final _actualGfCtrl = TextEditingController(text: '65');
  final _actualFfCtrl = TextEditingController(text: '459');
  final _actualSfCtrl = TextEditingController(text: '0');
  final _estimateCostCtrl = TextEditingController(text: '1193150');
  final _costPerSqFtCtrl = TextEditingController(text: '2277 per sqft');
  bool _isEstimateReasonable = true;
  final _marketabilityCtrl = TextEditingController(text: 'Good');
  final _fsiCtrl = TextEditingController(text: '0.7');
  final _dwellingUnitsCtrl = TextEditingController(text: '1');
  bool _isConstructionAsPerPlan = true;
  final _deviationsCtrl = TextEditingController(text: 'NIL');
  final _deviationNatureCtrl = TextEditingController(text: 'Minor');
  bool _revisedApprovalNecessary = false;
  final _worksCompletedPercentageCtrl = TextEditingController(text: '0');
  final _worksCompletedValue=TextEditingController(text: '0');
  bool _adheresToSafety = true;
  bool _highTensionImpact = false;
  final _plinthApprovedCtrl = TextEditingController(text: '524');
  final _plinthActualCtrl = TextEditingController(text: '524');
  final _landValueAppCtrl = TextEditingController(text: '1043000');
  final _landValueGuideCtrl = TextEditingController(text: '47916');
  final _landValueMarketCtrl = TextEditingController(text: '1043000');
  final _buildingStageValueAppCtrl = TextEditingController(text: '0');
  final _buildingCompletionValueCtrl = TextEditingController(text: '2236150');
  final _marketValueSourceCtrl = TextEditingController(text: 'LOCAL MARKET ENQUIRY');
  final _buildingUsageCtrl = TextEditingController(text: 'RESIDENTIAL');
  final _recBackgroundCtrl = TextEditingController(text: 'SUBMITTED DOCUMENTS');
  final _recSourcesCtrl = TextEditingController(text: 'LOCAL MARKET ENQUIRY');
  final _recProceduresCtrl = TextEditingController(text: 'MARKET APPROACH');
  final _recMethodologyCtrl = TextEditingController(text: 'COMPARISON METHOD AND COST OF CONSTRUCTION');
  final _recFactorsCtrl = TextEditingController(text: 'AMENITIES AND ACCESSIBILITY');
  final _stageOfConstructionCtrl = TextEditingController(text: 'NOT YET STARTED');
  final _progressPercentageCtrl = TextEditingController(text: '0');
  final _certificatePlaceCtrl = TextEditingController(text: 'THIRUVANANTHAPURAM');
  final _annexLandAreaCtrl = TextEditingController(text: '2.98');
  final _annexLandUnitRateMarketCtrl = TextEditingController(text: '350000');
  final _annexLandUnitRateGuideCtrl = TextEditingController(text: '39600');
  final _annexGfAreaCtrl = TextEditingController(text: '393');
  final _annexGfUnitRateMarketCtrl = TextEditingController(text: '1000');
  final _annexGfUnitRateGuideCtrl = TextEditingController(text: '1000');
  final _annexFfAreaCtrl = TextEditingController(text: '0');
  final _annexFfUnitRateMarketCtrl = TextEditingController(text: '0');
  final _annexFfUnitRateGuideCtrl = TextEditingController(text: '0');
  final _annexSfAreaCtrl = TextEditingController(text: '0');
  final _annexSfUnitRateMarketCtrl = TextEditingController(text: '0');
  final _annexSfUnitRateGuideCtrl = TextEditingController(text: '0');
  final _annexAmenitiesMarketCtrl = TextEditingController(text: '0');
  final _annexAmenitiesGuideCtrl = TextEditingController(text: '0');
  final _annexYearOfConstructionCtrl = TextEditingController(text: '2025');
  final _annexBuildingAgeCtrl = TextEditingController(text: '15 AND 35 YEARS');
  final _natureOflandUse=TextEditingController(text: 'Others');
  final _buildingStageValueGuide=TextEditingController(text: '0');
  final _buildingStageValueMarket=TextEditingController(text:'0');
  // --- LOCATION AND IMAGE PICKER LOGIC ---

  Future<void> _getCurrentLocation(int imageIndex) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled. Please enable them.")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied.")),
        );
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permissions are permanently denied, we cannot request permissions.")),
      );
      return;
    } 

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _valuationImages[imageIndex].latitude = position.latitude.toString();
        _valuationImages[imageIndex].longitude = position.longitude.toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error getting location: $e")),
      );
    }
  }

  // Inside _ValuationFormScreenPVR1State

Future<void> _pickImage(ImageSource source) async {
  try {
    if (source == ImageSource.gallery) {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        for (var file in pickedFiles) {
          // Read the bytes from the picked file
          final bytes = await file.readAsBytes();
          // Add the bytes to your list, not the file object
          _valuationImages.add(ValuationImage(imageFile: bytes));
        }
        setState(() {}); // Update the UI
      }
    } else {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _valuationImages.add(ValuationImage(imageFile: bytes));
        });
      }
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to pick images: $e')),
    );
  }
}

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _generatePdf() {
    if (_formKey.currentState!.validate()) {
      final data = ValuationDataPVR1(
        worksCompletedValue: _worksCompletedValue.text,
        buildingStageValueMarket: _buildingStageValueMarket.text,
        buildingStageValueGuide: _buildingStageValueGuide.text,
        natureOfLandUse: _natureOflandUse.text,
        valuerName: _valuerNameCtrl.text, valuerCode: _valuerCodeCtrl.text, inspectionDate: _inspectionDate,
        fileNo: _fileNoCtrl.text, applicantName: _applicantNameCtrl.text, ownerName: _ownerNameCtrl.text, documentsPerused: _documentsPerusedCtrl.text, propertyLocation: _propertyLocationCtrl.text,
        addressTallies: _addressTallies, locationSketchVerified: _locationSketchVerified,
        surroundingDev: _surroundingDevCtrl.text, negativesToLocality: _negativesToLocalityCtrl.text, favorableConsiderations: _favorableConsiderationsCtrl.text, nearbyLandmark: _nearbyLandmarkCtrl.text, otherFeatures: _otherFeaturesCtrl.text,
        basicAmenitiesAvailable: _basicAmenitiesAvailable,
        northBoundary: _northBoundaryCtrl.text, southBoundary: _southBoundaryCtrl.text, eastBoundary: _eastBoundaryCtrl.text, westBoundary: _westBoundaryCtrl.text,
        northDim: _northDimCtrl.text, southDim: _southDimCtrl.text, eastDim: _eastDimCtrl.text, westDim: _westDimCtrl.text,
        totalExtent1: _totalExtent1Ctrl.text, totalExtent2: _totalExtent2Ctrl.text, boundariesTally: _boundariesTally,
        existingLandUse: _existingLandUseCtrl.text, proposedLandUse: _proposedLandUseCtrl.text, naPermissionRequired: _naPermissionRequired,
        approvalNo: _approvalNoCtrl.text, validityPeriod: _validityPeriodCtrl.text, approvalAuthority: _approvalAuthorityCtrl.text, isValidityExpiredRenewed: _isValidityExpiredRenewed,
        approvedGf: _approvedGfCtrl.text, approvedFf: _approvedFfCtrl.text, approvedSf: _approvedSfCtrl.text,
        actualGf: _actualGfCtrl.text, actualFf: _actualFfCtrl.text, actualSf: _actualSfCtrl.text,
        estimateCost: _estimateCostCtrl.text, costPerSqFt: _costPerSqFtCtrl.text, isEstimateReasonable: _isEstimateReasonable,
        marketability: _marketabilityCtrl.text, fsi: _fsiCtrl.text, dwellingUnits: _dwellingUnitsCtrl.text,
        isConstructionAsPerPlan: _isConstructionAsPerPlan, deviations: _deviationsCtrl.text, deviationNature: _deviationNatureCtrl.text, revisedApprovalNecessary: _revisedApprovalNecessary,
        worksCompletedPercentage: _worksCompletedPercentageCtrl.text, adheresToSafety: _adheresToSafety, highTensionImpact: _highTensionImpact,
        plinthApproved: _plinthApprovedCtrl.text, plinthActual: _plinthActualCtrl.text,
        landValueApp: _landValueAppCtrl.text, landValueGuide: _landValueGuideCtrl.text, landValueMarket: _landValueMarketCtrl.text,
        buildingStageValueApp: _buildingStageValueAppCtrl.text, buildingCompletionValue: _buildingCompletionValueCtrl.text,
        marketValueSource: _marketValueSourceCtrl.text, buildingUsage: _buildingUsageCtrl.text,
        recBackground: _recBackgroundCtrl.text, recSources: _recSourcesCtrl.text, recProcedures: _recProceduresCtrl.text, recMethodology: _recMethodologyCtrl.text, recFactors: _recFactorsCtrl.text,
        stageOfConstruction: _stageOfConstructionCtrl.text, progressPercentage: _progressPercentageCtrl.text,
        certificateDate: DateTime.now(), certificatePlace: _certificatePlaceCtrl.text,
        annexLandArea: _annexLandAreaCtrl.text, annexLandUnitRateMarket: _annexLandUnitRateMarketCtrl.text, annexLandUnitRateGuide: _annexLandUnitRateGuideCtrl.text,
        annexGfArea: _annexGfAreaCtrl.text, annexGfUnitRateMarket: _annexGfUnitRateMarketCtrl.text, annexGfUnitRateGuide: _annexGfUnitRateGuideCtrl.text,
        annexFfArea: _annexFfAreaCtrl.text, annexFfUnitRateMarket: _annexFfUnitRateMarketCtrl.text, annexFfUnitRateGuide: _annexFfUnitRateGuideCtrl.text,
        annexSfArea: _annexSfAreaCtrl.text, annexSfUnitRateMarket: _annexSfUnitRateMarketCtrl.text, annexSfUnitRateGuide: _annexSfUnitRateGuideCtrl.text,
        annexAmenitiesMarket: _annexAmenitiesMarketCtrl.text, annexAmenitiesGuide: _annexAmenitiesGuideCtrl.text,
        annexYearOfConstruction: _annexYearOfConstructionCtrl.text, annexBuildingAge: _annexBuildingAgeCtrl.text,
        images: _valuationImages,
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PreviewScreenPVR1(data: data)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PVR 1 - House Construction')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSection(title: 'Header', initiallyExpanded: true, children: [
              TextFormField(controller: _valuerNameCtrl, decoration: const InputDecoration(labelText: 'Name of the Panel Valuer')),
              TextFormField(controller: _valuerCodeCtrl, decoration: const InputDecoration(labelText: 'Code No.')),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Date of Inspection"),
                subtitle: Text(DateFormat('dd-MM-yyyy').format(_inspectionDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(context: context, initialDate: _inspectionDate, firstDate: DateTime(2000), lastDate: DateTime(2100));
                  if (picked != null) setState(() => _inspectionDate = picked);
                },
              ),
            ]),
            _buildSection(title: 'A. GENERAL', children: [
              TextFormField(controller: _fileNoCtrl, decoration: const InputDecoration(labelText: '1. File No.')),
              TextFormField(controller: _applicantNameCtrl, decoration: const InputDecoration(labelText: '2. Name of the Applicant')),
              TextFormField(controller: _ownerNameCtrl, decoration: const InputDecoration(labelText: '3. Name of the owner')),
              TextFormField(controller: _documentsPerusedCtrl, decoration: const InputDecoration(labelText: '4. Documents produced for perusal')),
              TextFormField(controller: _propertyLocationCtrl, decoration: const InputDecoration(labelText: '5. Location of the property'), maxLines: 4),
              SwitchListTile(title: const Text('6. Address tallies with site'), value: _addressTallies, onChanged: (v) => setState(() => _addressTallies = v)),
              SwitchListTile(title: const Text('7. Location Sketch Verified'), value: _locationSketchVerified, onChanged: (v) => setState(() => _locationSketchVerified = v)),
              TextFormField(controller: _surroundingDevCtrl, decoration: const InputDecoration(labelText: '8. Development of surrounding area')),
              SwitchListTile(title: const Text('9. Basic amenities available'), value: _basicAmenitiesAvailable, onChanged: (v) => setState(() => _basicAmenitiesAvailable = v)),
              TextFormField(controller: _negativesToLocalityCtrl, decoration: const InputDecoration(labelText: '10. Any negatives to the locality')),
              TextFormField(controller: _favorableConsiderationsCtrl, decoration: const InputDecoration(labelText: '11. Any favorable consideration')),
              TextFormField(controller: _nearbyLandmarkCtrl, decoration: const InputDecoration(labelText: '12. Details of the Nearby Landmark')),
              TextFormField(controller: _otherFeaturesCtrl, decoration: const InputDecoration(labelText: '13. Any other features')),
            ]),
            _buildSection(title: 'B. LAND', children: [
              TextFormField(controller: _northBoundaryCtrl, decoration: const InputDecoration(labelText: 'North Boundary')),
              TextFormField(controller: _northDimCtrl, decoration: const InputDecoration(labelText: 'North Dimension')),
              TextFormField(controller: _southBoundaryCtrl, decoration: const InputDecoration(labelText: 'South Boundary')),
              TextFormField(controller: _southDimCtrl, decoration: const InputDecoration(labelText: 'South Dimension')),
              TextFormField(controller: _eastBoundaryCtrl, decoration: const InputDecoration(labelText: 'East Boundary')),
              TextFormField(controller: _eastDimCtrl, decoration: const InputDecoration(labelText: 'East Dimension')),
              TextFormField(controller: _westBoundaryCtrl, decoration: const InputDecoration(labelText: 'West Boundary')),
              TextFormField(controller: _westDimCtrl, decoration: const InputDecoration(labelText: 'West Dimension')),
              TextFormField(controller: _totalExtent1Ctrl, decoration: const InputDecoration(labelText: 'Total Extent 1')),
              TextFormField(controller: _totalExtent2Ctrl, decoration: const InputDecoration(labelText: 'Total Extent 2')),
              SwitchListTile(title: const Text('2. Boundaries Tally with Drawing'), value: _boundariesTally, onChanged: (v) => setState(() => _boundariesTally = v)),
              TextFormField(controller: _natureOflandUse, decoration: const InputDecoration(labelText: 'Nature of Land Use')),
              TextFormField(controller: _existingLandUseCtrl, decoration: const InputDecoration(labelText: '3a. Existing Land Use'),maxLines: 4,),
              TextFormField(controller: _proposedLandUseCtrl, decoration: const InputDecoration(labelText: '3b. Proposed Land Use'), maxLines: 4),
              SwitchListTile(title: const Text('4. N.A. Permission Required'), value: _naPermissionRequired, onChanged: (v) => setState(() => _naPermissionRequired = v)),
            ]),
            _buildSection(title: 'C. BUILDINGS', children: [
              TextFormField(controller: _approvalNoCtrl, decoration: const InputDecoration(labelText: '1. Approval No./Planning Permit No/Building Permission No')),
              TextFormField(controller: _validityPeriodCtrl, decoration: const InputDecoration(labelText: '1.ii Period of validity')),
              SwitchListTile(title: const Text('1.iii If expired, is it renewed?'), value: _isValidityExpiredRenewed, onChanged: (v) => setState(() => _isValidityExpiredRenewed = v)),
              TextFormField(controller: _approvalAuthorityCtrl, decoration: const InputDecoration(labelText: '1.iv Approval authority')),
              TextFormField(controller: _approvedGfCtrl, decoration: const InputDecoration(labelText: '2.i Approved G.F. Area')),
              TextFormField(controller: _approvedFfCtrl, decoration: const InputDecoration(labelText: '2.i Approved F.F. Area')),
              TextFormField(controller: _approvedSfCtrl, decoration: const InputDecoration(labelText: '2.i Approved S.F. Area')),
              TextFormField(controller: _actualGfCtrl, decoration: const InputDecoration(labelText: '2.ii Actual G.F. Area')),
              TextFormField(controller: _actualFfCtrl, decoration: const InputDecoration(labelText: '2.ii Actual F.F. Area')),
              TextFormField(controller: _actualSfCtrl, decoration: const InputDecoration(labelText: '2.ii Actual S.F. Area')),
              TextFormField(controller: _estimateCostCtrl, decoration: const InputDecoration(labelText: '3.i Estimate Cost (Rs)')),
              TextFormField(controller: _costPerSqFtCtrl, decoration: const InputDecoration(labelText: '3.ii Cost per Sq ft')),
              SwitchListTile(title: const Text('3.iii Is estimate reasonable?'), value: _isEstimateReasonable, onChanged: (v) => setState(() => _isEstimateReasonable = v)),
              TextFormField(controller: _marketabilityCtrl, decoration: const InputDecoration(labelText: '4. Marketability')),
                   ]),
            _buildSection(title: 'D. INSPECTION', children: [
              TextFormField(controller: _plinthApprovedCtrl, decoration: const InputDecoration(labelText: 'Plinth/Built Up Area (Approved)')),
              TextFormField(controller: _plinthActualCtrl, decoration: const InputDecoration(labelText: 'Plinth/Built Up Area (Actual)')),
              TextFormField(controller: _fsiCtrl, decoration: const InputDecoration(labelText: 'F.S.I.')),
              TextFormField(controller: _dwellingUnitsCtrl, decoration: const InputDecoration(labelText: 'No. Of dwelling units')),
              SwitchListTile(title: const Text('Construction as per plan?'), value: _isConstructionAsPerPlan, onChanged: (v) => setState(() => _isConstructionAsPerPlan = v)),
              TextFormField(controller: _deviationsCtrl, decoration: const InputDecoration(labelText: 'Deviations')),
              TextFormField(controller: _deviationNatureCtrl, decoration: const InputDecoration(labelText: 'Deviation nature')),
              SwitchListTile(title: const Text('Revised approval necessary?'), value: _revisedApprovalNecessary, onChanged: (v) => setState(() => _revisedApprovalNecessary = v)),
              TextFormField(controller: _worksCompletedPercentageCtrl, decoration: const InputDecoration(labelText: 'Total works completed %')),
              TextFormField(controller: _worksCompletedValue, decoration: const InputDecoration(labelText: 'Total works value')),

              SwitchListTile(title: const Text('Adheres to Safety Specs?'), value: _adheresToSafety, onChanged: (v) => setState(() => _adheresToSafety = v)),
              SwitchListTile(title: const Text('High Tension Line Impact?'), value: _highTensionImpact, onChanged: (v) => setState(() => _highTensionImpact = v)),
       
            ]),
            _buildSection(title: 'E. TOTAL VALUE', children: [
              TextFormField(controller: _landValueAppCtrl, decoration: const InputDecoration(labelText: '1. Value of land (as per Application)')),
              TextFormField(controller: _landValueGuideCtrl, decoration: const InputDecoration(labelText: '1. Value of land (Guideline)')),
              TextFormField(controller: _landValueMarketCtrl, decoration: const InputDecoration(labelText: '1. Value of land (Market)')),
              TextFormField(controller: _buildingStageValueAppCtrl, decoration: const InputDecoration(labelText: '2. Stage value of building (Applicant)')),
              TextFormField(controller: _buildingStageValueAppCtrl, decoration: const InputDecoration(labelText: '2. Stage value of building (Guideline Value)')),
              TextFormField(controller: _buildingStageValueAppCtrl, decoration: const InputDecoration(labelText: '2. Stage value of building (Market Value)')),
              TextFormField(controller: _buildingCompletionValueCtrl, decoration: const InputDecoration(labelText: '4. Value of building on completion')),
              TextFormField(controller: _marketValueSourceCtrl, decoration: const InputDecoration(labelText: '5. Source for arriving at Market Value')),
              TextFormField(controller: _buildingUsageCtrl, decoration: const InputDecoration(labelText: '6. Usage of building')),
            ]),
            _buildSection(title: 'F. RECOMMENDATION', children: [
              TextFormField(controller: _recBackgroundCtrl, decoration: const InputDecoration(labelText: '1. Background information')),
              TextFormField(controller: _recSourcesCtrl, decoration: const InputDecoration(labelText: '2. Sources of information')),
              TextFormField(controller: _recProceduresCtrl, decoration: const InputDecoration(labelText: '3. Procedures adopted carrying out valuation')),
              TextFormField(controller: _recMethodologyCtrl, decoration: const InputDecoration(labelText: '4. Valuation methodology')),
              TextFormField(controller: _recFactorsCtrl, decoration: const InputDecoration(labelText: '5. Major factors that influenced the valuation')),
            ]),
            _buildSection(title: 'Stage of Construction (Table)', children: [
              TextFormField(controller: _stageOfConstructionCtrl, decoration: const InputDecoration(labelText: 'Stage of Construction')),
              TextFormField(controller: _progressPercentageCtrl, decoration: const InputDecoration(labelText: '% Progress')),
            ]),
            _buildSection(title: 'G. CERTIFICATE', children: [
              TextFormField(controller: _certificatePlaceCtrl, decoration: const InputDecoration(labelText: 'Station/Place')),
              
            ]),
            _buildSection(title: 'ANNEXURE (Valuation of Existing Building)', children: [
              TextFormField(controller: _annexLandAreaCtrl, decoration: const InputDecoration(labelText: 'Land Area')),
              TextFormField(controller: _annexLandUnitRateMarketCtrl, decoration: const InputDecoration(labelText: 'Land Unit Rate (Market)')),
              TextFormField(controller: _annexLandUnitRateGuideCtrl, decoration: const InputDecoration(labelText: 'Land Unit Rate (Guide)')),
              TextFormField(controller: _annexGfAreaCtrl, decoration: const InputDecoration(labelText: 'GF Area')),
              TextFormField(controller: _annexGfUnitRateMarketCtrl, decoration: const InputDecoration(labelText: 'GF Unit Rate (Market)')),
              TextFormField(controller: _annexGfUnitRateGuideCtrl, decoration: const InputDecoration(labelText: 'GF Unit Rate (Guide)')),
              TextFormField(controller: _annexFfAreaCtrl, decoration: const InputDecoration(labelText: 'FF Area')),
              TextFormField(controller: _annexFfUnitRateMarketCtrl, decoration: const InputDecoration(labelText: 'FF Unit Rate (Market)')),
              TextFormField(controller: _annexFfUnitRateGuideCtrl, decoration: const InputDecoration(labelText: 'FF Unit Rate (Guide)')),
              TextFormField(controller: _annexSfAreaCtrl, decoration: const InputDecoration(labelText: 'SF Area')),
              TextFormField(controller: _annexSfUnitRateMarketCtrl, decoration: const InputDecoration(labelText: 'SF Unit Rate (Market)')),
              TextFormField(controller: _annexSfUnitRateGuideCtrl, decoration: const InputDecoration(labelText: 'SF Unit Rate (Guide)')),
              TextFormField(controller: _annexAmenitiesMarketCtrl, decoration: const InputDecoration(labelText: 'Amenities (Market)')),
              TextFormField(controller: _annexAmenitiesGuideCtrl, decoration: const InputDecoration(labelText: 'Amenities (Guide)')),
              TextFormField(controller: _annexYearOfConstructionCtrl, decoration: const InputDecoration(labelText: 'Year of Construction')),
              TextFormField(controller: _annexBuildingAgeCtrl, decoration: const InputDecoration(labelText: 'Age of Building and future life')),
            ]),
            _buildSection(
              title: "Images & Location",
              initiallyExpanded: true,
              children: [
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text('Add Images'),
                    onPressed: _showImagePickerOptions,
                  ),
                ),
                if (_valuationImages.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _valuationImages.length,
                    itemBuilder: (context, index) {
                      final valuationImage = _valuationImages[index];
                      final latController = TextEditingController(text: valuationImage.latitude);
                      final lonController = TextEditingController(text: valuationImage.longitude);

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image.memory(valuationImage.imageFile, height: 150, width: double.infinity, fit: BoxFit.cover),                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.white70,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => setState(() => _valuationImages.removeAt(index)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: latController,
                                      readOnly: false,
                                      decoration: const InputDecoration(labelText: 'Latitude', border: OutlineInputBorder()),
                                      onChanged: (value) => valuationImage.latitude = value,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: lonController,
                                      readOnly: true,
                                      decoration: const InputDecoration(labelText: 'Longitude', border: OutlineInputBorder()),
                                      onChanged: (value) => valuationImage.longitude = value,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.my_location),
                                label: const Text('Get Current Location'),
                                onPressed: () => _getCurrentLocation(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text('Generate PDF'),
        onPressed: _generatePdf,
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children, bool initiallyExpanded = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        initiallyExpanded: initiallyExpanded,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: children.map((child) => Padding(padding: const EdgeInsets.only(bottom: 12), child: child)).toList(),
      ),
    );
  }
}

class PreviewScreenPVR1 extends StatelessWidget {
  final ValuationDataPVR1 data;
  const PreviewScreenPVR1({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Preview')),
      body: PdfPreview(
        build: (format) => PdfGeneratorPVR1(data).generate(),
      ),
    );
  }
}