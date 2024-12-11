CREATE TABLE IF NOT EXISTS player_skills (
    citizenid VARCHAR(64) PRIMARY KEY,       -- 玩家唯一标识符
    stamina FLOAT DEFAULT 0,                  -- 体力，默认值为 0，允许小数
    strength FLOAT DEFAULT 0,                 -- 力量，默认值为 0，允许小数
    shooting FLOAT DEFAULT 0,                 -- 射击，默认值为 0，允许小数
    lung_capacity FLOAT DEFAULT 0            -- 肺活量，默认值为 0，允许小数
);