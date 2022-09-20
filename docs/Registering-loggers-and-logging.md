<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Register loggers for each screen/view/class](#register-loggers-for-each-screenviewclass)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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

