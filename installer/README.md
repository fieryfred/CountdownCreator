# Building the Installer

1. Download and install [WixToolset](https://wixtoolset.org/docs/intro/)
2. Run the following command in the root directory of this project:

`wix build .\installer\countdowncreator.wxs -ext WixToolset.UI.wixext`