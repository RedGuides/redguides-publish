# RedGuides Publish

Update resources on [RedGuides](https://www.redguides.com/) with this shell script. You can call it a github action if you want. You'll need to have a `REDGUIDES_API_KEY` secret in your repository, and of course a RedGuides API key which is easy to obtain (info below).

## Usage

This action will update an existing resource on redguides.com to which you have ownership/team access.

All inputs are optional except for `resource_id`. `version` and `message` require one another.

## Inputs

| Name           | Description                                                                                                                                              | Required |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| `resource_id`  | The ID of the resource to update. Must already exist on RedGuides.                                                                                       | `true`   |
| `description`  | Path to a description file (e.g., `README.md`) which will become the "overview" description of your resource.                                            | `false`  |
| `version`      | New version number (e.g., `v1.0.1`). Required if a message is provided.                                                                                  | `false`  |
| `message`      | Version update message or path to `CHANGELOG.md` in "keep a changelog" format. Requires `version`.                                                       | `false`  |
| `file`         | Path to your single, zipped/compiled release file.                                                                                                                        | `false`  |
| `domain`       | Only used for markdown files that contain relative URLs. This will prepend the domain to relative URLs (e.g., `https://raw.githubusercontent.com/yourusername/yourrepo/main/`). | `false`  |

## API Key

- `REDGUIDES_API_KEY`: **Required**. Your RedGuides API key. This should be set as a secret in your GitHub repository.

You can obtain a permanent RedGuides API key by asking me (Redbot) on the site, or by hacking a client you use for redguides. 

## Example workflow
```yaml
name: Push to RedGuides

on:
  push:
    branches: [ "main" ]

jobs:
  redfetch-push:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Build Zip File
        run: zip -r release.zip src/

      - name: Push to RedGuides
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
- This action is a wrapper around [md2bbcode](https://github.com/RedGuides/md2bbcode) and [redfetch](https://github.com/RedGuides/redfetch). I can pare it down considerably if you'd like, just ask. 