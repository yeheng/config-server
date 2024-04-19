// @generated automatically by Diesel CLI.

diesel::table! {
    access_key (id) {
        id -> Int8,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 128]
        secret -> Varchar,
        is_enabled -> Bool,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    app (id) {
        id -> Int8,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 500]
        name -> Varchar,
        #[max_length = 32]
        org_id -> Varchar,
        #[max_length = 64]
        org_name -> Varchar,
        #[max_length = 500]
        owner_name -> Varchar,
        #[max_length = 500]
        owner_email -> Varchar,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    app_namespace (id) {
        id -> Int8,
        #[max_length = 32]
        name -> Varchar,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 32]
        format -> Varchar,
        is_public -> Bool,
        #[max_length = 64]
        comment -> Varchar,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    audit (id) {
        id -> Int8,
        #[max_length = 50]
        entity_name -> Varchar,
        entity_id -> Int8,
        #[max_length = 50]
        op_name -> Varchar,
        #[max_length = 500]
        comment -> Nullable<Varchar>,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    audit_log (id) {
        id -> Int8,
        #[max_length = 32]
        trace_id -> Varchar,
        #[max_length = 32]
        span_id -> Varchar,
        #[max_length = 32]
        parent_spend_id -> Nullable<Varchar>,
        #[max_length = 32]
        follows_from_span_id -> Nullable<Varchar>,
        #[max_length = 64]
        operator -> Varchar,
        #[max_length = 50]
        op_type -> Varchar,
        #[max_length = 150]
        op_name -> Varchar,
        #[max_length = 200]
        description -> Nullable<Varchar>,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    audit_log_data_influence (id) {
        id -> Int8,
        #[max_length = 32]
        span_id -> Bpchar,
        #[max_length = 50]
        influence_entity_id -> Varchar,
        #[max_length = 50]
        influence_entity_name -> Varchar,
        #[max_length = 50]
        field_name -> Nullable<Varchar>,
        #[max_length = 500]
        field_old_value -> Nullable<Varchar>,
        #[max_length = 500]
        field_new_value -> Nullable<Varchar>,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    cluster (id) {
        id -> Int8,
        #[max_length = 32]
        name -> Varchar,
        #[max_length = 64]
        app_id -> Varchar,
        parent_cluster_id -> Int8,
        #[max_length = 64]
        comment -> Nullable<Varchar>,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    commit (id) {
        id -> Int8,
        change_sets -> Text,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 500]
        cluster_name -> Varchar,
        #[max_length = 500]
        namespace_name -> Varchar,
        #[max_length = 500]
        comment -> Nullable<Varchar>,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    gray_release_rule (id) {
        id -> Int8,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 32]
        cluster_name -> Varchar,
        #[max_length = 32]
        namespace_name -> Varchar,
        #[max_length = 32]
        branch_name -> Varchar,
        #[max_length = 16000]
        rules -> Nullable<Varchar>,
        release_id -> Int8,
        branch_status -> Nullable<Int2>,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    instance (id) {
        id -> Int8,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 32]
        cluster_name -> Varchar,
        #[max_length = 64]
        data_center -> Varchar,
        #[max_length = 32]
        ip -> Varchar,
        created_time -> Timestamp,
        last_modified_time -> Timestamp,
    }
}

diesel::table! {
    instance_config (id) {
        id -> Int8,
        instance_id -> Nullable<Int8>,
        #[max_length = 64]
        config_app_id -> Varchar,
        #[max_length = 32]
        config_cluster_name -> Varchar,
        #[max_length = 32]
        config_namespace_name -> Varchar,
        #[max_length = 64]
        release_key -> Varchar,
        release_delivery_time -> Nullable<Timestamp>,
        created_time -> Timestamp,
        last_modified_time -> Timestamp,
    }
}

diesel::table! {
    item (id) {
        id -> Int8,
        namespace_id -> Int8,
        #[max_length = 128]
        key -> Varchar,
        #[sql_name = "type"]
        type_ -> Int2,
        value -> Text,
        #[max_length = 1024]
        comment -> Nullable<Varchar>,
        line_num -> Nullable<Int8>,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    namespace (id) {
        id -> Int8,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 500]
        cluster_name -> Varchar,
        #[max_length = 500]
        namespace_name -> Varchar,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    namespace_lock (id) {
        id -> Int8,
        namespace_id -> Int8,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    release (id) {
        id -> Int8,
        #[max_length = 64]
        release_key -> Varchar,
        #[max_length = 64]
        name -> Varchar,
        #[max_length = 256]
        comment -> Nullable<Varchar>,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 500]
        cluster_name -> Varchar,
        #[max_length = 500]
        namespace_name -> Varchar,
        Configurations -> Text,
        IsAbandoned -> Bool,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    release_history (id) {
        id -> Int8,
        #[max_length = 64]
        app_id -> Varchar,
        #[max_length = 32]
        cluster_name -> Varchar,
        #[max_length = 32]
        namespace_name -> Varchar,
        #[max_length = 32]
        branch_name -> Varchar,
        release_id -> Int8,
        previous_release_id -> Int8,
        operation -> Int2,
        operation_context -> Text,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    release_message (id) {
        id -> Int8,
        #[max_length = 1024]
        message -> Varchar,
        last_modified_time -> Timestamp,
    }
}

diesel::table! {
    server_config (id) {
        id -> Int8,
        #[max_length = 64]
        key -> Varchar,
        #[max_length = 32]
        cluster -> Varchar,
        #[max_length = 2048]
        value -> Varchar,
        #[max_length = 1024]
        comment -> Nullable<Varchar>,
        is_deleted -> Bool,
        deleted_at -> Nullable<Timestamp>,
        #[max_length = 64]
        created_by -> Varchar,
        created_time -> Timestamp,
        #[max_length = 64]
        last_modified_by -> Nullable<Varchar>,
        last_modified_time -> Nullable<Timestamp>,
    }
}

diesel::table! {
    service_registry (id) {
        id -> Int8,
        #[max_length = 64]
        service_name -> Varchar,
        #[max_length = 64]
        uri -> Varchar,
        #[max_length = 64]
        cluster -> Varchar,
        #[max_length = 1024]
        metadata -> Varchar,
        created_time -> Timestamp,
        last_modified_time -> Timestamp,
    }
}

diesel::allow_tables_to_appear_in_same_query!(
    access_key,
    app,
    app_namespace,
    audit,
    audit_log,
    audit_log_data_influence,
    cluster,
    commit,
    gray_release_rule,
    instance,
    instance_config,
    item,
    namespace,
    namespace_lock,
    release,
    release_history,
    release_message,
    server_config,
    service_registry,
);
