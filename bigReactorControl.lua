-----local variables------
--------------------------
--======================--
--------------------------
-----local variables------
 
 
local os = require("os")
local computer = require("computer")
local term = require("term")
local filesystem = require("filesystem")
local component = require("component")
local keyboard = require("keyboard")
local event = require("event")
local gpu = component.gpu
 
local event = require("event")
 
local reactor = component.br_reactor
 
local energyStats = reactor.getEnergyStats() 
local coolantStatus = reactor.getCoolantFluidStats()
 
-----local variables------
--------------------------
--======================--
--------------------------
-----local variables------
 
 
 
 
 
-------functions----------
--------------------------
--======================--
--------------------------
-------functions----------
 
 
-------UI functions-------
--------------------------
--======================--
--------------------------
-------UI functions-------
 
function resetBgColor ()
  gpu.setBackground(colors_black)
end
 
function resetFgColor ()
  gpu.setForeground(colors_white)
end
 
function resetBgColorANDresetFgColor()
  resetFgColor()
  resetBgColor()
end
 
function setBgColor (color)
  gpu.setBackground(color)
end
 
function setFgColor (color)
  gpu.setForeground(color)
end
 
function renderLine(posX, posY, sizeX, sizeY)
  gpu.fill(posX, posY, sizeX, sizeY, " ")
end
 
 
function setCursorPos (posX, posY)
  term.setCursor(posX, posY)
end
 
function renderText(text)
  term.write(text)
end
 
function drawLine(posX, posY, length, highth, line_color)
  local tX, tY = term.getCursor()
  setBgColor (line_color)
  renderLine(posX, posY, length, highth)
  resetBgColor ()
  setCursorPos (tX, tY)
end
 
function drawText(posX, posY, text, textColor, BgColor)
  local tX, tY = term.getCursor()
setCursorPos(posX, posY)
setFgColor(textColor)
setBgColor(BgColor)
renderText(tostring(text))
  setCursorPos (tX, tY)
end
 
function draw_ProgressBar(orientation, posX, posY, sizeX, sizeY,  maxVAlue, value, bgColor, barColor, showValue)
  if orientation == 1 then
   
  local a =  sizeX*(value / maxVAlue)
  local aa = value.."/"..maxVAlue
  local aaa = string.len(aa)
    if showValue == true then
      setBgColor(bgColor)
       renderLine(posX,  posY,  sizeX,  sizeY)
      setBgColor(barColor)
       renderLine(posX,  posY,  math.floor(a),  sizeY)
      setCursorPos( posX+(sizeX/2)-aaa/2,  posY+sizeY+1)
      setBgColor(reactorPowerInfoPanelBgColor)
      setFgColor(colors_lime)
       renderText( aa)
    else
      setBgColor(bgColor)
      renderLine(posX,  posY,  sizeX,  sizeY)
     setBgColor(barColor)
      renderLine(posX,  posY,  math.floor(a),  sizeY)
    end   
  else
    local a =  sizeY*(value / maxVAlue)
    local aa = value.."/"..maxVAlue
    local aaa = string.len(aa)
    if showValue == true then   
      setBgColor(bgColor)
       renderLine(posX,  posY,  sizeX,  sizeY)
      setBgColor(barColor)
       renderLine(posX,  posY+sizeY-math.floor(a), sizeX, math.floor(a))
      setCursorPos( posX+(sizeX/2)-aaa/2,  posY+sizeY+1)
      setBgColor(reactorPowerInfoPanelBgColor)
      setFgColor(colors_lime)
       renderText( aa)
    else
      setBgColor(bgColor)
      renderLine(posX,  posY,  sizeX,  sizeY)
      setBgColor(barColor)
      renderLine(posX,  posY+sizeY-math.floor(a), sizeX, math.floor(a))
    end
  end
end
 
 
function draw_controlRod(posX, posY, rodValue, bGColor)
  local rodCasingX = posX+1
  local rodCasingY = posY+24/2+1
  local fuelColor = colors_yellow
  local rodColor = colors_cyan
  local rodCasingColor = colors_silver
  local displayValue = rodValue / 10
  if rodValue < 10 then
    setBgColor(bGColor)
    renderLine(rodCasingX+2,  posY-10,  1,  10)
    setBgColor(rodCasingColor)
    renderLine(rodCasingX+1,  posY+1,  3,  10)
    setBgColor(fuelColor)
    renderLine(rodCasingX+2,  posY+1,  1,  10)
    setBgColor(rodColor)
    renderLine(rodCasingX+2,  posY-11,  1,  10)
  else
    setBgColor(bGColor)
    renderLine(rodCasingX+2,  posY-10,  1,  10)
    setBgColor(rodCasingColor)
    renderLine(rodCasingX+1,  posY+1,  3,  10)
    setBgColor(fuelColor)
    renderLine(rodCasingX+2,  posY+1,  1,  10)
    setBgColor(rodColor)
    renderLine(rodCasingX+2,  posY-9+(displayValue),  1,  10)
  end
end
 
 
 
 
function draw_ReactorPanel()
 setBgColor(reactorPanelColor)
renderLine(reactorPanelPosX, reactorPanelPosY,  19,  12)
  
