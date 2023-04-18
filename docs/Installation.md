<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Import the logMixin script](#import-the-logmixin-script)
- [Initialize the logging framework](#initialize-the-logging-framework)
- [Roku log plugin](#roku-log-plugin)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


Use the [ropm package manager for roku](https://github.com/rokucommunity/ropm)

```bash
ropm install log@npm:roku-log
```

*note:* It is recommended that you install with the `log` prefix. All instructions here assume this setup.

## Import the logMixin script

**brightscript**

The `logMixin.brs` script must be imported into all views that use the logging api:

**brighterscript**

In your .bs file:

```
import "pkg:/source/roku_modules/log/LogMixin.brs"
```

## Initialize the logging framework

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

## Roku log plugin
  *Optionally* [roku-log-bsc-plugin](PreProcessing-logs.md#roku-log-bsc-plugin) can be used.
