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

hare.sweepField(length, width, hare.selectAndPlaceDown)