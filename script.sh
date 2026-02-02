#!/usr/bin/env bash
set -e

SHORTCODES_DIR="layouts/shortcodes"
THUMB_FILE="$SHORTCODES_DIR/thumb.html"
THUMB_ROW_FILE="$SHORTCODES_DIR/thumb-row.html"

echo "Ensuring shortcodes directory exists..."
mkdir -p "$SHORTCODES_DIR"

# --- Create thumb.html ---
if [[ -f "$THUMB_FILE" ]]; then
  echo "thumb.html already exists — skipping"
else
  echo "Creating thumb.html"
  cat <<'EOF' > "$THUMB_FILE"
{{- $src := .Get "src" -}}
{{- $link := .Get "link" | default $src -}}
{{- $w := .Get "width" | default "100" -}}
{{- $h := .Get "height" | default "100" -}}

<figure>
  <a href="{{ $link | relURL }}">
    <img
      src="{{ $src | relURL }}"
      width="{{ $w }}"
      height="{{ $h }}"
      loading="lazy"
      decoding="async"
    >
  </a>
</figure>
EOF
fi

# --- Create thumb-row.html ---
if [[ -f "$THUMB_ROW_FILE" ]]; then
  echo "thumb-row.html already exists — skipping"
else
  echo "Creating thumb-row.html"
  cat <<'EOF' > "$THUMB_ROW_FILE"
<div class="thumb-row">
  {{- .Inner -}}
</div>
EOF
fi

echo "Shortcode setup complete."
