-- artisan flow model definition
INSERT INTO model(id, key, name, description, managed, changed_by, version)
VALUES (2, 'ART', 'Artisan Flow Model', 'Configure Artisan Flows', true, 'onix', 1);

-- item types
INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (10, 'ART_FLOW', 'Artisan Flow', 'A sequence of steps executing functions in Artisan packages.', 1, 'onix', 2, 'N');