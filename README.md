
[![build](https://img.shields.io/github/workflow/status/georgejecook/roku-log/build.svg?logo=github)](https://github.com/georgejecook/roku-log/actions?query=workflow%3Abuild)
[![GitHub](https://img.shields.io/github/release/georgejecook/roku-log.svg?style=flat-square)](https://github.com/georgejecook/roku-log/releases)
[![NPM Version](https://badge.fury.io/js/roku-log.svg?style=flat)](https://npmjs.org/package/roku-log)

## About roku-log

roku-log is a logging framework for Roku Scenegraph apps. It is specifically tailored to the nuances of Roku development. Notably it is:

 - Lightweight in both performance and syntax
 - Works across nodes, tasks and thread boundaries
 - Crash safe: i.e it safely logs values, without crashing on invalid, undefined, or unexpected value types
 - Highly configurable: You can configure log levels, include and exclude filters, various log transports, light logging mode, and more
 - Has multiple log transports:
   - PrintTransport - i.e. telnet output
   - Screen - screen overlay
   - NodeTransport - log lines go to a node, which you can view in RALE (Roku Advanced Layout Editor), where you can read/copy the values into json
     - easy to add more - Simply provide the name of a component that has a `logItem` function

# Using roku-log

## Installation

Use the [ropm package manager for roku](https://github.com/rokucommunity/ropm)

```bash
ropm install log@npm:roku-log
```

*note:* It is recommended that you install with the `log` prefix. All instructions here assume this setup.

## Usage

### Import the logMixin script

The logMixin.brs script must be imported into all views that use the logging api:

#### brighterscript

In your .bs file:

```
import "pkg:/source/roku_modules/log/LogMixin.brs"
```

### initialize the logging framework

You initialize the log manager, by calling `log.initializeLogManager`, with 2 arguments:

 1. An array of log transports. Built in transports are:
   - log_PrintTransport
   - log_ScreenTransport
   - log_NodeTransport

 2. The log level
   - 0 error
   - 1 warn
   - 2 info
   - 3 verbose
   - 4 debug

e.g.

```
  m.top._rLog = log.initializeLogManager(["log_PrintTransport", "log_ScreenTransport"], 5)
```

Do this as early as possible in your application, once sceneGraph is running.


### Register loggers for each screen/view/class

In each of your components, classes, etc you wish to log, create a logger. For example:

```
  class AnalyticsManager
    function new()
      m.log = new log.Logger("AnalyticsManager")
    end function

  end class
```

Once you have registered a logger, you can invoke the logging methods.

### logging

Once you have created a log instance, you can call the following functions:

 - `m.log.error`
 - `m.log.warn`
 - `m.log.info`
 - `m.log.method`
 - `m.log.verbose`
 - `m.log.debug`

All logging methods have the same signature, allowing for a message, and 9 values:

```
m.log.xxx(message, value1, value2, value3, value4, value5, value6, value7, value8, value9)
```

e.g.

```
m.log.info("Received data", json.result, "http call", m.top.uri)
```

Note, you do not have to worry about converting values into string; `roku-log` will do this for you safely.


# PreProcessing logs to remove in prod, or add line numbers:

To get the most out of the `roku-log`, you should use bsc to compile your project, and use the `roku-log-bsc-plugin` by:

1. `npm i roku-log-bsc-plugin --save-dev`
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
