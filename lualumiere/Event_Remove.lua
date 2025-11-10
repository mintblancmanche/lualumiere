--[[
ScenEdit_RunScript ("lualumiere/Event_Remove.lua")
Event_RemoveEvent(eventName)

Event_RemoveTrigger(triggerName)
Event_RemoveAction(actionName)
]]

function Event_RemoveEvent(eventName)
	local unit = ScenEdit_GetUnit({name= "Nemo"})

	if eventAry ~= nil then
		print("Yes - Event Exists")
		ScenEdit_SetEvent(eventName, {mode = "remove"})
	else
		print("No - Event Does Not Exist")
	end
end




function Event_RemoveEvent(eventName)
	local eventAry = ScenEdit_GetEvent(eventName)

	if eventAry ~= nil then
		print("Yes - Event Exists")
		ScenEdit_SetEvent(eventName, {mode = "remove"})
	else
		print("No - Event Does Not Exist")
	end
end

function Event_RemoveTrigger(triggerName)
	function Try()
    		ScenEdit_SetTrigger({name= triggerName, mode= 'update'})
	end

	if pcall(Try) then
 	   print("Yes - Trigger Exists")
  	  ScenEdit_SetTrigger({name= triggerName, mode= 'remove'})
	else
  	  print("No - Trigger Does Not Exist")
	end
end


function Event_RemoveAction(actionName)
	function Try()
    		ScenEdit_SetAction({name= actionName, mode= 'update'})
	end

	if pcall(Try) then
 	   print("Yes - Action Exists")
  	  ScenEdit_SetAction({name= actionName, mode= 'remove'})
	else
  	  print("No - Action Does Not Exist")
	end
end



