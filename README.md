# Rainmeter Update Checker
This script compares [semver-formatted](https://semver.org/) version strings and executes Rainmeter bang actions based on the result. It can be used to notify users of a skin suite that an update is available for download. It can also be utilized to extract options from a downloaded INI file

## Implementation
Copy the script into your skin suite and create a script measure pointing to it. You will need to add the following additional options to the measure:
`IniFilePath` - The path to the file that will be used for comparison.
`UpToDateAction` - Bangs to execute when the skin suite is up to date.
`UpdateAvailableAction` - Bangs to execute when there is an available update.
`ErrorAction` - Bangs to execute when the script encounters an error.

By default, `IniFilePath` will point to _DownloadFile.inc_ in the current skin's folder. If any of the action options are not provided, nothing will happen when that result is given.

The `GetIniOption(section, key)` function can be used with Inline LUA to retrieve and display options from the INI file.

TO BE CONTINUED