-- 1. Users table (Auth0-ready)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    auth0_id VARCHAR(50) UNIQUE,          -- Auth0 identifier, can be NULL initially
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- 2. Ingredients table
CREATE TABLE ingredients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

-- 3. Units table
CREATE TABLE units (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    abbreviation VARCHAR(10),
    type VARCHAR(50),                      -- e.g., volume, weight, count
    conversion_to_base NUMERIC,            -- factor to convert to base_unit
    base_unit INTEGER REFERENCES units(id) -- nullable self-reference
);

-- 4. Tags table
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

-- 5. Recipes table
CREATE TABLE recipes (
    id SERIAL PRIMARY KEY,                 -- unique row/version
    recipe_uuid UUID NOT NULL,             -- same UUID for all versions
    version INTEGER NOT NULL DEFAULT 1,    -- increments for updates
    user_id INTEGER NOT NULL REFERENCES users(id),
    name VARCHAR(255) NOT NULL,
    instructions TEXT,
    category VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,        -- marks latest version
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(recipe_uuid, version)           -- ensures version uniqueness per recipe
);

-- 6. Recipe Ingredients table
CREATE TABLE recipe_ingredients (
    id SERIAL PRIMARY KEY,
    recipe_id INTEGER NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    ingredient_id INTEGER NOT NULL REFERENCES ingredients(id),
    quantity NUMERIC,
    unit_id INTEGER REFERENCES units(id)
);

-- 7. Recipe Tags table (many-to-many)
CREATE TABLE recipe_tags (
    recipe_id INTEGER NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    tag_id INTEGER NOT NULL REFERENCES tags(id),
    PRIMARY KEY (recipe_id, tag_id)
);
