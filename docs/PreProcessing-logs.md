<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [To remove log calls from an app, entirely](#to-remove-log-calls-from-an-app-entirely)
- [To Ensure the pkg path is inserted into each log call in your app:](#to-ensure-the-pkg-path-is-inserted-into-each-log-call-in-your-app)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

If you use brighterscript transpiler , you can easily pre-process your code to remove log lines in prod, or add line numbers. Recall: you can use bsc (brighterscript), _without_ using brighterscript language (though, if you are not using brighterscript, you're frankly mugging yourself; but hey..)

To get the most out of the `roku-log`, you should use bsc to compile your project, and use the `roku-log-bsc-plugin` by:

1. <a name="roku-log-bsc-plugin"></a>`npm i roku-log-bsc-plugin --save-dev` 
2.  adding the following to your bsconfig.json:

```
  "plugins": [
    "roku-log-bsc-plugin"
  ],
```

## To remove log calls from an app, entirely

Add the following to your `bsconfig.json` (if you have plugins already, append the plugin value)

```
  "plugins": [
    "roku-log-bsc-plugin"
  ],
  "rokuLog": {
    "strip": true
  }
```

## To Ensure the pkg path is inserted into each log call in your app:

Add the following to your `bsconfig.json` (if you have plugins already, append the plugin value)

```
  "plugins": [
    "roku-log-bsc-plugin"
  ],
  "rokuLog": {
    "insertPkgPath": true
  }
```

This method is extremely useful, and is fully compatible with the vscode brightscript IDE plugin's `brightscript.output.hyperlinkFormat` settings, for both brightscript and brighterscript projects

e.g. put the follwing in your vscode settings:

```
  "brightscript.output.hyperlinkFormat": "FilenameAndFunction",
```
