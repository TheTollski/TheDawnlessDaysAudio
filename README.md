# The Dawnless Days — Audio Repo (tdd)

This repository tracks the **editable source-of-truth artifacts** for TDD audio work:

- **Soundbank metadata** (per audio type): the soundbank `.json` file and its corresponding `*_custom_names.txt`
- **In-game audio assets** (per audio type): exported audio `.wem` files

It intentionally **does not** track generated build outputs (like soundbank `.bnk`) or working/source audio (like `.wav`).

## What to commit (and what not to)

### Commit these

- **Soundbank metadata**
  - `<audio_type>/<audio_type>.json`
  - `<audio_type>/<audio_type>_custom_names.txt`
  - Examples in this repo:
    - `campaign_ui/campaign_ui.json` + `campaign_ui/campaign_ui_custom_names.txt`
    - `campaign_vo/campaign_vo.json` + `campaign_vo/campaign_vo_custom_names.txt`
    - `global_music/global_music.json` + `global_music/global_music_custom_names.txt`
    - `battle_vo_orders/battle_vo_orders.json` + `battle_vo_orders/battle_vo_orders_custom_names.txt`
    - `battle_advice/battle_advice.json` + `battle_advice/battle_advice_custom_names.txt`
- **Exported audio**
  - Any updated/added `.wem` files for the relevant audio type(s)

### Do not commit these

- **Generated soundbanks**: `*.bnk`
- **Source/working audio**: `*.wav`
- **Other ignored build artifacts**: `*.dat`, `*.pack`, `*.mp3`

These are excluded by `.gitignore` (see `.gitignore` at repo root), but you should still sanity-check `git status` before committing.

## Perceived loudness normalization (before converting `.wav` → `.wem`)

Before converting any `.wav` into `.wem`, normalize the **perceived loudness** of the `.wav` to the target level for its category:

| Category | Target perceived loudness |
|---|---:|
| Campaign intro flybys | -16.0 LUFS |
| Campaign music | -16.0 LUFS |
| UI — end turn | -15.5 LUFS |
| UI — victory / defeat / message | -17.0 LUFS |
| Battle VO | -18.0 LUFS |

If a file doesn’t clearly fit one of the categories above, follow the closest match used by that audio type, and be consistent within the set.

## Workflow

### 1) Convert soundbank(s) (`.json` → `.bnk`)

To get the latest soundbank `.bnk` files on your machine:

1. Pull the latest commits.
2. Open **SoundbankEditor** and convert the relevant soundbank `.json` file(s) into `.bnk`.

### 2) Update soundbank(s)

- Use **SoundbankEditor** to open the soundbank `.bnk` file and make changes.
- When saving a soundbank in **SoundbankEditor** it automatically saves a `.json` file and `_custom_names.txt` file for that soundbank as well. These two files are what we commit to this repository to represent soundbank changes (instead of committing the `.bnk` file).

### 3) Edit/prepare the source audio (`.wav`)

- Work on the `.wav` in your working area.
- Normalize perceived loudness to the LUFS target for the category using a program like Audacity, referencing the table above.

### 4) Convert `.wav` → `.wem`

- Convert/export the normalized `.wav` into `.wem`.
- Place the resulting `.wem` files in the appropriate location for the relevant audio type(s).

### 5) Verify what changed

In PowerShell, from the repo root:

```powershell
git status
git diff
```

You should typically see changes limited to:

- `<audio_type>/*.json`
- `<audio_type>/*_custom_names.txt`
- `<audio_type>/**/*.wem` (or wherever your `.wem` outputs live)

and **not** `*.bnk` or `*.wav`.

### 6) Commit

Stage and commit only the relevant artifacts:

```powershell
git add <audio_type>\<audio_type>.json
git add <audio_type>\<audio_type>_custom_names.txt
git add <audio_type>\**\*.wem
git commit -m "Update <audio_type> audio"
```

If multiple audio types were touched, stage/commit them together only when the changes are part of the same logical update; otherwise prefer separate commits per audio type.
