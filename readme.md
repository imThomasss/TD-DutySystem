Hello!

Here is some useful information to help you use this script!

Here is a list of the ace perms, that you will need to allow in your server.cfg = {
    BCSO Job = Thomas.Onduty.BCSO
    SAHP Job = Thomas.Onduty.SAHP
    LSPD Job = Thomas.Onduty.LSPD
    SAFR Job = Thomas.Onduty.SAFR
    
    For example, if i wanted the BCSO ace group to only be able to use BCSO job, in my server cfg i would add this; add_ace group.BCSO Thomas.Onduty.BCSO allow
}


Here is an example on how to use the export to get the players active Job.

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
  