draw_controlRod(reactorPanelPosX, reactorPanelPosY, 0, colors_black)
setCursorPos( reactorPanelPosX+3,  reactorPanelPosY+12)
setBgColor(colors_black)
setFgColor(reactorPowerInfoPanelBgColor)
renderText("1")
draw_controlRod(reactorPanelPosX+4, reactorPanelPosY, 0, colors_black)
setCursorPos( reactorPanelPosX+7,  reactorPanelPosY+12)
setBgColor(colors_black)
setFgColor(reactorPowerInfoPanelBgColor)
renderText("2")
 
draw_controlRod(reactorPanelPosX+8, reactorPanelPosY, 0, colors_black)
setCursorPos( reactorPanelPosX+11,  reactorPanelPosY+12)
setBgColor(colors_black)
setFgColor(reactorPowerInfoPanelBgColor)
renderText("3")
draw_controlRod(reactorPanelPosX+12, reactorPanelPosY, 0, colors_black)
setCursorPos( reactorPanelPosX+15,  reactorPanelPosY+12)
setBgColor(colors_black)
setFgColor(reactorPowerInfoPanelBgColor)
renderText("4")
 drawButtons(table_RactorPanelButtons)
end
 
 
function newButton(label, posX, posY, labelColor, buttonColor, showLabel, sizeOveride, sizeX, sizeY, func, funcDATA, buttonTable)
  button = {}
  button.label = label
  button.posX = posX
  button.posY = posY
  button.labelColor = labelColor
  button.buttonColor = buttonColor
  button.showLabel = showLabel
  button.sizeOveride = sizeOveride
  button.sizeX = sizeX
  button.sizeY = sizeY
  button.func = func
  button.funcDATA = funcDATA
table.insert(buttonTable, button)
end
 
function drawButtons(buttonTable)
 
  for i = 1, #buttonTable do
    if buttonTable[i].sizeOveride then
      drawLine(buttonTable[i].posX, buttonTable[i].posY, buttonTable[i].sizeX, buttonTable[i].sizeY, buttonTable[i].buttonColor)
       if buttonTable[i].showLabel then
         
         drawText(buttonTable[i].posX +buttonTable[i].sizeX/2-string.len(buttonTable[i].label)/2, buttonTable[i].posY+ buttonTable[i].sizeY/2, buttonTable[i].label, buttonTable[i].labelColor, buttonTable[i].buttonColor)      
       end
     else
      drawLine(buttonTable[i].posX, buttonTable[i].posY, string.len(buttonTable[i].label)+2, 3, buttonTable[i].buttonColor)
       if buttonTable[i].showLabel then
         drawText(buttonTable[i].posX+1, buttonTable[i].posY+1, buttonTable[i].label, buttonTable[i].labelColor, buttonTable[i].buttonColor)
       else
        drawLine(buttonTable[i].posX, buttonTable[i].posY, string.len(buttonTable[i].label)+2, 3, buttonTable[i].buttonColor)
       end
    end
  end
 
end
 
 
 
 
 
 
 
function draw_reactorFuelInfoPanel ()
  setBgColor(reactorPowerInfoPanelBgColor)
  renderLine( reactorFuelInfoPanelPosX,  reactorFuelInfoPanelPosY,  reactorFuelInfoPanelSizeX,  reactorFuelInfoPanelSizeY)
   setBgColor(colors_gray)
   renderLine( reactorFuelInfoPanelPosX+16,  reactorFuelInfoPanelPosY+2,  30,  3)
   setFgColor(colors_black)
   setCursorPos(reactorFuelInfoPanelPosX+19,  reactorFuelInfoPanelPosY+3)
   renderText("max fuel ")
   setCursorPos(reactorFuelInfoPanelPosX+19+string.len("max fuel       ")+1,  reactorFuelInfoPanelPosY+3)
   renderText(fuelMax)
   setBgColor(colors_yellow)
   renderLine( reactorFuelInfoPanelPosX+16,  reactorFuelInfoPanelPosY+6,  30,  3)
   setFgColor(colors_black)
   setCursorPos(reactorFuelInfoPanelPosX+19,  reactorFuelInfoPanelPosY+7)
   renderText("current fuel ")
   setCursorPos(reactorFuelInfoPanelPosX+19+string.len("current fuel   ")+1,  reactorFuelInfoPanelPosY+7)
   renderText(fuelAmount)
   setBgColor(colors_cyan)
   renderLine( reactorFuelInfoPanelPosX+16,  reactorFuelInfoPanelPosY+10,  30,  3)
   setFgColor(colors_black)
   setCursorPos(reactorFuelInfoPanelPosX+19,  reactorFuelInfoPanelPosY+11)
   renderText("current waste ")
   setCursorPos(reactorFuelInfoPanelPosX+19+string.len("current waste  ")+1,  reactorFuelInfoPanelPosY+11)
   renderText(wasteAmount) 
  draw_FuelBar()
end
 
 
 
 
 
 
 
 
 
 
 
