#!/bin/bash

set -e

# Configuration
GITHUB_REPO="ibuildwith-ai/cody-pbt"
GITHUB_ARCHIVE_URL="https://github.com/${GITHUB_REPO}/archive/refs/heads/main.zip"
LOCAL_CONFIG_PATH="./.cody/config"
UPGRADE_CONFIG_PATH="./.cody/config.upgrade"

# Function to output JSON result
output_json() {
    local status="$1"
    local target_version="$2"
    local message="$3"

    cat <<EOF
{
  "status": "$status",
  "target_version": "$target_version",
  "message": "$message"
}
EOF
}

# Function to extract version from JSON
extract_version() {
    local json_content="$1"
    echo "$json_content" | grep '"version"' | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/' | tr -d '[:space:]'
}

# Check if version parameter is provided
if [ $# -ne 1 ]; then
    output_json "error" "" "Usage: upgrade-download.sh <target_version>"
    exit 1
fi

TARGET_VERSION="$1"

# Check if local config directory exists
if [ ! -d "$LOCAL_CONFIG_PATH" ]; then
    output_json "error" "$TARGET_VERSION" "Local .cody/config directory not found. Are you running this from the root of your Cody project?"
    exit 1
fi

# Check if config.upgrade already exists
if [ -d "$UPGRADE_CONFIG_PATH" ]; then
    output_json "error" "$TARGET_VERSION" "Upgrade directory already exists at $UPGRADE_CONFIG_PATH. Please remove it and try again."
    exit 1
fi

# Create temporary directory for download
temp_dir=$(mktemp -d) || {
    output_json "error" "$TARGET_VERSION" "Could not create temporary directory for download."
    exit 1
}

# Cleanup function
cleanup() {
    rm -rf "$temp_dir"
}
trap cleanup EXIT

# Download the repository archive
if command -v curl >/dev/null 2>&1; then
    curl -L -o "$temp_dir/cody-pbt-main.zip" "$GITHUB_ARCHIVE_URL" 2>/dev/null || {
        output_json "error" "$TARGET_VERSION" "Failed to download repository archive using curl. Please check your internet connection."
        exit 1
    }
elif command -v wget >/dev/null 2>&1; then
    wget -O "$temp_dir/cody-pbt-main.zip" "$GITHUB_ARCHIVE_URL" 2>/dev/null || {
        output_json "error" "$TARGET_VERSION" "Failed to download repository archive using wget. Please check your internet connection."
        exit 1
    }
else
    output_json "error" "$TARGET_VERSION" "Neither curl nor wget is available. Please install one of them."
    exit 1
fi

# Extract the archive
cd "$temp_dir"
if command -v unzip >/dev/null 2>&1; then
    unzip -q "cody-pbt-main.zip" 2>/dev/null || {
        cd - >/dev/null
        output_json "error" "$TARGET_VERSION" "Failed to extract the downloaded archive. The file may be corrupted."
        exit 1
    }
else
    cd - >/dev/null
    output_json "error" "$TARGET_VERSION" "unzip command not found. Please install unzip to proceed with the download."
    exit 1
fi

# Return to original directory
cd - >/dev/null

# Verify the extracted content
if [ ! -d "$temp_dir/cody-pbt-main/.cody/config" ]; then
    output_json "error" "$TARGET_VERSION" "Downloaded archive does not contain expected .cody/config directory."
    exit 1
fi

# Copy the config directory to config.upgrade
cp -r "$temp_dir/cody-pbt-main/.cody/config" "$UPGRADE_CONFIG_PATH" || {
    output_json "error" "$TARGET_VERSION" "Failed to copy downloaded config to upgrade directory."
    exit 1
}

# Copy additional folders to config.upgrade
if [ -d "$temp_dir/cody-pbt-main/.claude" ]; then
    cp -r "$temp_dir/cody-pbt-main/.claude" "$UPGRADE_CONFIG_PATH/.claude" 2>/dev/null || {
        output_json "error" "$TARGET_VERSION" "Failed to copy .claude folder to upgrade directory."
        exit 1
    }
fi

if [ -d "$temp_dir/cody-pbt-main/.github" ]; then
    cp -r "$temp_dir/cody-pbt-main/.github" "$UPGRADE_CONFIG_PATH/.github" 2>/dev/null || {
        output_json "error" "$TARGET_VERSION" "Failed to copy .github folder to upgrade directory."
        exit 1
    }
fi

# Verify the downloaded version
if [ -f "$UPGRADE_CONFIG_PATH/settings.json" ]; then
    downloaded_content=$(cat "$UPGRADE_CONFIG_PATH/settings.json" 2>/dev/null)
    if [ -n "$downloaded_content" ]; then
        downloaded_version=$(extract_version "$downloaded_content")
        if [ "$downloaded_version" = "$TARGET_VERSION" ]; then
            output_json "success" "$TARGET_VERSION" "Cody PBT version $TARGET_VERSION downloaded successfully to config.upgrade."
        else
            output_json "error" "$TARGET_VERSION" "Download completed but version verification failed. Expected $TARGET_VERSION, got $downloaded_version."
            # Clean up the failed download
            rm -rf "$UPGRADE_CONFIG_PATH" 2>/dev/null
            exit 1
        fi
    else
        output_json "error" "$TARGET_VERSION" "Download completed but could not read downloaded settings.json file."
        # Clean up the failed download
        rm -rf "$UPGRADE_CONFIG_PATH" 2>/dev/null
        exit 1
    fi
else
    output_json "error" "$TARGET_VERSION" "Download completed but settings.json file not found in downloaded config."
    # Clean up the failed download
    rm -rf "$UPGRADE_CONFIG_PATH" 2>/dev/null
    exit 1
fi