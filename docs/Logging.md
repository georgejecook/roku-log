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
