# Created by Anthony Iorio, 11/18/2017, with the help of Dr. Chris Huntley.
# The purpose of this exercise is to perform SQL foreign key opreations, including adding them to existing tables.
# The purpose of this script is to help exemplify the performance implications of using foreign key constraints.

USE deals;
ALTER TABLE DealTypes 
  ADD FOREIGN KEY (TypeCode)
    REFERENCES TypeCodes (TypeCode);
    
USE deals;
ALTER TABLE DealTypes 
  ADD FOREIGN KEY (DealID)
    REFERENCES Deals (DealID);
    
USE deals;
ALTER TABLE DealParts
  ADD FOREIGN KEY (DealID)
    REFERENCES Deals (DealID);
    
USE deals;
ALTER TABLE Players
  ADD FOREIGN KEY (DealID)
    REFERENCES Deals (DealID);
    
USE deals;
ALTER TABLE Players
  ADD FOREIGN KEY (RoleCode)
    REFERENCES RoleCodes (RoleCode);
  
USE deals;
ALTER TABLE Players
  ADD FOREIGN KEY (CompanyID)
    REFERENCES Companies (CompanyID);

USE deals;
ALTER TABLE PlayerSupports
  ADD FOREIGN KEY (PlayerID)
    REFERENCES Players (PlayerID);
    
USE deals;
ALTER TABLE PlayerSupports
  ADD FOREIGN KEY (FirmID)
    REFERENCES Firms (FirmID);
    
USE deals;
ALTER TABLE PlayerSupports
  ADD FOREIGN KEY (SupportCodeID)
    REFERENCES SupportCodes (SupportCodeID);