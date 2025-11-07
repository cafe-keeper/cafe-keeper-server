-- =========================================
-- Example Queries for Recipe App Seed Data
-- =========================================

-- 1️⃣ Get all active recipes (latest versions only)
-- This query returns only the latest version of each recipe
SELECT id, recipe_uuid, version, name, category
FROM recipes
WHERE is_active = TRUE;


-- 2️⃣ Get active recipes in a specific category
-- Example: all Breakfast recipes
SELECT id, recipe_uuid, version, name
FROM recipes
WHERE category = 'Breakfast'
  AND is_active = TRUE;


-- 3️⃣ Get active recipes with a specific tag
-- Example: all recipes tagged as 'Vegetarian'
SELECT r.id, r.name, r.version, t.name AS tag
FROM recipes r
JOIN recipe_tags rt ON r.id = rt.recipe_id
JOIN tags t ON rt.tag_id = t.id
WHERE t.name = 'Vegetarian'
  AND r.is_active = TRUE;


-- 4️⃣ Get active recipes that match multiple tags
-- Example: recipes that are both 'Vegetarian' and 'Quick'
SELECT r.id, r.name, r.version
FROM recipes r
JOIN recipe_tags rt1 ON r.id = rt1.recipe_id
JOIN tags t1 ON rt1.tag_id = t1.id AND t1.name = 'Vegetarian'
JOIN recipe_tags rt2 ON r.id = rt2.recipe_id
JOIN tags t2 ON rt2.tag_id = t2.id AND t2.name = 'Quick'
WHERE r.is_active = TRUE;


-- 5️⃣ Get all ingredients for an active recipe
-- Example: ingredients for 'Simple Pancakes' with quantity and units
SELECT i.name AS ingredient, ri.quantity, u.abbreviation AS unit
FROM recipes r
JOIN recipe_ingredients ri ON r.id = ri.recipe_id
JOIN ingredients i ON ri.ingredient_id = i.id
JOIN units u ON ri.unit_id = u.id
WHERE r.name = 'Simple Pancakes'
  AND r.is_active = TRUE;


-- 6️⃣ Get all active recipes along with their tags
-- Tags are aggregated as a comma-separated list for display
SELECT r.name AS recipe, r.version, r.category, STRING_AGG(t.name, ', ') AS tags
FROM recipes r
LEFT JOIN recipe_tags rt ON r.id = rt.recipe_id
LEFT JOIN tags t ON rt.tag_id = t.id
WHERE r.is_active = TRUE
GROUP BY r.id, r.name, r.version, r.category;
