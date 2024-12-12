CREATE TABLE IF NOT EXISTS player_skills (
    citizenid VARCHAR(64) PRIMARY KEY,    
    stamina FLOAT DEFAULT 0,                
    strength FLOAT DEFAULT 0,                
    shooting FLOAT DEFAULT 0,                 
    lung_capacity FLOAT DEFAULT 0            
);