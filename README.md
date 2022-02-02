
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

## Import the logMixin script

## brightscript

The `logMixin.brs` script must be imported into all views that use the logging api:

## brighterscript

In your .bs file:

```
import "pkg:/source/roku_modules/log/LogMixin.brs"
```

## initialize the logging framework

You initialize the log manager, by calling `log.initializeLogManager`, with 2 arguments:

 1. An array of strings, with names of transports transports. Built in transports are:
   - log_PrintTransport - prints to telnet output
   - log_ScreenTransport - prints to an overlaid screen view
   - log_NodeTransport - prints to a node, you can check in RALE
   - log_HTTPTransport - posts logs as json lines, to a http url

 2. The log level
   - 0 error
   - 1 warn
   - 2 info
   - 3 verbose
   - 4 debug

e.g.

**Brighterscript**

```
  m.top._rLog = log.initializeLogManager(["log_PrintTransport", "log_ScreenTransport"], 5)
```
**Brightscript**

```
  m.top._rLog = log_initializeLogManager(["log_PrintTransport", "log_ScreenTransport"], 5)
```

Do this as early as possible in your application, once sceneGraph is running.

## Configuring transports

After you have called initializeLogManager, you can access the transports from `m.top._rLog.transports[index]`, where index is the index of your transports you passed in _minus_ the printTransport, which, for efficiency reason's is a special, built in transport.

### ScreenTransport:

You can set the following properties:

 - maxVisibleLines

### HTTPTransport

The http transport POSTS a json blob, containing the logged lines as an array, as follows:
```
{lines: ["array of lines of text"]}
```

You can set the following properties:

- maxLinesBeforeSending
- maxSecondsBeforeSending
- url

#### Simple express logger:

You can make a simple app for printing out logged output from the HTTP logger with the following code:

```
const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 8000

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json())

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

let i = 0;
let date = new Date();
app.post('/', function (req, res) {
  for (let l of req.body.lines) {
    console.log(makeShortDate() + ' ' + l.replace('file:///home/george/hope/nba/nba-roku/src', ''));
  }
})

makeShortDate = () => {
  return date.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
}
```

### Custom transports

To make your own transports:
 - Create a node that extends `Group`
 - Include a `logItem` function, e.g.  `<function name='logItem' />`
 - Add and configure any views you need to your node
 - Implement the `logItem` function e.g.

```
function logItem(name, levelNum, text)
  m.displayedLines.push(left(text, 100))

  if m.displayedLines.count() > m.top.maxVisibleLines
    m.displayedLines.delete(0)
  end if

  m.scrollableText.text = m.displayedLines.join(chr(10))
end function
```

## Register loggers for each screen/view/class

In each of your components, classes, etc you wish to log, create a logger. For example:

**Brigherscript**
```
  class AnalyticsManager
    function new()
      m.log = new log.Logger("AnalyticsManager")
    end function

  end class
```

**Brightscript**
```
    function init()
      m.log = log_Logger("AnalyticsManager")
    end function
```


Once you have registered a logger, you can invoke the logging methods.

## logging

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


# PreProcessing logs to remove in prod, or add line numbers (requires transpilation with bsc - brighterscript compiler):

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
