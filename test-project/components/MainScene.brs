function init() as void
  createObject("roSGNode", "TrackerTask")
  m.top.observeField("fire", "onTimerFire")

  m.textIndex = 0
  m.label = m.top.findNode("label")
  configureLabel()
  makeTexts()
  m.label.text = m.texts[0]
end function

function makeTexts()
  text0 = "\n#TITLE1:#"
  text0 += "\n##TITLE2:##"
  text0 += "\n###TITLE3:###"
  text0 += "\n*bold text here*"
  text0 += "\n_italic text here_"
  text0 += "\nregular text"
  text0 += "\nposter 1 ${so1} poster 2 ${so2} poster 3 ${so3}"

  text1 = "#Video ${name}#"
  text1 += "\n##Description:##"
  text1 += "\n###${description}###"
  text1 += "\n\n_runningtime_: *${time}* _rating_: *${rating}*"
  text1 += "\nhere is some more text"
  text1 += "\nposter ${so1} test here ${so2} more text"
  text1 += "\n${so3}"

  text2 = "\n\n#you shoudl watch ${name}#"
  text2 += "\n${so3}"
  text2 += "\n##Description:##"
  text2 += "\n###${description}###"
  text2 += "\n\n*runningtime*: ${time} *rating*: ${rating}"
  text2 += "\nhere is some more text *with bold* normal *italic*"
  text2 += "\nposter ${so1} test here ${so2} more text"

  text3 = "\n#TITLE1:#"
  text3 += "\n##TITLE2:##"
  text3 += "\n###TITLE3:###"
  text3 += "\nposter ${so1} test here ${so2} more text"

  m.texts = [
    text0
    text1
    text2
    text3
  ]
end function


function onTimerFire()
  m.textIndex++
  if m.textIndex = m.texts.count()
    m.textIndex = 0
  end if

  m.label.text = m.texts[m.textIndex]
end function


function configureLabel()
  m.label.allFontSettings = {
    header1Font: {
      name: "font:MediumBoldSystemFont"
      size: 130
    }
    header2Font: {
      name: "font:MediumBoldSystemFont"
      size: 60
    }
    header3Font: {
      name: "font:MediumSystemFont"
      size: 50
    }
    font: {
      name: "font:MediumSystemFont"
      size: 30
    }
    italicFont: {
      name: "font:MediumBoldSystemFont"
      size: 32
    }
    boldFont: {
      name: "font:MediumSystemFont"
      size: 34
  } }

  m.label.values = {
    name: "Jurassic Park"
    description: "Dinosaur antics and jolly good fun"
    time: "1h30m"
    icon: "https:"
    rating: "pg"
    so1: makePoster("so1.png")
    so2: makePoster("so2.png")
    so3: makePoster("so3.png")
  }
end function

function makePoster(name)
  poster = createObject("roSGNode", "Poster")
  poster.width = 40
  poster.height = 40
  poster.uri = "pkg:/images/" + name
  return poster
end function