function draw_MainPanel()
  setBgColor(mainPanelPrimaryColor)
  renderLine(mainPanelPosX,  mainPanelPosY,  mainPanelSizeX,  mainPanelSizeY)
    setBgColor(mainPanelSecondaryColor)
  renderLine( mainPanelPosX+1,  mainPanelPosY+1,  mainPanelSizeX-2,  1)
  renderLine( mainPanelPosX+(mainPanelSizeX-3),  mainPanelPosY+2,  2,  1)
  
  renderLine( mainPanelPosX+1,  mainPanelPosY+mainPanelSizeY-2,  mainPanelSizeX-2,  1)
  renderLine( mainPanelPosX+1,  mainPanelPosY+mainPanelSizeY-3,  2,  1)
end
 
-------UI functions-------
--------------------------
--======================--
--------------------------
-------UI functions-------
 
 
-----global variables-----
--------------------------
--======================--
--------------------------
-----global variables-----
 
 
---------colors-----------
--------------------------
--======================--
--------------------------
---------colors-----------
 
 
colors_white = 0xffffff
colors_orange = 0xff6600
colors_magenta = 0xff00ff
colors_lightblue = 0x0099ff
colors_yellow = 0xffff00
colors_lime = 0x00ff00
colors_pink = 0xff3399
colors_gray = 0x737373
colors_lightgray = 0xa5a5a5
colors_silver = 0xc0c0c0
colors_cyan = 0x169c9d
colors_purple = 0x8932b7
colors_blue = 0x3c44a9
colors_brown = 0x825432
colors_green = 0x5d7c15
colors_red = 0xb02e26
colors_lightred = 0xffcccb
colors_black = 0x000000
 
 
 
---------colors-----------
--------------------------
--======================--
--------------------------
---------colors-----------
 
 
function init_reactorVariables()
  reactorVariable = {}
  reactorVariable.energyStats = {}
   reactorVariable.energyStats.temp = reactor.getEnergyStats()
     
  reactorVariable.energyStats.energyProduced = reactorVariable.energyStats.temp.energyProducedLastTick
   reactorVariable.energyStats.energyStored = reactorVariable.energyStats.temp.energyStored
    reactorVariable.energyStats.energyCapacity = reactorVariable.energyStats.temp.energyCapacity
  reactorVariable.controlRodStats = {}
   reactorVariable.controlRodStats.numberOfControlRods = reactor.getNumberOfControlRods()
    reactorVariable.controlRodStats.controlRodLevels = {}
     for i = 0 , reactorVariable.controlRodStats.numberOfControlRods-1 do
       temp1 = reactor.getControlRodLevel(i)
       table.insert(reactorVariable.controlRodStats.controlRodLevels, temp1)      
     end
  reactorVariable.fuelStats = {}
  reactorVariable.fuelStats.temp = reactor.getFuelStats()
 
   reactorVariable.fuelStats.fuelTemp = reactorVariable.fuelStats.temp.fuelTemperature
    reactorVariable.fuelStats.maxFuel = reactorVariable.fuelStats.temp.fuelCapacity
     reactorVariable.fuelStats.fuelReactivity = reactorVariable.fuelStats.temp.fuelReactivity
      reactorVariable.fuelStats.wasteAmount = reactorVariable.fuelStats.temp.wasteAmount
      reactorVariable.fuelStats.fuelAmount = reactorVariable.fuelStats.temp.fuelAmount
  reactorVariable.temperatures = {}
   reactorVariable.temperatures.casingTemp = reactor.getCasingTemperature()
end
 
 
function init_ReactorPanel()
  reactorPanelPosX = 10
  reactorPanelPosY = 30
  reactorPanelSizeX = 22
  reactorPanelSizeY = 23
  reactorPanelColor = colors_gray
  table_RactorPanelButtons = {}
  newButton("1",  reactorPanelPosX+3,  reactorPanelPosY+13,  colors_black,  reactorPowerInfoPanelBgColor,  false,  true,  1,  1,  testingFunction,  "funcDATA",  table_RactorPanelButtons)
  newButton("2",  reactorPanelPosX+7,  reactorPanelPosY+13,  colors_black,  reactorPowerInfoPanelBgColor,  false,  true,  1,  1,  testingFunction,  "funcDATA",  table_RactorPanelButtons)
  newButton("3",  reactorPanelPosX+11,  reactorPanelPosY+13,  colors_black,  reactorPowerInfoPanelBgColor,  false,  true,  1,  1,  testingFunction,  "funcDATA",  table_RactorPanelButtons)
  newButton("4",  reactorPanelPosX+15,  reactorPanelPosY+13,  colors_black,  reactorPowerInfoPanelBgColor,  false,  true,  1,  1,  testingFunction,  "funcDATA",  table_RactorPanelButtons)
  
end
 
 
 
---------energy-----------
--------------------------
--======================--
--------------------------
---------energy-----------
 
