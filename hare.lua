--[[ModuÅ funkcji â program Ala Sweigarta
Zawiera przydatne funkcje.]]
 
-- selectItem() wybiera okienko
-- ekwipunku z podanym przedmiotem i zwraca true,
-- jeÅli go znajdzie, i false w przeciwnym wypadku
function selectItem(name)
 
  -- sprawdÅº wszystkie okienka ekwipunku
  local item
  for slot = 1, 16 do
    item = turtle.getItemDetail(slot)
    if item ~= nil and item['name'] == name then
      turtle.select(slot)
      return true
    end
  end
 
  return false  -- nie moÅ¼na znaleÅºÄ przedmiotu
end
 
 
-- selectEmptySlot() wybiera puste okienko
-- ekwipunku i zwraca true, jeÅli go znajdzie,
-- oraz false, jeÅli nie ma pustych miejsc
function selectEmptySlot()
 
  -- pÄtla przez wszystkie okienka
  for slot = 1, 16 do
    if turtle.getItemCount(slot) == 0 then
      turtle.select(slot)
      return true
    end
  end
  return false -- moÅ¼na znaleÅºÄ pustego miejsca
end
 
 
-- countInventory() zwraca caÅkowitÄ
-- liczbÄ przedmiotÃ³w w ekwipunku
function countInventory()
  local total = 0
 
  for slot = 1, 16 do
    total = total + turtle.getItemCount(slot)
  end
  return total
end
 
 
-- selectAndPlaceDown() wybiera niepuste okienko
-- i umieszcza blok z niego pod Å¼Ã³Åwiem
function selectAndPlaceDown()
 
  for slot = 1, 16 do
    if turtle.getItemCount(slot) > 0 then
      turtle.select(slot)
      turtle.placeDown()
      return
    end
  end
end
 
 
-- buildWall() tworzy ÅcianÄ rozciÄgajÄcÄ siÄ
-- przed Å¼Ã³Åwiem
function buildWall(length, height)
  if hare.countInventory() < length * height then
    return false  -- za maÅo blokÃ³w
  end
 
  turtle.up()
 
  local movingForward = true
 
  for currentHeight = 1, height do
    for currentLength = 1, length do
      selectAndPlaceDown() -- postaw blok
      if movingForward and currentLength ~= length then
        turtle.forward()
      elseif not movingForward and currentLength ~= length then
        turtle.back()
      end
    end
    if currentHeight ~= height then
      turtle.up()
    end
    movingForward = not movingForward
  end
 
  -- budowa Åciany zakoÅczona; przejdÅº na koniec
  if movingForward then
    -- Å¼Ã³Åw jest blisko pozycji poczÄtkowej
    for currentLength = 1, length do
      turtle.forward()
    end
  else
    -- Å¼Ã³Åw jest blisko pozycji koÅcowej
    turtle.forward()
  end
 
  -- zejdÅº na ziemiÄ
  for currentHeight = 1, height do
    turtle.down()
  end
 
  return true
end
 
 
-- buildRoom() buduje cztery Åciany
-- i sufit
function buildRoom(length, width, height)
  if hare.countInventory() < (((length - 1) * height * 2) + ((width - 1) * height * 2)) then
    return false  -- za maÅo blokÃ³w
  end
 
  -- zbuduj cztery Åciany
  buildWall(length - 1, height)
  turtle.turnRight()
 
  buildWall(width - 1, height)
  turtle.turnRight()
 
  buildWall(length - 1, height)
  turtle.turnRight()
 
  buildWall(width - 1, height)
  turtle.turnRight()
 
  return true
end
 
 
-- sweepField() przemieszcza siÄ przez wiersze
-- i kolumny obszaru przed Å¼Ã³Åwiem i po
-- jego prawej stronie, wywoÅujÄc
-- w kaÅ¼dym miejscu podanÄ sweepFunc
function sweepField(length, width, sweepFunc)
  local turnRightNext = true
 
  for x = 1, width do
    for y = 1, length do
      sweepFunc()
 
      -- nie idÅº do przodu w ostatnim wierszu
      if y ~= length then
        turtle.forward()
      end
    end
 
    -- nie obracaj siÄ w ostatniej kolumnie
    if x ~= width then
      -- obrÃ³Ä siÄ do nastÄpnej kolumny
      if turnRightNext then
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
      else
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
      end
 
      turnRightNext = not turnRightNext
    end
  end
 
  -- cofnij siÄ do poczÄtkowego poÅoÅ¼enia
  if width % 2 == 0 then
    turtle.turnRight()
  else
    for y = 1, length - 1 do
      turtle.back()
    end
    turtle.turnLeft()
  end
 
  for x = 1, width - 1 do
    turtle.forward()
  end
  turtle.turnRight()
 
  return true
end
 
 
-- buildFloor() buduje prostokÄtnÄ
-- podÅogÄ z blokÃ³w znajdujÄcych siÄ
-- w ekwipunku
function buildFloor(length, width)
  if countInventory() < length * width then
    return false  -- za maÅo blokÃ³w
  end
 
  turtle.up()
  sweepField(length, width, selectAndPlaceDown)
end
 
 
-- findBlock() obraca Å¼Ã³Åwia wokÃ³Å, szukajÄc
-- nazwanego bloku obok Å¼Ã³Åwia
function findBlock(name)
  local result, block
 
  for i = 1, 4 do
    result, block = turtle.inspect()
    if block ~= nil and block['name'] == name then
      return true
    end
    turtle.turnRight()
  end
  return false
end
 
 
-- digUntilClear() kopie dalej, aÅ¼
-- nie bÄdzie wiÄcej blokÃ³w (uÅ¼ywana gdy
-- piach lub ziemia mogÄ spaÅÄ na ÅcieÅ¼kÄ)
function digUntilClear()
  while turtle.detect() do
    if not turtle.dig() then
      return false
    end
  end
  return true
end
 
-- digUntilClear() kopie dalej, aÅ¼
-- nie bÄdzie wiÄcej blokÃ³w (uÅ¼ywana gdy
-- piach lub ziemia mogÄ spaÅÄ na ÅcieÅ¼kÄ)
function digUpUntilClear()
  while turtle.detectUp() do
    if not turtle.digUp() then
      return false
    end
  end
  return true
end