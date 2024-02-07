# SwiftLint
swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files
swiftlint

# # Rule: Check if SwiftLint found any warnings or errors
# swiftlint_output = ``

# puts swiftlint_output

# if swiftlint_output.include?("warning") || swiftlint_output.include?("error")
#   message("
# **SwiftLint** 
# I detected issues in your code. Please resolve them before resubmitting your PR. Detailed logs provide specific guidance. For more on SwiftLint, visit its [official repository](https://github.com/realm/SwiftLint) and the [rule directory](https://realm.github.io/SwiftLint/rule-directory.html) for examples.
# ")
# end



pr_details_format_message = false

# Branch name
# Rule: Validate PR branch name format
branch_regex = /^UNSPLASH-\d{3}-[A-Za-z0-9-]+$/
unless github.pr_json['head']['ref'].match?(branch_regex)
  fail("Invalid PR branch name format. Please use the format 'UNSPLASH-XXX-Task-title'.")
  pr_details_format_message = true
end



# PR Title
# Rule: Validate PR title format
title_regex = /^\[UNSPLASH-\d+\] .+/
unless github.pr_title.match?(title_regex)
  fail("Invalid PR title format. Please use the format '[UNSPLASH-XXX] Task title'.")
  pr_details_format_message = true
end

# PR Description
# Rule: Validate the pr description
unless github.pr_body.length > 5 
  fail "Please provide a summary in the Pull Request description"
  pr_details_format_message = true
end

if pr_details_format_message 
  message("
**Pull request format**

Your pull request should not include anything beyond what is requested in the ticket you're working on; otherwise, it will be rejected. Each ticket has a specific purpose, and anything that falls outside of this scope should be handled in a separate ticket.

The title and description of your PR must reflect the ticket you've worked on and clearly describe and explain the changes you've made. For instance:

**Branch title:**
UNSPLASH-001-Create-base-To-Do-List-app-project-and-push-to-GIT-repository

**PR title:**
[UNSPLASH-001] Create base To Do List app project and push to GIT repository

**PR Description:**
In this PR, I have developed a basic To Do List iOS app that features a XIB-backed ViewController and a simple user interface. I have ensured the app is responsive by adding constraints to support various screen sizes and thoroughly tested its functionality on multiple devices for optimal performance.
    ")
end








# Target branch
# Rule: Validate that the pr is opened with develop target branch or starts with UNSPLASH
unless github.branch_for_base == "develop" || github.branch_for_base.start_with?("UNSPLASH")
  fail "The pr target branch must be `develop` or start with `UNSPLASH`. Please re-submit this PR accordingly."
end









# App Icon 
# Rule: Check if Xcode project has set up the app icon
app_icon_files = Dir.glob("**/AppIcon.appiconset/*.{jpg,png}")
unless app_icon_files.any?
  warn("App icon is missing. Please ensure the Xcode project has the app icon set up with a .jpg or .png image.")
end





# Deployment target 
# Rule: Check required deployment target
deployment_target = `xcrun xcodebuild -project Unsplash/Unsplash.xcodeproj -showBuildSettings | grep "IPHONEOS_DEPLOYMENT_TARGET" | awk '{print $3}'`.chomp
required_target = '15.0'
unless deployment_target != required_target
  warn("Current deployment target is #{deployment_target}. Required deployment target should be set to iOS #{required_target}.")
end





# Default implementation 
# Rule: Check for unused default implementation code
source_files = Dir.glob('Unsplash/**/*.swift')

source_files.each do |file|
  code = File.read(file)
  
  # Example pattern: Check for unused `viewDidLoad()` method
  if code.include?('// Do any additional setup after loading the view.')
    warn("Unused default implementation found in #{file}. Please remove the unused code.")
  end
  
  # Add more patterns for other default code snippets as needed
  
end







# Magic numbers
# Rule: Check for magic numbers
magic_number_regex = /(?<!\.)\b\d+\b(?!\.)/ # Regex to look for numbers that are not part of a date or floating-point value

magic_number_found = false # Flag to keep track of whether a magic number has been found

source_files.each do |file|
  next if file.end_with?("Tmp.swift") # Skip the Tmp.swift file
  
  code = File.read(file)
  
  # Capturing constants declared at the top of the class/struct, with or without type declaration
  constant_declarations = code.scan(/let\s+\w+(\s*:\s*\w+)?\s*=\s*(\d+)/).map do |_, number|
    number.to_i
  end

  constants = constant_declarations

  matches = code.scan(magic_number_regex)

  # Remove matches that could potentially be dates
  filtered_matches = matches.reject do |match|
    constants.include?(match.to_i) || (match.length == 4 && match.to_i.between?(1000, 2099))
  end

  # Filter out numbers that are commonly used for positioning and layout, or are generally not magic numbers
  filtered_matches = filtered_matches.reject do |match|
  [0, 1, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1, 2, 3, 4, 5].include?(match.to_f)
  end

  filtered_matches.each do |match|
    warn("Magic number '#{match}' found in #{file}. Please declare it as a constant at the top of your class, struct, or file.")
    magic_number_found = true
  end
end

if magic_number_found
  message("
  **Magic numbers** in programming refer to explicit numerical values that are directly embedded into the source code without any contextual explanation. 
  This can often cause confusion and potential issues in maintaining the code. 
  A recommended practice to mitigate this issue is to declare these values as constants within the top of your class, struct, or file. By doing so, these numerical values can be effectively referenced throughout the code, promoting clarity and consistency. For an in-depth understanding of **magic numbers** and their impact, 
  I suggest reviewing this [article](https://medium.com/@samaddico/programming-and-magic-numbers-f766e0cd1369) on the subject.
  ")
end





# .gitignore
# Rule: Ensure .gitignore exists at the root of the repository
unless File.exist?(".gitignore")
  warn(".gitignore file is missing at the root of the repository. It's crucial to add it to avoid committing unwanted files.")
end




# Non final Class
# Rule: Check that all classes are marked with final keyword
non_final_class_regex = /^class\s+[A-Z][a-zA-Z0-9_]*\s*(?::\s*[A-Z][a-zA-Z0-9_]*\s*)?{/
non_final_class_found = false

source_files.each do |file|
  code = File.read(file)
  matches = code.scan(non_final_class_regex)
  
  matches.each do |match|
    warn("Non-final class found in #{file}. Please consider marking it as 'final' if it's not intended to be subclassed.")
    non_final_class_found = true
  end
end

if non_final_class_found
  message("
  **Final Keyword**
  Some classes are not marked as 'final'. Consider marking classes as 'final' in Swift to prevent unintended subclassing and improve code safety. [Read more about final keyword](https://stevenpcurtis.medium.com/your-swift-classes-should-be-final-78cb41b79da0)
  ")
end