function init_reactorPowerInfoPanel()
  onThresh = 0.75
  offThresh = 0.95
 reactorPowerInfoPanelPosX = 15
 reactorPowerInfoPanelPosY = 8
 reactorPowerInfoPanelSizeX = 125
 reactorPowerInfoPanelSizeY = 8
 
 reactorPowerInfoPanelPosX2 = 66
 reactorPowerInfoPanelPosY2 = 16
 reactorPowerInfoPanelSizeX2 = 23
 reactorPowerInfoPanelSizeY2 = 6
 
 manualControl = false
 
 reactorPowerInfoPanelBgColor = colors_blue
 simpleAutoAdjButtons = {}
 overrideButtons = {}
 
  newButton("<",  reactorPowerInfoPanelPosX2+2,  reactorPowerInfoPanelPosY2+2,  colors_black,  colors_lime,  true,  true,  3,  1,  subtractFromOnThresh,  _,  simpleAutoAdjButtons)
  newButton(">",  reactorPowerInfoPanelPosX2+18,  reactorPowerInfoPanelPosY2+2,  colors_black,  colors_lime,  true,  true,  3,  1,  addToOnThresh,  _,  simpleAutoAdjButtons)
  newButton("<",  reactorPowerInfoPanelPosX2+2,  reactorPowerInfoPanelPosY2+4,  colors_black,  colors_red,  true,  true,  3,  1, subtractFromOffThresh,  _,  simpleAutoAdjButtons)
  newButton(">",  reactorPowerInfoPanelPosX2+18,  reactorPowerInfoPanelPosY2+4,  colors_black,  colors_red,  true,  true,  3,  1,  addToOffThresh,  _,  simpleAutoAdjButtons)
  newButton("manual override",  reactorPowerInfoPanelPosX2+1,  reactorPowerInfoPanelPosY2+19,  colors_black,  colors_gray,  true,  true,  21,  3,  manualControlToggle,  "funcDATA",  overrideButtons)
end
 
function draw_reactorPowerInfoPanel()
  local energyStored = reactorVariable.energyStats.energyStored
  local maxEnergy = reactorVariable.energyStats.energyCapacity
  local a = "current power / max power"
  setBgColor(reactorPowerInfoPanelBgColor)
  renderLine( reactorPowerInfoPanelPosX,  reactorPowerInfoPanelPosY,  reactorPowerInfoPanelSizeX,  reactorPowerInfoPanelSizeY)
  renderLine( reactorPowerInfoPanelPosX2,  reactorPowerInfoPanelPosY2,  reactorPowerInfoPanelSizeX2,  reactorPowerInfoPanelSizeY2)
 
 
 
  setBgColor(colors_black)
  renderLine( reactorPowerInfoPanelPosX2,  reactorPowerInfoPanelPosY2+18,  23,  8)
  setBgColor(colors_silver)
  renderLine( reactorPowerInfoPanelPosX2,  reactorPowerInfoPanelPosY2+18,  23,  5)
 
  setBgColor(reactorFuelInfoPanelBgColor)
  setFgColor(colors_lime)
  setCursorPos(reactorPowerInfoPanelPosX+(reactorPowerInfoPanelSizeX/2)-(string.len(a)/2),  reactorPowerInfoPanelPosY+1)
  renderText(a)
  draw_ProgressBar(1, reactorPowerInfoPanelPosX+2,  reactorPowerInfoPanelPosY+2,  reactorPowerInfoPanelSizeX-4,  reactorPowerInfoPanelSizeY-4,  maxEnergy,  energyStored, colors_lightred, colors_green, true)
  
  setBgColor(colors_lime)
  renderLine(reactorPowerInfoPanelPosX2+5,  reactorPowerInfoPanelPosY2+2,  13,  1)
  setCursorPos(reactorPowerInfoPanelPosX2+10,  reactorPowerInfoPanelPosY2+2)
  setBgColor(colors_black)
  renderText(tostring(onThresh*100).."%")
 
  setBgColor(colors_red)
  renderLine(reactorPowerInfoPanelPosX2+5,  reactorPowerInfoPanelPosY2+4,  13,  1)
  setCursorPos(reactorPowerInfoPanelPosX2+10,  reactorPowerInfoPanelPosY2+4)
  setBgColor(colors_black)
  renderText(tostring(offThresh*100).."%")
  drawButtons(simpleAutoAdjButtons)
  drawButtons(overrideButtons)
end
 
function upDateReactorPowerInfoPanel()
  reactorVariable.energyStats.temp = reactor.getEnergyStats()   
   reactorVariable.energyStats.energyProduced = reactorVariable.energyStats.temp.energyProducedLastTick
    reactorVariable.energyStats.energyStored = reactorVariable.energyStats.temp.energyStored
     reactorVariable.energyStats.energyCapacity = reactorVariable.energyStats.temp.energyCapacity
     maxEnergy = reactorVariable.energyStats.energyCapacity
     energyStored = reactorVariable.energyStats.energyStored
 
     setBgColor(colors_lime)
     renderLine(reactorPowerInfoPanelPosX2+5,  reactorPowerInfoPanelPosY2+2,  13,  1)
     setCursorPos(reactorPowerInfoPanelPosX2+10,  reactorPowerInfoPanelPosY2+2)
     setBgColor(colors_lime)
     renderText(tostring(onThresh*100).."%")
 
     setBgColor(colors_red)
     renderLine(reactorPowerInfoPanelPosX2+5,  reactorPowerInfoPanelPosY2+4,  13,  1)
     setCursorPos(reactorPowerInfoPanelPosX2+10,  reactorPowerInfoPanelPosY2+4)
     setBgColor(colors_red)
     renderText(tostring(offThresh*100).."%")
     draw_ProgressBar(1, reactorPowerInfoPanelPosX+2,  reactorPowerInfoPanelPosY+2,  reactorPowerInfoPanelSizeX-4,  reactorPowerInfoPanelSizeY-4,  maxEnergy,  energyStored, colors_lightred, colors_green, true)
