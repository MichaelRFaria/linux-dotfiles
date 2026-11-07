#!/usr/bin/env python3

import re
import subprocess
import html

output = subprocess.run(
    ["fastfetch", "--pipe", "false"],
    capture_output=True,
    text=True,
    check=True,
).stdout

# Convert ANSI SGR colour codes into Pango markup.
colors = {
    36: "#7da87b",  # desaturated dark lime green: logo and labels
    32: "#aac6a9",  # greyish lime green: usage values
    34: "#89b4fa",  # blue
}

result = []
current_color = None
bold = False

for line in output.splitlines():
    # Remove ANSI escapes, keeping colour changes for formatting.
    parts = re.split(r"\x1b\[([0-9;]*)m", line)
    rendered = []

    for i, part in enumerate(parts):
        if i % 2 == 1:
            codes = [int(c) for c in part.split(";") if c]
            if not codes or 0 in codes:
                current_color = None
                bold = False
            for code in codes:
                if code == 1:
                    bold = True
                elif code in colors:
                    current_color = colors[code]
        elif part:
            text = html.escape(part)
            attrs = []
            if current_color:
                attrs.append(f'foreground="{current_color}"')
            if bold:
                attrs.append('weight="bold"')
            if attrs:
                rendered.append(f"<span {' '.join(attrs)}>{text}</span>")
            else:
                rendered.append(text)

    result.append("".join(rendered))

print("\n".join(result))
