# This file contains the fastlane.tools configuration
# You can find the documentation at https://docs.fastlane.tools
#
# For a list of all available actions, check out
#
#     https://docs.fastlane.tools/actions
#
# For a list of all available plugins, check out
#
#     https://docs.fastlane.tools/plugins/available-plugins
#

# Uncomment the line if you want fastlane to automatically update itself
# update_fastlane

 default_platform(:ios)

platform :ios do

  #################################### Constants ####################################

  # TEST_SIMULATORS = ['iPhone 8','iPhone SE','iPhone X']


  ################################### Public Lanes ###################################
  desc "Description of what the lane does"
  lane :parallel_device_real do
    scan(
      scheme: 'NyTimesApp', # Project scheme name
      clean: true, # Clean project folder before test execution
      destination: TEST_SIMULATORS, # Devices for testing
      result_bundle: "TestResults" # To generate advanced test reports
    )
    generate_report
  end

  ################################## Helper Methods ##################################

  desc "Generate test reports"
  def generate_report
    puts "Generating Test Report ..."
    sh 'xchtmlreport -r test_output/NyTimesApp.test_result'
    puts "Test Report Succesfully generated"
  end
end