end
 
---------energy-----------
--------------------------
--======================--
--------------------------
---------energy-----------
 
 
 
-----------fuel-----------
--------------------------
--======================--
--------------------------
-----------fuel-----------
 
function init_fuelBar()
  fuelBarPosX = reactorFuelInfoPanelPosX+4
  fuelBarPosY = reactorFuelInfoPanelPosY+2
  fuelBarSizeX = 7
  fuelBarSizeY = reactorFuelInfoPanelSizeY - 5
 
  reactorVariable.fuelStats.temp = reactor.getFuelStats()
 
   reactorVariable.fuelStats.fuelTemp = reactorVariable.fuelStats.temp.fuelTemperature
    reactorVariable.fuelStats.maxFuel = reactorVariable.fuelStats.temp.fuelCapacity
     reactorVariable.fuelStats.fuelReactivity = reactorVariable.fuelStats.temp.fuelReactivity
  fuelMax = reactorVariable.fuelStats.maxFuel
  fuelAmount = reactorVariable.fuelStats.fuelAmount
  wasteAmount = reactorVariable.fuelStats.wasteAmount
end
 
function init_reactorFuelInfoPanel()
  reactorFuelInfoPanelPosX = 15
  reactorFuelInfoPanelPosY = 17
  reactorFuelInfoPanelSizeX = 50
  reactorFuelInfoPanelSizeY = 25
  reactorFuelInfoPanelBgColor = colors_blue
  ejectWasteButton = {}
  newButton("ejectWaste",  reactorFuelInfoPanelPosX+15,  reactorFuelInfoPanelPosY+16,  colors_black,  colors_gray,  true,  false,  8,  3,  ejectWaste,  _,  ejectWasteButton)
  init_fuelBar()
end
 
function draw_FuelBar()
  local a =  fuelBarSizeY*(fuelAmount / fuelMax)
  local aa = fuelBarSizeY*(wasteAmount / fuelMax)
  setBgColor(colors_gray)
  renderLine(fuelBarPosX, fuelBarPosY+1, fuelBarSizeX, fuelBarSizeY-1)
  setBgColor(colors_yellow)
  renderLine(fuelBarPosX, fuelBarPosY+fuelBarSizeY-math.floor(a), fuelBarSizeX, math.floor(a))
  setBgColor(colors_cyan)
  renderLine(fuelBarPosX, fuelBarPosY+fuelBarSizeY-math.floor(aa), fuelBarSizeX, math.floor(aa))
  setCursorPos(fuelBarPosX, fuelBarPosY+fuelBarSizeY)
  drawButtons(ejectWasteButton)
end
 
function updateFuelInfo()
 
  reactorVariable.fuelStats.temp = reactor.getFuelStats()
   reactorVariable.fuelStats.fuelTemp = reactorVariable.fuelStats.temp.fuelTemperature
    reactorVariable.fuelStats.maxFuel = reactorVariable.fuelStats.temp.fuelCapacity
     reactorVariable.fuelStats.fuelReactivity = reactorVariable.fuelStats.temp.fuelReactivity
  fuelMax = reactorVariable.fuelStats.maxFuel
  fuelAmount = reactorVariable.fuelStats.fuelAmount
  wasteAmount = reactorVariable.fuelStats.wasteAmount
  local a =  fuelBarSizeY*(fuelAmount / fuelMax)
  local aa = fuelBarSizeY*(wasteAmount / fuelMax)
 
  setBgColor(colors_gray)
  renderLine(fuelBarPosX, fuelBarPosY+1, fuelBarSizeX, fuelBarSizeY-1)
  setBgColor(colors_yellow)
  renderLine(fuelBarPosX, fuelBarPosY+fuelBarSizeY-math.floor(a)-math.floor(aa), fuelBarSizeX, math.floor(a))
  setBgColor(colors_cyan)
  renderLine(fuelBarPosX, fuelBarPosY+fuelBarSizeY-math.floor(aa), fuelBarSizeX, math.floor(aa))
  setCursorPos(fuelBarPosX, fuelBarPosY+fuelBarSizeY)
  
 
  setBgColor(colors_gray)
  setFgColor(colors_black)
  
  setCursorPos(reactorFuelInfoPanelPosX+19+string.len("max fuel       ")+1,  reactorFuelInfoPanelPosY+3)
  renderText(fuelMax)
 
  setBgColor(colors_cyan)
  setFgColor(colors_black)
 
  renderLine( reactorFuelInfoPanelPosX+19+string.len("current waste  ")+1,  reactorFuelInfoPanelPosY+11,  11,  1)
  setCursorPos(reactorFuelInfoPanelPosX+19+string.len("current waste  ")+1,  reactorFuelInfoPanelPosY+11)
  renderText(wasteAmount)
 
  setBgColor(colors_yellow)
  setFgColor(colors_black)
  renderLine( reactorFuelInfoPanelPosX+19+string.len("current fuel   ")+1,  reactorFuelInfoPanelPosY+7,  11,  1)
  setCursorPos(reactorFuelInfoPanelPosX+19+string.len("current fuel   ")+1,  reactorFuelInfoPanelPosY+7)
  renderText(fuelAmount)
 
