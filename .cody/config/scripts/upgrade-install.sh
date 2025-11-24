#!/bin/bash

set -e

# Configuration
LOCAL_CONFIG_PATH="./.cody/config"
UPGRADE_CONFIG_PATH="./.cody/config.upgrade"

# Cody-managed files to sync
CLAUDE_FILES=(
    "commands/cody.md"
)

GITHUB_FILES=(
    "prompts/cody.prompt.md"
)

# Function to output JSON result
output_json() {
    local status="$1"
    local from_version="$2"
    local to_version="$3"
    local message="$4"
    local backup_path="$5"

    cat <<EOF
{
  "status": "$status",
  "from_version": "$from_version",
  "to_version": "$to_version",
  "message": "$message",
  "backup_path": "$backup_path"
}
EOF
}

# Function to extract version from JSON
extract_version() {
    local json_content="$1"
    echo "$json_content" | grep '"version"' | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/' | tr -d '[:space:]'
}

# Function to sync specific files from upgrade folder to target folder
# Args: $1=folder_name (e.g., ".claude"), $2=array_name (e.g., "CLAUDE_FILES")
sync_folder_files() {
    local folder_name="$1"
    shift
    local -a files_array=("$@")
    local source_folder="$UPGRADE_CONFIG_PATH/$folder_name"
    local target_folder="./$folder_name"

    # Skip if source doesn't exist
    if [ ! -d "$source_folder" ]; then
        return 0
    fi

    # Create target folder if it doesn't exist
    if [ ! -d "$target_folder" ]; then
        mkdir -p "$target_folder" 2>/dev/null || {
            echo "Warning: Could not create $target_folder" >&2
            return 1
        }
    fi

    # Copy each file in the array
    for file in "${files_array[@]}"; do
        local source_file="$source_folder/$file"
        local target_file="$target_folder/$file"

        if [ -f "$source_file" ]; then
            # Create parent directory if needed
            local parent_dir=$(dirname "$target_file")
            mkdir -p "$parent_dir" 2>/dev/null

            # Copy file (overwrites if exists)
            cp "$source_file" "$target_file" 2>/dev/null || {
                echo "Warning: Could not copy $file to $target_folder" >&2
            }
        fi
    done
}

# Check if we're running from the upgrade config directory
current_script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ ! "$current_script_path" =~ config\.upgrade/scripts$ ]]; then
    output_json "error" "" "" "This script must be run from the config.upgrade/scripts directory." ""
    exit 1
fi

# Check if upgrade config directory exists
if [ ! -d "$UPGRADE_CONFIG_PATH" ]; then
    output_json "error" "" "" "Upgrade directory not found at $UPGRADE_CONFIG_PATH. Run upgrade-download.sh first." ""
    exit 1
fi

# Check if original config directory exists
if [ ! -d "$LOCAL_CONFIG_PATH" ]; then
    output_json "error" "" "" "Original config directory not found at $LOCAL_CONFIG_PATH." ""
    exit 1
fi

# Get current version from original config
CURRENT_VERSION=""
if [ -f "$LOCAL_CONFIG_PATH/settings.json" ]; then
    current_content=$(cat "$LOCAL_CONFIG_PATH/settings.json" 2>/dev/null) || {
        output_json "error" "" "" "Could not read current settings.json file." ""
        exit 1
    }
    CURRENT_VERSION=$(extract_version "$current_content")
fi

# Get target version from upgrade config
TARGET_VERSION=""
if [ -f "$UPGRADE_CONFIG_PATH/settings.json" ]; then
    upgrade_content=$(cat "$UPGRADE_CONFIG_PATH/settings.json" 2>/dev/null) || {
        output_json "error" "$CURRENT_VERSION" "" "Could not read upgrade settings.json file." ""
        exit 1
    }
    TARGET_VERSION=$(extract_version "$upgrade_content")
else
    output_json "error" "$CURRENT_VERSION" "" "Upgrade settings.json file not found." ""
    exit 1
fi

# Create versioned backup
BACKUP_ROOT="./.cody/backup"
backup_path="${BACKUP_ROOT}/${CURRENT_VERSION}"

# Create backup directory structure
mkdir -p "$backup_path" 2>/dev/null || {
    output_json "error" "$CURRENT_VERSION" "$TARGET_VERSION" "Failed to create backup directory." ""
    exit 1
}

# Backup .cody/config (maintain folder structure)
if [ -d "$LOCAL_CONFIG_PATH" ]; then
    mkdir -p "$backup_path/.cody" 2>/dev/null
    cp -r "$LOCAL_CONFIG_PATH" "$backup_path/.cody/config" 2>/dev/null || {
        output_json "error" "$CURRENT_VERSION" "$TARGET_VERSION" "Failed to backup config directory." ""
        exit 1
    }
fi

# Backup .claude folder (if exists)
if [ -d "./.claude" ]; then
    mkdir -p "$backup_path/.claude" 2>/dev/null
    cp -r "./.claude/." "$backup_path/.claude/" 2>/dev/null
fi

# Backup .github folder (if exists)
if [ -d "./.github" ]; then
    mkdir -p "$backup_path/.github" 2>/dev/null
    cp -r "./.github/." "$backup_path/.github/" 2>/dev/null
fi

# Sync additional folders BEFORE renaming config
sync_folder_files ".claude" "${CLAUDE_FILES[@]}"
sync_folder_files ".github" "${GITHUB_FILES[@]}"

# Clean up staging folders from config.upgrade (so they don't end up in .cody/config/)
rm -rf "$UPGRADE_CONFIG_PATH/.claude" 2>/dev/null
rm -rf "$UPGRADE_CONFIG_PATH/.github" 2>/dev/null

# Remove original config directory
rm -rf "$LOCAL_CONFIG_PATH" || {
    output_json "error" "$CURRENT_VERSION" "$TARGET_VERSION" "Failed to remove original config directory. Backup available at $backup_path." "$backup_path"
    exit 1
}

# Rename upgrade config to become the new config
mv "$UPGRADE_CONFIG_PATH" "$LOCAL_CONFIG_PATH" || {
    output_json "error" "$CURRENT_VERSION" "$TARGET_VERSION" "Failed to install new config directory. Backup available at $backup_path." "$backup_path"
    # Try to restore from backup if the rename failed
    if [ -d "$backup_path" ]; then
        cp -r "$backup_path" "$LOCAL_CONFIG_PATH" 2>/dev/null || true
    fi
    exit 1
}

# Verify the installation
if [ -f "$LOCAL_CONFIG_PATH/settings.json" ]; then
    installed_content=$(cat "$LOCAL_CONFIG_PATH/settings.json" 2>/dev/null)
    if [ -n "$installed_content" ]; then
        installed_version=$(extract_version "$installed_content")
        if [ "$installed_version" = "$TARGET_VERSION" ]; then
            output_json "success" "$CURRENT_VERSION" "$TARGET_VERSION" "Cody PBT successfully upgraded. Backup saved to .cody/backup/$CURRENT_VERSION" "$backup_path"
        else
            output_json "error" "$CURRENT_VERSION" "$installed_version" "Installation completed but version verification failed. Expected $TARGET_VERSION, got $installed_version. Backup available at $backup_path." "$backup_path"
        fi
    else
        output_json "error" "$CURRENT_VERSION" "" "Installation completed but could not read new settings.json file. Backup available at $backup_path." "$backup_path"
    fi
else
    output_json "error" "$CURRENT_VERSION" "" "Installation completed but new settings.json file not found. Backup available at $backup_path." "$backup_path"
fi