---
command: ":cody upgrade"
description: Upgrades Cody Product Builder to the latest version from GitHub. Only works with version 1.1.0 or later.
---

# UPGRADE CODY PRODUCT BUILDER

### ANNOUNCE TO THE **USER**
- Tell the **USER** that you (**AGENT**) are checking for Cody Product Builder updates.

### CHECK FOR UPDATES
- Use the Bash tool to run and execute: `{{cfScripts}}/upgrade-check.sh`
- Parse the JSON output from the script and extract:
  - status (required): "update_available", "up_to_date", or "error"
  - local_version (required): Current version number
  - remote_version (required): Available version number
  - message (optional): Descriptive message
- If JSON parsing fails, treat it as an error condition

### HANDLE CHECK RESULTS
- If the status is "up_to_date":
  - Tell the **USER** that their Cody Product Builder is already up to date
  - Display the `local_version`.
  - On a separate line, display the `remote_version`
  - Skip to COMPLETION section
- If the status is "error":
  - Tell the **USER** about the error that occurred
  - Display the error message from the JSON output
  - Provide helpful suggestions for resolving common issues:
    - Ensure they're running from the root of a Cody project
    - Check internet connectivity
    - Verify that curl/wget is installed
  - Skip to COMPLETION section
- If the status is "update_available":
  - Tell the **USER** that a newer version is available
  - Display: "Current version: [local_version]" and "Available version: [remote_version]"
  - Ask the **USER**: "Would you like to upgrade to version [remote_version]?"
  - Wait for **USER** response

### HANDLE USER RESPONSE (only if update was available)
- If the **USER** declines (says no or anything close to it):
  - Tell the **USER** that the upgrade was cancelled
  - Remind them they can run `:cody upgrade` again anytime to upgrade
  - Skip to COMPLETION section
- If the **USER** confirms (says yes or anything close to it):
  - Continue to DOWNLOAD UPGRADE section

### DOWNLOAD UPGRADE
- Tell the **USER** that you (**AGENT**) are downloading the new Cody Product Builder version
- Use the Bash tool to run: `{{cfScripts}}/upgrade-download.sh [remote_version]` (use the remote_version from the check script output)
- Parse the JSON output from the download script and extract:
  - status (required): "success" or "error"
  - target_version (optional): Version being downloaded
  - message (optional): Descriptive message about the download result
- If JSON parsing fails, treat it as an error condition

### HANDLE DOWNLOAD RESULTS
- If the status is "success":
  - Tell the **USER** that the download completed successfully
  - Continue to INSTALL UPGRADE section
- If the status is "error":
  - Tell the **USER** that the download encountered an error
  - Display the error message from the JSON output
  - Provide helpful suggestions based on common download issues:
    - Check available disk space
    - Verify internet connectivity
    - Ensure no existing config.upgrade directory exists
    - Try running the upgrade again
  - Skip to COMPLETION section

### INSTALL UPGRADE
- Tell the **USER** that you (**AGENT**) are now installing the upgrade
- Use the Bash tool to run: `{{cfScripts}}/upgrade-install.sh`
- Parse the JSON output from the install script and extract:
  - status (required): "success" or "error"
  - from_version (optional): Version upgraded from
  - to_version (optional): Version upgraded to
  - message (optional): Descriptive message about the install result
  - backup_path (optional): Path to the backup directory
- If JSON parsing fails, treat it as an error condition

### HANDLE INSTALL RESULTS
- If the status is "success":
  - Congratulate the **USER** on the successful upgrade
  - Display: "Upgraded from version [from_version] to [to_version]"
  - Tell the **USER** that their Cody Product Builder is now up to date
  - Inform the **USER** that a backup of their previous configuration was created
  - If backup_path is provided, tell them the backup location: [backup_path]
  - Let them know they can delete the backup folder if they no longer need it
  - Continue to RELEARN AFTER UPGRADE section
- If the status is "error":
  - Tell the **USER** that the upgrade installation encountered an error
  - Display the error message from the JSON output
  - If backup_path is provided, inform them that a backup was created at: [backup_path]
  - Provide helpful suggestions based on common installation issues:
    - Check that they have write permissions to the .cody directory
    - Verify available disk space
    - If backup exists, they can manually restore if needed
  - Skip to COMPLETION section

### RELEARN AFTER UPGRADE (only if upgrade was successful)
- Tell the **USER** that since Cody Product Builder was upgraded, the **AGENT** will now relearn it
- Execute the command `:cody relearn`

### COMPLETION
- Tell the **USER** that the upgrade process is complete and you're ready to continue working