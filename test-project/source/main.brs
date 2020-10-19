sub Main(args as dynamic)
  InitScreen()
end sub


function InitScreen() as void
  screen = CreateObject("roSGScreen")
  m.port = CreateObject("roMessagePort")
  screen.setMessagePort(m.port)

  rootScene = screen.CreateScene("MainScene")
  rootScene.id = "ROOT"

  screen.show()

  while(true)
    msg = wait(0, m.port)
    msgType = type(msg)

    if msgType = "roSGScreenEvent"
      if msg.isScreenClosed() 
        return
      end if
    end if
  end while
end function
