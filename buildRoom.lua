os.loadAPI('hare')
 
local cliArgs = {...}
local length = tonumber(cliArgs[1])
local width = tonumber(cliArgs[2])
local height = tonumber(cliArgs[3])
 
if length == nil or width == nil or height == nil or cliArgs[1] == '?' then
 print('Uzycie: buildRoom <dlugosc> <szerokosc> <wysokosc>')
 return
end
 
if hare.buildRoom(length, width, height) == false  then
 error('za malo blokow')
end
print('Gotowe.')