--[[ Copyright (c) 2009 Peter "Corsix" Cawley

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. --]]

local function action_pickup_interrupt(action, humanoid)
  if action.window then
    action.window:close()
  end
  humanoid.th:makeVisible()
  local room = humanoid:getRoom()
  if room then
    room:onHumanoidEnter(humanoid)
  end
  humanoid:setTimer(1, humanoid.finishAction)
end

local function action_pickup_start(action, humanoid)
  if action.todo_close then
    action.todo_close:close()
  end
  humanoid:setSpeed(0, 0)
  humanoid.th:makeInvisible()
  local room = humanoid:getRoom()
  if room then
    room:onHumanoidLeave(humanoid)
  end
  action.must_happen = true
  action.on_interrupt = action_pickup_interrupt
  local ui = action.ui
  action.window = UIPlaceStaff(ui, humanoid, ui.cursor_x, ui.cursor_y)
  ui:addWindow(action.window)
end

return action_pickup_start