end
 
-----------fuel-----------
--------------------------
--======================--
--------------------------
-----------fuel-----------
 
 
---------output-----------
--------------------------
--======================--
--------------------------
---------output-----------
 
function init_reactorOutputPanel ()
  reactorOutputPanelPosX = reactorPowerInfoPanelPosX2
  reactorOutputPanelPosY = reactorPowerInfoPanelPosY2+7
  reactorOutputPanelSizeX = 23
  reactorOutputPanelSizeY = 6
 
  reactorEnergyOutput = reactorVariable.energyStats.energyProduced
  fuelReactivity = reactorVariable.fuelStats.fuelReactivity
 
end
 
 
function draw_reactorOutputPanel()
 
  
 setBgColor(colors_lime)
 renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY,  reactorOutputPanelSizeX,  4)
 setCursorPos( reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len("fuel reactivity")/2,  reactorOutputPanelPosY+1)
 setFgColor(colors_black)
 renderText("fuel reactivity")
 
 
 renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY+2,  reactorOutputPanelSizeX,  1)
 setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len(tostring(math.floor(fuelReactivity)))/2,  reactorOutputPanelPosY+2)
 renderText(math.floor(fuelReactivity))
 
 setBgColor(colors_orange)
 renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY+5,  reactorOutputPanelSizeX,  5)
 setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len("energy outut")/2,  reactorOutputPanelPosY+6)
 renderText("energy outut")
 
 
 setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len(math.floor(reactorEnergyOutput))/2,  reactorOutputPanelPosY+7)
 renderText(math.floor(reactorEnergyOutput))
 setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len("RF per TICK")/2,  reactorOutputPanelPosY+8)
 renderText("RF per TICK")
end
 
function upDate_reeactorOutPutPanel()
 
    reactorEnergyOutput = reactorVariable.energyStats.energyProduced
 
 
    fuelReactivity = reactorVariable.fuelStats.fuelReactivity
 
  setBgColor(colors_lime)
  renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY+5,  reactorOutputPanelSizeX,  5)
  renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY+2,  reactorOutputPanelSizeX,  1)
  setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len(tostring(math.floor(fuelReactivity)).." %")/2,  reactorOutputPanelPosY+2)
  renderText(math.floor(fuelReactivity).." %")
 
  
   if isReactorActive() then
  setBgColor(colors_orange)
  renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY+5,  reactorOutputPanelSizeX,  5)
  setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len("energy outut")/2,  reactorOutputPanelPosY+6)
  renderText("energy outut")
 
  renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY+7,  reactorOutputPanelSizeX,  1)
  setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len(math.floor(reactorEnergyOutput))/2,  reactorOutputPanelPosY+7)
  renderText(math.floor(reactorEnergyOutput))
  setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len("RF per TICK")/2,  reactorOutputPanelPosY+8)
  renderText("RF per TICK")
   else
  setBgColor(colors_gray)
  renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY+5,  reactorOutputPanelSizeX,  5)
  renderLine( reactorOutputPanelPosX,  reactorOutputPanelPosY+7,  reactorOutputPanelSizeX,  1)
  setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len("energy outut")/2,  reactorOutputPanelPosY+6)
  renderText("energy outut")
  setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len(math.floor(reactorEnergyOutput))/2,  reactorOutputPanelPosY+7)
  renderText(math.floor(reactorEnergyOutput))
  setCursorPos(reactorOutputPanelPosX+reactorOutputPanelSizeX/2-string.len("RF per TICK")/2,  reactorOutputPanelPosY+8)
  renderText("RF per TICK")
   end
end
 
---------output-----------
--------------------------
--======================--
--------------------------
---------output-----------
 
-----------temp-----------
--------------------------
--======================--
--------------------------
-----------temp-----------
 
 
function init_reactorTempPanel()
  reactorTempPanelPosX = 90
  reactorTempPanelPosY = 17
  reactorTempPanelSizeX = 50
  reactorTempPanelSizeY = 25
  reactorTempPanelBgColor = colors_blue
end
 
