-- ===========================
-- Delete All Records in All Tables
-- ===========================

-- 1. Truncate child tables first
TRUNCATE TABLE recipe_tags RESTART IDENTITY CASCADE;
TRUNCATE TABLE recipe_ingredients RESTART IDENTITY CASCADE;

-- 2. Truncate main tables
TRUNCATE TABLE recipes RESTART IDENTITY CASCADE;
TRUNCATE TABLE users RESTART IDENTITY CASCADE;
TRUNCATE TABLE ingredients RESTART IDENTITY CASCADE;
TRUNCATE TABLE units RESTART IDENTITY CASCADE;
TRUNCATE TABLE tags RESTART IDENTITY CASCADE;