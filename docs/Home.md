[![build](https://img.shields.io/github/workflow/status/georgejecook/roku-log/build.svg?logo=github)](https://github.com/georgejecook/roku-log/actions?query=workflow%3Abuild)
[![GitHub](https://img.shields.io/github/release/georgejecook/roku-log.svg?style=flat-square)](https://github.com/georgejecook/roku-log/releases)
[![NPM Version](https://badge.fury.io/js/roku-log.svg?style=flat)](https://npmjs.org/package/roku-log)

roku-log is a logging framework for Roku Scenegraph apps. It is specifically tailored to the nuances of Roku development. Notably it is:

 - Lightweight in both performance and syntax
 - Works across nodes, tasks and thread boundaries
 - Crash safe: i.e it safely logs values, without crashing on invalid, undefined, or unexpected value types
 - Highly configurable: You can configure log levels, include and exclude filters, various log transports, light logging mode, and more
 - Has multiple log transports:
   - PrintTransport - i.e. telnet output
   - Screen - screen overlay
   - NodeTransport - log lines go to a node, which you can view in RALE (Roku Advanced Layout Editor), where you can read/copy the values into json
   - HTTPTransport - send logged lines to a webservice
 - Easy to [add custom transports](/docs/Transports.md#custom-transports)

## Table of contents
  * [Home](/docs/Home.md)
  * [Installation](/docs/Installation.md)
  * [Logging](/docs/Logging.md)
  * [PreProcessing logs](/docs/PreProcessing-logs.md)
  * [Registering loggers and logging](/docs/Registering-loggers-and-logging.md)
  * [Transports](/docs/Transports.md)