function draw_reactorTempPanel()
  fuelTemp = reactorVariable.fuelStats.fuelTemp
  caseTemp = reactorVariable.temperatures.casingTemp
  sVar1 = math.floor(fuelTemp).."  C"
  sVar2 = math.floor(caseTemp).."  C"
 setBgColor(reactorTempPanelBgColor)
 renderLine(reactorTempPanelPosX,  reactorTempPanelPosY,  reactorTempPanelSizeX,  reactorTempPanelSizeY)
 setCursorPos( reactorTempPanelPosX+10,  reactorTempPanelPosY)
 renderText("CORE")
 setCursorPos( reactorTempPanelPosX+10,  reactorTempPanelPosY+1)
 renderText("TEMP")
 setCursorPos( reactorTempPanelPosX+4+8-(string.len(sVar1)/2),  reactorTempPanelPosY+reactorTempPanelSizeY-2)
 renderText(sVar1)
 setCursorPos( reactorTempPanelPosX+4+16+17,  reactorTempPanelPosY)
 renderText("CASING")
 setCursorPos( reactorTempPanelPosX+4+16+18,  reactorTempPanelPosY+1)
 renderText("TEMP")
 setCursorPos( reactorTempPanelPosX+16+17+8-(string.len(sVar2)/2),  reactorTempPanelPosY+reactorTempPanelSizeY-2)
 renderText(sVar2)
 draw_ProgressBar(2,  reactorTempPanelPosX+4,  reactorTempPanelPosY+2,  16,  reactorTempPanelSizeY-4,  2000,  math.floor(fuelTemp),  colors_gray,  colors_green, false)
 
 draw_ProgressBar(2,  reactorTempPanelPosX+4+16+12,  reactorTempPanelPosY+2,  16,  reactorTempPanelSizeY-4,  2000,  math.floor(caseTemp),  colors_gray,  colors_green, false)
 
end
 
function upDateReactorTempPanel()
  fuelTemp = reactorVariable.fuelStats.fuelTemp
  caseTemp = reactorVariable.temperatures.casingTemp
  sVar1 = math.floor(fuelTemp).."  C"
  sVar2 = math.floor(caseTemp).."  C"
   
  setBgColor(reactorPowerInfoPanelBgColor)
  setFgColor(colors_black)
  
  renderLine( reactorTempPanelPosX,  reactorTempPanelPosY+reactorTempPanelSizeY-2,  reactorTempPanelSizeX,  1)
 
   setCursorPos( reactorTempPanelPosX+16+17+8-(string.len(sVar2)/2),  reactorTempPanelPosY+reactorTempPanelSizeY-2)
   renderText(sVar2)
  
  setBgColor(reactorPowerInfoPanelBgColor)
  setFgColor(colors_black)
   setCursorPos( reactorTempPanelPosX+4+8-(string.len(sVar1)/2),  reactorTempPanelPosY+reactorTempPanelSizeY-2)
   renderText(sVar1)
  if math.floor(fuelTemp) >1000 then
    draw_ProgressBar(2,  reactorTempPanelPosX+4,  reactorTempPanelPosY+2,  16,  reactorTempPanelSizeY-4,  2000,  math.floor(fuelTemp),  colors_gray,  colors_orange, false)
  else 
    draw_ProgressBar(2,  reactorTempPanelPosX+4,  reactorTempPanelPosY+2,  16,  reactorTempPanelSizeY-4,  2000,  math.floor(fuelTemp),  colors_gray,  colors_green, false)
  end
   draw_ProgressBar(2,  reactorTempPanelPosX+4+16+12,  reactorTempPanelPosY+2,  16,  reactorTempPanelSizeY-4,  2000,  math.floor(caseTemp),  colors_gray,  colors_green, false)
  
end
 
-----------temp-----------
--------------------------
--======================--
--------------------------
-----------temp-----------
 
 
function init_mainPanel()
   resolutionX, resolutionY = gpu.getResolution()
  mainPanelPosX = 2
  mainPanelPosY = 2
  mainPanelSizeX = resolutionX-2
  mainPanelSizeY = resolutionY-2
  mainPanelPrimaryColor = colors_black
  mainPanelSecondaryColor = colors_orange
  mainPanelButtons = {}
 
end
 
 
 
 
 
 
 
 
 
-----global variables-----
--------------------------
--======================--
--------------------------
-----global variables-----
 
 
 
 
 
---processing functions---
--------------------------
--======================--
--------------------------
---processing functions---
 
function addToOnThresh()
  
  if onThresh < 1 and onThresh < offThresh-0.05 then
    onThresh = onThresh+0.05
  end
end
 
function subtractFromOnThresh()
  if onThresh > 0.06 then
   onThresh = onThresh-0.05
  end
end
 
function addToOffThresh()
  if offThresh < 1 then
   offThresh = offThresh+0.05
  end
end
 
function subtractFromOffThresh()
  if offThresh > 0.06 and offThresh > onThresh+0.05 then
   offThresh = offThresh-0.05
  end
end
 
function simpleAutoReactorContol()
  if not manualControl then 
   if reactorVariable.energyStats.energyStored < reactorVariable.energyStats.energyCapacity * onThresh then
    activateReactor ()
   elseif reactorVariable.energyStats.energyStored > reactorVariable.energyStats.energyCapacity * offThresh then
    deactivateReactor ()
   end
  end
end
 
 
function testingFunction(text)
 
end
 
function activateReactor ()
  reactor.setActive(true)
  if manualControl then
  overrideButtons = {}
  newButton("auto control",  reactorPowerInfoPanelPosX2+1,  reactorPowerInfoPanelPosY2+19,  colors_black,  colors_gray,  true,  true,  21,  3,  manualControlToggle,  "funcDATA",  overrideButtons)
  newButton("deactivate reactor",  reactorPowerInfoPanelPosX2+1,  reactorPowerInfoPanelPosY2+23,  colors_black,  colors_gray,  true,  true,  21,  3,  deactivateReactor,  "funcDATA",  overrideButtons)
  drawButtons(overrideButtons)
  end
