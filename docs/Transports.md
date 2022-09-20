<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Configuring transports](#configuring-transports)
  - [ScreenTransport:](#screentransport)
  - [HTTPTransport](#httptransport)
    - [Simple express logger:](#simple-express-logger)
  - [Custom transports](#custom-transports)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Transports are responsible for managing the logged lines of text. 
roku-log ships with the following:

 - log_PrintTransport - prints to telnet output
 - log_ScreenTransport - prints to an overlaid screen view
 - log_NodeTransport - prints to a node, you can check in RALE
 - log_HTTPTransport - posts logs as json lines, to a http url

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
