os.loadAPI('hare')
 
local cliArgs = {...}
local length = tonumber(cliArgs[1])
local width = tonumber(cliArgs[2])

if length == nil or width == nil or cliArgs[1] == '?' then
 print('Uzycie: buildFlor <dlugosc> <szerokosc>')
 return
end

if hare.countInventory() < (length * width) then
error('za malo blokow')
end


function zbudujCzescPodlogi(d)
	for i = 1, d - 1 do
		hare.selectAndPlaceDown()
		turtle.forward()
	end
	hare.selectAndPlaceDown()
end

function go(g)
	for i = 1, g do
		turtle.forward()
	end
end

turtle.up()

local wPrawo = true 

for f = 1, width - 1 do

	zbudujCzescPodlogi(length)
	
	if wPrawo then
		turtle.turnRight()
		turtle.forward()
		turtle.turnRight()
	else
		turtle.turnLeft()
		turtle.forward()
		turtle.turnLeft()
	end
	wPrawo = not wPrawo
end

zbudujCzescPodlogi(length)

if not wPrawo then
	turtle.turnLeft()
	go(width - 1)
	turtle.turnLeft()
	go(length - 1)
	turtle.turnLeft()
	turtle.turnLeft()
else
	turtle.turnRight()
	go(width - 1)
	turtle.turnRight()
end

print('gotowe')