end
 
function isReactorActive()
  t = reactor.getActive()
  return t
end
 
 
function deactivateReactor ()
  reactor.setActive(false)
  if manualControl then
  overrideButtons = {}
  newButton("auto control",  reactorPowerInfoPanelPosX2+1,  reactorPowerInfoPanelPosY2+19,  colors_black,  colors_gray,  true,  true,  21,  3,  manualControlToggle,  "funcDATA",  overrideButtons)
  newButton("activate reactor",  reactorPowerInfoPanelPosX2+1,  reactorPowerInfoPanelPosY2+23,  colors_black,  colors_gray,  true,  true,  21,  3,  deactivateReactor,  "funcDATA",  overrideButtons)
  drawButtons(overrideButtons)
  end
end
 
function ejectWaste()
 reactor.doEjectWaste()
end
 
function manualControlToggle()
 
 manualControl = not manualControl
  if manualControl then
    setBgColor(colors_black)
    renderLine( reactorPowerInfoPanelPosX2,  reactorPowerInfoPanelPosY2+18,  23,  8)
    setBgColor(colors_silver)
    renderLine( reactorPowerInfoPanelPosX2,  reactorPowerInfoPanelPosY2+18,  23,  8)
    overrideButtons = {}
    newButton("auto control",  reactorPowerInfoPanelPosX2+1,  reactorPowerInfoPanelPosY2+19,  colors_black,  colors_gray,  true,  true,  21,  3,  manualControlToggle,  "funcDATA",  overrideButtons)
    newButton("activate reactor",  reactorPowerInfoPanelPosX2+1,  reactorPowerInfoPanelPosY2+23,  colors_black,  colors_gray,  true,  true,  21,  3,  activateReactor,  "funcDATA",  overrideButtons)
  else
    setBgColor(colors_black)
    renderLine( reactorPowerInfoPanelPosX2,  reactorPowerInfoPanelPosY2+23,  23,  3)
    setBgColor(colors_silver)
    renderLine( reactorPowerInfoPanelPosX2,  reactorPowerInfoPanelPosY2+18,  23,  5)
    overrideButtons = {}
    newButton("manual override",  reactorPowerInfoPanelPosX2+1,  reactorPowerInfoPanelPosY2+19,  colors_black,  colors_gray,  true,  true,  21,  3,  manualControlToggle,  "funcDATA",  overrideButtons)
    
  end
  drawButtons(overrideButtons)
end
 
function listenForEvent() 
  local eventName, address, posX, posY, temp5, user = event.pull(0.2)
     if eventName == "touch" then
      loopThruButtons(mainPanelButtons, posX, posY)
      loopThruButtons(simpleAutoAdjButtons, posX, posY)
      loopThruButtons(overrideButtons, posX, posY) 
      loopThruButtons(ejectWasteButton, posX, posY)
     end
end
 
function removeAllButtons(buttonTable)
  buttonTable = {}
end
 
function loopThruButtons(butonTable, posX, posY)
    t = false
  for i = 1, #butonTable do
    local buttonX = (posX >= butonTable[i].posX and posX < butonTable[i].posX + butonTable[i].sizeX)  
    local buttonY = (posY >= butonTable[i].posY and posY < butonTable[i].posY + butonTable[i].sizeY)  
    local buttonX_02 = (posX >= butonTable[i].posX and posX < butonTable[i].posX + string.len(butonTable[i].label)) 
    local buttonY_02 = (posY >= butonTable[i].posY and posY < butonTable[i].posY + 3)
    if butonTable[i].sizeOveride then
      if buttonX and buttonY and t == false then  
        butonTable[i].func(butonTable[i].funcDATA)
        t = true
      end
    elseif not butonTable[i].sizeOveride and buttonX_02 and buttonY_02 and t == false then
      butonTable[i].func(butonTable[i].funcDATA)
      t = true
    end
  end
end
 
---processing functions---
--------------------------
--======================--
--------------------------
---processing functions---
 
 
 
 
 
 
 
 
 
 
 
 
term.clear()
 
init_reactorVariables()
init_ReactorPanel()
init_mainPanel()
 
init_reactorPowerInfoPanel()
 
 
 
init_reactorFuelInfoPanel()
init_reactorTempPanel()
 
init_reactorOutputPanel ()
 
 
 
draw_MainPanel()
 
draw_reactorPowerInfoPanel()
 
draw_reactorFuelInfoPanel ()
 
draw_reactorTempPanel()
--draw_FuelBar()
--draw_ReactorPanel()
 
draw_reactorOutputPanel()
 
 
 
while true do
  init_reactorVariables()
  upDateReactorPowerInfoPanel()
  updateFuelInfo()
  upDateReactorTempPanel()
  listenForEvent()
  simpleAutoReactorContol()
  upDate_reeactorOutPutPanel()
 
 
end
 
