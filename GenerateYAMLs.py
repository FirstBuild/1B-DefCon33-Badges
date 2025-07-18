import os
import base64
import secrets

TEMPLATE_PATH = "YAMLs/1b-defcon-badge-00.yaml"
OUTPUT_DIR = "YAMLs"
START = 1
END = 49

def generate_key():
    return base64.b64encode(secrets.token_bytes(32)).decode()

with open(TEMPLATE_PATH, "r") as f:
    template = f.read()

for i in range(START, END + 1):
    num = f"{i:02d}"
    name = f"1b-defcon-badge-{num}"
    key = generate_key()
    yaml = template
    yaml = yaml.replace("name: 1b-defcon-badge-00", f"name: {name}")
    yaml = yaml.replace('friendly_name: 1B DefCon Badge 00', f'friendly_name: 1B DefCon Badge {num}')
    yaml = yaml.replace('ssid: !secret wifi_ssid', 'ssid: !secret defcon_ssid')
    yaml = yaml.replace('password: !secret wifi_password', 'password: !secret defcon_password')
    yaml = yaml.replace('ssid: "1B-Defcon-Badge-00"', f'ssid: "1B-Defcon-Badge-{num}"')
    yaml = yaml.replace('key: "/RwH+c2lA8LMcVzsJwlnmSMoWLtQJfbfNtBjEcs2+BU="', f'key: "{key}"')
    yaml = yaml.replace('1b-defcon-badge-00.yaml', f'{name}.yaml')
    out_path = os.path.join(OUTPUT_DIR, f"{name}.yaml")
    with open(out_path, "w") as out:
        out.write(yaml)

START = 50
END = 99

for i in range(START, END + 1):
    num = f"{i:02d}"
    name = f"1b-defcon-badge-{num}"
    key = generate_key()
    yaml = template
    yaml = yaml.replace("name: 1b-defcon-badge-00", f"name: {name}")
    yaml = yaml.replace('friendly_name: 1B DefCon Badge 00', f'friendly_name: 1B DefCon Badge {num}')
    yaml = yaml.replace('ssid: "1B-Defcon-Badge-00"', f'ssid: "1B-Defcon-Badge-{num}"')
    yaml = yaml.replace('key: "/RwH+c2lA8LMcVzsJwlnmSMoWLtQJfbfNtBjEcs2+BU="', f'key: "{key}"')
    yaml = yaml.replace('1b-defcon-badge-00.yaml', f'{name}.yaml')
    out_path = os.path.join(OUTPUT_DIR, f"{name}.yaml")
    with open(out_path, "w") as out:
        out.write(yaml)