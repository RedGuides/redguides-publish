# RedGuides Publish

Update resources on [RedGuides](https://www.redguides.com/) with this [github action](https://github.com/marketplace/actions/redguides-publish). You'll need to have a `REDGUIDES_API_KEY` secret in your repository, and of course a RedGuides API key which is easy to obtain (info below).

## Usage

This action will update an existing resource on redguides.com to which you have ownership/team access.

All inputs are optional except for `resource_id`. If you provide `message`, you must also provide `version` (it's used as the update title).

## Inputs

- **resource_id** (required):  
  The ID of the resource to update. Must already exist on RedGuides.

- **description** (optional):  
  Path to a description file (e.g., `README.md`) which will become the "overview" description of your resource.

- **version** (required if message is provided)  
  New version number for the release (e.g., `v1.0.1`). Used as the update title when posting a `message`. Recommended when uploading a `file` (otherwise XenForo defaults to today's date).  

- **message** (optional):  
  Version update message (plain text), or path to a file (like `CHANGELOG.md`) ideally in "keep a changelog" format. If provided, requires `version` (used as the update title).  

- **file** (optional):  
  Path to your single, zipped/compiled release file. If `version` is omitted, XenForo will default the version to today's date.

- **domain** (optional):  
  Only used for markdown files that contain relative URLs. This will prepend the domain to relative URLs (e.g., `https://raw.githubusercontent.com/yourusername/yourrepo/main/`).

## API Key

- `REDGUIDES_API_KEY`: **Required**. Your RedGuides API key. This should be set as a secret in your GitHub repository.

You can obtain a permanent RedGuides API key on your account [security page](https://www.redguides.com/community/account/security).

## Example workflow
```yaml
name: Publish to RedGuides

on:
  push:
    branches: [ "main" ]

jobs:
  redfetch-publish:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Build Zip File
        run: zip -r release.zip src/

      - name: Publish to RedGuides
        uses: RedGuides/redguides-publish@v1
        env:
          REDGUIDES_API_KEY: ${{ secrets.REDGUIDES_API_KEY }}
        with:
          resource_id: '12345'
          description: 'README.md'
          version: 'v1.0.1'
          message: 'CHANGELOG.md'
          file: 'release.zip'
          domain: 'https://raw.githubusercontent.com/yourusername/yourrepo/main/'
```

## Notes
- **resource_id**: the numbers at the end of your resource URL. e.g. `https://www.redguides.com/community/resources/inzone.3174/` -> `3174`
- **REDGUIDES_API_KEY**: Make sure to add your API key to your repository secrets under `REDGUIDES_API_KEY`.
- This action is a wrapper around [md2bbcode](https://github.com/RedGuides/md2bbcode) and [redfetch](https://github.com/RedGuides/redfetch).
