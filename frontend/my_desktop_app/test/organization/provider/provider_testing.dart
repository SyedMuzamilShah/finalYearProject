import 'package:flutter/foundation.dart';
import 'package:my_desktop_app/core/services/token_service.dart';
import 'package:my_desktop_app/features/organization/data/models/request/organization_prams.dart';
import 'package:my_desktop_app/features/organization/data/models/response/organization_response.dart';
import 'package:my_desktop_app/features/organization/presentation/providers/organization_provider.dart';
import '../../Auth/api_testing/api_testing.dart';

class TestingAuth {
  Future<void> login() async {
    final auth = AuthApiTesting();
    await auth.login();
  }

  final token = {
    "accessToken":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2U3ZGM0MjliYzBmMzc0MGUxNGQ1MmIiLCJpYXQiOjE3NDM2ODE4MDgsImV4cCI6MTc0MzY4OTAwOH0.udtHR27JQ6kTMmROW3mDFWBYwqeG51aJHFgnRH83b04",
    "refreshToken":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2U3ZGM0MjliYzBmMzc0MGUxNGQ1MmIiLCJpYXQiOjE3NDM2ODE4MDgsImV4cCI6MTc0Mzc2ODIwOH0.n_IuA0UmVRyj7GdNYjzjLjguYITRAAqaYiqi49z50SY"
  };

  Future<void> tokenSave() async {
    await TokenService().setToken(token);
  }
}

void printOrganizationState(String phase, OrganizationNotifier provider) {
  if (kDebugMode) {
    debugPrint('\n=== $phase ===');
    debugPrint('Error Message: ${provider.state.errorMessage}');
    debugPrint('Error List: ${provider.state.errorList}');
    debugPrint('Loading: ${provider.state.isLoading}');
    debugPrint('Organization List: ${provider.state.organizations}');
    debugPrint('Selected Organization: ${provider.state.selectedOrganization}');
  }
}

void main() async {
  // Initialize test environment
  await TokenService().initialize();

  // Uncomment to use test auth tokens
  // await TestingAuth().login();
  // await TestingAuth().tokenSave();
  // return;

  // Initialize provider and test models
  final organizationProvider = OrganizationNotifier();

  const testOrganizationId = '34567654324567654';
  final readParams = OrganizationReadPrams(id: testOrganizationId);
  final createParams = OrganiztionCreatePrams(
    name: "Testing",
    email: 'testing@gmail.com',
    phoneNumber: "+093156543",
    website: "http://test.com",
    address: "karachi",
  );
  final deleteParams = OrganizationDeletePrams(
    organizationId: "ORG-44KV8H",
  );

  // Test organization response model
  final orgResponseJson = {
    '_id': '67ee25e1baf8996a507a4dd6',
    'name': 'Testing',
    'email': 'testing@gmail.com',
    'phoneNumber': '+92 3145643',
    'website': 'https://w.com',
    'address': '67ee25e1baf8996a507a4dd3',
    'createdBy': '67e7dc429bc0f3740e14d52b',
    'organizationId': 'ORG-CWQ1AN',
    'createdAt': '2025-04-03T06:08:33.099Z',
    'updatedAt': '2025-04-03T06:08:33.099Z',
    '__v': 0,
  };

  // Test cases
  printOrganizationState('Initial State', organizationProvider);

  // Test 1: Delete organization
  debugPrint('\n--- Testing Delete Organization ---');
  await organizationProvider.delete(deleteParams);
  printOrganizationState('After Delete', organizationProvider);

  // Test 2: Read organization with valid ID
  debugPrint('\n--- Testing Read Organization (with ID) ---');
  await organizationProvider.read(model: readParams);
  printOrganizationState('After Read (with ID)', organizationProvider);

  // Test 3: Read all organizations
  debugPrint('\n--- Testing Read All Organizations ---');
  // await organizationProvider.read(model: null);
  await organizationProvider.read();
  print(".......................................");
  printOrganizationState('After Read All', organizationProvider);

  // Test 4: Create organization
  debugPrint('\n--- Testing Create Organization ---');
  await organizationProvider.create(model: createParams);
  printOrganizationState('After Create', organizationProvider);

  // Test 5: Save organization response
  debugPrint('\n--- Testing Save Organization Response ---');
  final OrganizationResponseModel response = OrganizationResponseModel.fromJson(orgResponseJson);
  organizationProvider.organizationSaved(response);
  printOrganizationState('After Save Response', organizationProvider);

  // Final state
  printOrganizationState('Final State', organizationProvider);
}
