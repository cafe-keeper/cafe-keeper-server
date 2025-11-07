

-- ===========================
-- Seed File for Recipe App
-- Versioning + Active Flags + Categories + Multiple Tags
-- ===========================

-- 1. Users
INSERT INTO users (auth0_id, name, email)
VALUES
('auth0|1234567890', 'Alice Baker', 'alice@example.com'),
('auth0|0987654321', 'Bob Cook', 'bob@example.com');

-- 2. Ingredients
INSERT INTO ingredients (name)
VALUES
('Flour'),
('Sugar'),
('Butter'),
('Eggs'),
('Milk');

-- 3. Units
INSERT INTO units (name, abbreviation, type, conversion_to_base, base_unit)
VALUES
('gram', 'g', 'weight', 1, NULL),
('kilogram', 'kg', 'weight', 1000, 1),
('cup', 'cup', 'volume', 240, NULL),
('piece', 'pc', 'count', 1, NULL);

-- 4. Tags
INSERT INTO tags (name)
VALUES
('Dessert'),
('Breakfast'),
('Vegetarian'),
('Quick'),
('Baking');

-- 5. Recipes
-- Version 1 (inactive)
INSERT INTO recipes (recipe_uuid, version, user_id, name, instructions, category, is_active)
VALUES
('11111111-1111-1111-1111-111111111111', 1, 1, 'Simple Pancakes', 'Mix flour, sugar, eggs, milk and cook on a hot griddle.', 'Breakfast', FALSE),
('22222222-2222-2222-2222-222222222222', 1, 2, 'Sugar Cookies', 'Cream butter and sugar, mix in flour, bake at 350F for 12 mins.', 'Dessert', FALSE);

-- Version 2 (active)
INSERT INTO recipes (recipe_uuid, version, user_id, name, instructions, category, is_active)
VALUES
('11111111-1111-1111-1111-111111111111', 2, 1, 'Simple Pancakes', 'Mix flour, sugar, eggs, milk, and a pinch of salt. Cook on a hot griddle until golden brown.', 'Breakfast', TRUE),
('22222222-2222-2222-2222-222222222222', 2, 2, 'Sugar Cookies', 'Cream butter and sugar, mix in flour and vanilla extract. Bake at 350F for 10-12 mins.', 'Dessert', TRUE);

-- 6. Recipe Ingredients
-- Version 1 - Pancakes
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit_id)
VALUES
(1, 1, 200, 1),
(1, 2, 50, 1),
(1, 3, 100, 1),
(1, 4, 2, 4),
(1, 5, 250, 3);

-- Version 1 - Sugar Cookies
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit_id)
VALUES
(2, 1, 250, 1),
(2, 2, 150, 1),
(2, 3, 120, 1);

-- Version 2 - Pancakes (updated)
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit_id)
VALUES
(3, 1, 200, 1),
(3, 2, 50, 1),
(3, 3, 100, 1),
(3, 4, 2, 4),
(3, 5, 250, 3);

-- Version 2 - Sugar Cookies (updated)
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit_id)
VALUES
(4, 1, 250, 1),
(4, 2, 150, 1),
(4, 3, 120, 1);

-- 7. Recipe Tags
-- Version 1
INSERT INTO recipe_tags (recipe_id, tag_id)
VALUES
(1, 2), -- Pancakes v1 -> Breakfast
(1, 4), -- Pancakes v1 -> Quick
(2, 1), -- Sugar Cookies v1 -> Dessert
(2, 5); -- Sugar Cookies v1 -> Baking

-- Version 2
INSERT INTO recipe_tags (recipe_id, tag_id)
VALUES
(3, 2), -- Pancakes v2 -> Breakfast
(3, 3), -- Pancakes v2 -> Vegetarian
(3, 4), -- Pancakes v2 -> Quick
(4, 1), -- Sugar Cookies v2 -> Dessert
(4, 5); -- Sugar Cookies v2 -> Baking
