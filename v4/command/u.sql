-- universal model definition
INSERT INTO model(id, key, name, description, managed, changed_by, version)
VALUES (1, 'U', 'Universal Model', 'Generic model to capture and IT landscape', true, 'onix', 1);

-- item types
INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (1, 'U_PLATFORM', 'Platform', 'A container or virtual machine platform', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (2, 'U_ZONE', 'Zone', 'A collection of one or more network segments requiring the regulation of inbound and outbound traffic through policies', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (3, 'U_HOST', 'Host', 'A a computer or other device connected to a computer network', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change, encrypt_txt)
VALUES (4, 'U_APPLICATION', 'Application', 'The logical representation of a computer software', 1, 'onix', 1, 'N', true);

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (5, 'U_WORKLOAD', 'Workload', 'A process running on a the platform, which represents an instance of an application', 1, 'onix', 1, 'N');

INSERT INTO item_type(id, key, name, description, version, changed_by, model_id, notify_change)
VALUES (6, 'U_ENVIRONMENT', 'Environment', 'A logical group of applications and their underlying IT infrastructure', 1, 'onix', 1, 'N');

-- link types
INSERT INTO link_type(id, key, name, description, version, changed_by, model_id)
VALUES (1, 'U_RELATIONSHIP', 'U Model Relation Link', 'Connects items in the U model defining their relations.', 1, 'onix', 1);

INSERT INTO link_type(id, key, name, description, version, changed_by, model_id)
VALUES (2, 'U_DEPENDENCY', 'U Model Dependency Link', 'Define runtime dependencies between items in the model.', 1, 'onix', 1);

-- link rules
INSERT INTO link_rule(id, key, name, description, link_type_id, start_item_type_id, end_item_type_id, version, changed_by)
VALUES (1, 'U_PLATFORM_TO_ZONE', 'Platform -> Zone Rule', 'Connects Platforms with Zones', 1, 1, 2, 1, 'onix');

INSERT INTO link_rule(id, key, name, description, link_type_id, start_item_type_id, end_item_type_id, version, changed_by)
VALUES (2, 'U_ZONE_TO_HOST', 'Zone -> Host Rule', 'Connects Zones with Hosts', 1, 2, 3, 1, 'onix');

INSERT INTO link_rule(id, key, name, description, link_type_id, start_item_type_id, end_item_type_id, version, changed_by)
VALUES (3, 'U_HOST_TO_WORKLOAD', 'Host -> Workload Rule', 'Connects Hosts with Application Workloads', 1, 3, 5, 1, 'onix');

INSERT INTO link_rule(id, key, name, description, link_type_id, start_item_type_id, end_item_type_id, version, changed_by)
VALUES (4, 'U_APP_TO_WORKLOAD', 'App -> Workload Rule', 'Connects Applications with their Workloads', 1, 4, 5, 1, 'onix');

INSERT INTO link_rule(id, key, name, description, link_type_id, start_item_type_id, end_item_type_id, version, changed_by)
VALUES (5, 'U_ENVIRONMENT_TO_APP', 'Environment -> App Rule', 'Connects Environments to the Applications running on them', 1, 6, 4, 1, 'onix');