--[[LOVE2D Console by Someguynamedpie (https://love2d.org/forums/memberlist.php?mode=viewprofile&u=1081), released on LOVE2D Forums (https://love2d.org/forums/viewtopic.php?f=5&t=3223).]]

Console={}
Console.lines={}
Console.isOpen=false
Console.isEnabled=false
Console.text=""
function Console:WriteLine(txt,r,g,b)
   local height=love.graphics.getHeight()
   r=r or 255 g=g or 255 b=b or 255
   if(#Console.lines>(height/16)-2) then table.remove(Console.lines,1) end
   table.insert(Console.lines,{txt,{r,g,b}})
   return Console
end
function Console:Open()
   if not Console.isEnabled then return Console end
   Console.isOpen=true
   return Console
end
function Console:Close()
   Console.isOpen=false
   return Console
end
function Console:SetOpen(open)
   if not Console.isEnabled then return end
   Console.isOpen=open
   return Console
end
function Console:IsOpen()
   if not Console.isEnabled then return false end
   return Console.isOpen
end
function Console:Toggle()
   if not Console.isEnabled then return end
   Console.isOpen=not Console.isOpen
   return Console
end
function Console:Disable()
   Console.isEnabled=false
   return Console
end
function Console:Enable()
   Console.isEnabled=true
   return Console
end
function Console:SetEnabled(enabled)
   Console.isEnabled=enabled
   return Console
end
function Console:Init()
   local od=love.draw or function() end
   local okp=love.keypressed or function() end
   function love.draw(...)
      local height=love.graphics.getHeight()
      local width=love.graphics.getWidth()
      od(...)
      if(not Console:IsOpen()) then return end
      love.graphics.setColor(126,126,126,126)
      love.graphics.rectangle("fill",0,0,width,height)
      for k,v in pairs(Console.lines) do
         love.graphics.setColor(unpack(v[2]))
         love.graphics.print(v[1] or "",0,k*16-16)
      end
      love.graphics.setColor(255,255,255)
      love.graphics.line(0,height-16,width,height-16)
      love.graphics.setColor(255,255,255)
      love.graphics.print(Console.text,0,height-16)
   end
   function love.keypressed(k,u)
      if(k=="`") then Console:Toggle() return end
      if(not Console:IsOpen()) then okp(k,u) return end
      if(k=="backspace") then Console.text=string.sub(Console.text,1,#Console.text-1) return end
      if(u==13 and #Console.text>0) then
         s,e,r2,r3,r4=pcall(function() loadstring(Console.text)() end)
         if(s) then
            if(e) then
               Console:WriteLine(e,math.random(255),255,math.random(255))
            end
         else
            Console:WriteLine(e,255,0,0)
         end
         Console.text=""
         return
      end
      if(u~=0) then
         Console.text=Console.text..string.char(u)
      end
   end
   return Console
end
function print(txt)
   Console:WriteLine(tostring(txt))
end