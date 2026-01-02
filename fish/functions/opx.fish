function opx
# Check if op CLI is installed
  if not command -v op &> /dev/null
      echo "Error: 1Password CLI (op) is not installed" >&2
      return 1
  end

# Check if fzf is installed
  if not command -v fzf &> /dev/null
      echo "Error: fzf is not installed" >&2
      return 1
  end

# Check if signed in to 1Password
  if not op account list &> /dev/null
      echo "Error: Not signed in to 1Password. Run 'op signin' first" >&2
      return 1
  end

# Get all login items from 1Password and format for fzf
# Format: ID|title|additional_information
  set items (op item list --categories login --format json | \
      jq -r '.[] | "\(.id)|\(.title)|\(.additional_information // "")"')

# Check if any items were found
  if test -z "$items"
      echo "Error: No login items found in 1Password" >&2
      return 1
  end

# Use fzf to select an item, showing only title and username
# The full line (including ID) is captured in the selection
  set selected (printf '%s\n' $items | \
      awk -F'|' '{printf "%s | %s | %s\n", $1, $2, $3}' | \
      fzf --delimiter='|' --with-nth=2,3 --prompt="Select credential: " --height=40% --reverse)

# Check if user cancelled fzf selection
  if test -z "$selected"
      echo "No selection made" >&2
      return 0
  end

# Extract the item ID from the selection
  set item_id (echo $selected | awk -F'|' '{print $1}' | xargs)

# Copy the password for the selected item
  op item get "$item_id" --fields label=password --reveal | tr -d '\n' | pbcopy

# Print the password
  echo "LGTM!"
end
