"""Download only the original assets referenced by the Figma MCP responses."""
import concurrent.futures
import json
import pathlib
import subprocess
import shutil

ROOT = pathlib.Path(__file__).resolve().parents[2]
previous_file=ROOT / 'design_source/preview/assets_previous.json'
previous={a['url']: a['file'] for a in json.loads(previous_file.read_text())} if previous_file.exists() else {}
assets = json.loads((ROOT / 'design_source/preview/assets.json').read_text())

def download(asset):
    dest = ROOT / asset['file']
    if dest.exists() and dest.stat().st_size:
        return None
    dest.parent.mkdir(parents=True, exist_ok=True)
    old=ROOT/previous.get(asset['url'],asset['file'])
    if old.exists() and old.stat().st_size:
        shutil.copyfile(old,dest)
        return None
    result = subprocess.run(['curl', '-f', '-L', '--retry', '2', '--connect-timeout', '15', '--max-time', '90', '-sS', asset['url'], '-o', str(dest)], capture_output=True)
    return None if result.returncode == 0 else {'file': asset['file'], 'error': result.stderr.decode()[-200:]}

with concurrent.futures.ThreadPoolExecutor(max_workers=24) as executor:
    failures = [r for r in executor.map(download, assets) if r]
(ROOT / 'design_source/preview/download_failures.json').write_text(json.dumps(failures, indent=2))
print(json.dumps({'assets': len(assets), 'failed': len(failures), 'failures': failures[:3]}))
