function TDGetCurrentJob()
    return currentJob
  end
  
  --example of use:
  --[[
    local job = exports["TD-DutySystem"]:TDGetCurrentJob()
  if job == "BCSO" or job == "SAHP" or job == "LSPD" or job == "SAFR" then
    -- If they are on duty as one of these jobs then allow them to do something here
  else
    -- if not on duty as one of these jobs throw them an error
  end
  
  other example
  
  local job = exports["TD-DutySystem"]:TDGetCurrentJob()
  if job == "not set" then 
    -- If they are not on duty as one of these jobs then allow them to do something here
  else
    -- throw them an error code if on duty
  end
  
  -- you can also restricts a specific job from doing something, like this:
  
  if job ~= "BCSO" then
    -- if the job is set to antyhing other than BCSO, then allow them to do something here
  else
    -- throw an error
  end
  
  ]]
  