-- universal model definition
INSERT INTO model(id, key, name, description, managed, changed_by, version)
VALUES (1, 'U', 'Universal Model', 'Generic model to capture and IT landscape', true, 'onix', 1);

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (1, 'U_PLATFORM', 'Platform', 'A container or virtual machine platform', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (2, 'U_ZONE', 'Zone', 'A collection of one or more network segments requiring the regulation of inbound and outbound traffic through policies', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (3, 'U_HOST', 'Host', 'A a computer or other device connected to a computer network', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (4, 'U_APPLICATION', 'Application', 'The logical representation of a computer software', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (5, 'U_WORKLOAD', 'Workload', 'A process running on a the platform, which represents an instance of an application', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (6, 'U_ENVIRONMENT', 'Environment', 'A logical group of applications and their underlying IT infrastructure', 1, 'onix', 1, 'N');