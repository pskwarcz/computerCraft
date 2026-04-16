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

local xd = true

function szachmat()

	if xd then
		hare.selectItem('minecraft:black_wool');
	else
		hare.selectItem('minecraft:white_wool');
	end
	xd = not xd

	turtle.placeDown()
end

hare.sweepField(length, width, szachmat)