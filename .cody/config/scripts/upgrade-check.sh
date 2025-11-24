#!/bin/bash

set -e

# Configuration
GITHUB_REPO="ibuildwith-ai/cody-pbt"
GITHUB_RAW_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/main/.cody/config/settings.json"
LOCAL_SETTINGS_PATH="./.cody/config/settings.json"

# Function to extract version from JSON
extract_version() {
    local json_content="$1"
    echo "$json_content" | grep '"version"' | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/' | tr -d '[:space:]'
}

# Function to compare versions (returns 0 if v1 < v2, 1 if v1 >= v2)
version_compare() {
    local v1="$1"
    local v2="$2"

    # Convert versions to arrays
    IFS='.' read -ra V1_ARRAY <<< "$v1"
    IFS='.' read -ra V2_ARRAY <<< "$v2"

    # Pad arrays to same length
    local max_length=$((${#V1_ARRAY[@]} > ${#V2_ARRAY[@]} ? ${#V1_ARRAY[@]} : ${#V2_ARRAY[@]}))

    for ((i=0; i<max_length; i++)); do
        local part1=${V1_ARRAY[i]:-0}
        local part2=${V2_ARRAY[i]:-0}

        if [ "$part1" -lt "$part2" ]; then
            return 0  # v1 < v2
        elif [ "$part1" -gt "$part2" ]; then
            return 1  # v1 > v2
        fi
    done

    return 1  # v1 == v2
}

# Function to output JSON result
output_json() {
    local status="$1"
    local local_version="$2"
    local remote_version="$3"
    local message="$4"

    cat <<EOF
{
  "status": "$status",
  "local_version": "$local_version",
  "remote_version": "$remote_version",
  "message": "$message"
}
EOF
}

# Check if local settings.json exists
if [ ! -f "$LOCAL_SETTINGS_PATH" ]; then
    output_json "error" "" "" "Local settings.json not found. Are you running this from the root of your Cody project?"
    exit 1
fi

# Read local version
local_content=$(cat "$LOCAL_SETTINGS_PATH" 2>/dev/null) || {
    output_json "error" "" "" "Could not read local settings.json file."
    exit 1
}

local_version=$(extract_version "$local_content")
if [ -z "$local_version" ]; then
    output_json "error" "$local_version" "" "Could not extract version from local settings.json."
    exit 1
fi

# Fetch remote version
remote_content=""
if command -v curl >/dev/null 2>&1; then
    remote_content=$(curl -s "$GITHUB_RAW_URL" 2>/dev/null)
elif command -v wget >/dev/null 2>&1; then
    remote_content=$(wget -qO- "$GITHUB_RAW_URL" 2>/dev/null)
else
    output_json "error" "$local_version" "" "Neither curl nor wget is available. Please install one of them to check for updates."
    exit 1
fi

if [ -z "$remote_content" ]; then
    output_json "error" "$local_version" "" "Failed to fetch remote settings.json from GitHub. Please check your internet connection."
    exit 1
fi

remote_version=$(extract_version "$remote_content")
if [ -z "$remote_version" ]; then
    output_json "error" "$local_version" "" "Could not extract version from remote settings.json."
    exit 1
fi

# Compare versions
if version_compare "$local_version" "$remote_version"; then
    output_json "update_available" "$local_version" "$remote_version" "A newer version of Cody PBT is available."
else
    output_json "up_to_date" "$local_version" "$remote_version" "Your Cody PBT is already up to date."
fi