-- 
--  This is file `test-modutils.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luatexbase-modutils.dtx  (with options: `testdummy')
--  
--  Written in 2009, 2010 by Manuel Pegourie-Gonnard and Elie Roux.
--  
--  This work is under the CC0 license.
--  See source file 'luatexbase-modutils.dtx' for details.
--  
local err, warn, info, log = luatexbase.provides_module {
  name        = 'test-modutils',
  date        = '2000/01/01',
  version     = 1,
  description = 'dummy test package',
}
info('It works!\nOh, rly?\nYeah rly!')
log("I'm a one-line info.")
-- 
--  End of File `test-modutils.lua'.
