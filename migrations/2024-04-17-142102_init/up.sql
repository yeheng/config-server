-- Your SQL goes here
CREATE TABLE "access_key"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "app_id"             VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "secret"             VARCHAR(128)                DEFAULT ''        NOT NULL,
    "is_enabled"         bool                        DEFAULT FALSE     NOT NULL,
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_access_key" PRIMARY KEY ("id")
);

COMMENT ON TABLE "access_key" IS '访问密钥';

COMMENT ON COLUMN "access_key"."id" IS '自增主键';

COMMENT ON COLUMN "access_key"."app_id" IS 'AppID';

COMMENT ON COLUMN "access_key"."secret" IS 'Secret';

COMMENT ON COLUMN "access_key"."is_enabled" IS '1: enabled, 0: disabled';

COMMENT ON COLUMN "access_key"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "access_key"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "access_key"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "access_key"."created_time" IS '创建时间';

COMMENT ON COLUMN "access_key"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "access_key"."last_modified_time" IS '最后修改时间';

CREATE TABLE "app"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "app_id"             VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "name"               VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "org_id"             VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "org_name"           VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "owner_name"         VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "owner_email"        VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_app" PRIMARY KEY ("id")
);

COMMENT ON TABLE "app" IS '应用表';

COMMENT ON COLUMN "app"."id" IS '主键';

COMMENT ON COLUMN "app"."app_id" IS 'AppID';

COMMENT ON COLUMN "app"."name" IS '应用名';

COMMENT ON COLUMN "app"."org_id" IS '部门Id';

COMMENT ON COLUMN "app"."org_name" IS '部门名字';

COMMENT ON COLUMN "app"."owner_name" IS 'ownerName';

COMMENT ON COLUMN "app"."owner_email" IS 'ownerEmail';

COMMENT ON COLUMN "app"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "app"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "app"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "app"."created_time" IS '创建时间';

COMMENT ON COLUMN "app"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "app"."last_modified_time" IS '最后修改时间';

CREATE TABLE "app_namespace"
(
    "id"                 BIGSERIAL                                        NOT NULL,
    "name"               VARCHAR(32)                 DEFAULT ''           NOT NULL,
    "app_id"             VARCHAR(64)                 DEFAULT ''           NOT NULL,
    "format"             VARCHAR(32)                 DEFAULT 'properties' NOT NULL,
    "is_public"          bool                        DEFAULT FALSE        NOT NULL,
    "comment"            VARCHAR(64)                 DEFAULT ''           NOT NULL,
    "is_deleted"         bool                        DEFAULT FALSE        NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default'    NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()        NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_app_namespace" PRIMARY KEY ("id")
);

COMMENT ON TABLE "app_namespace" IS '应用namespace定义';

COMMENT ON COLUMN "app_namespace"."id" IS '自增主键';

COMMENT ON COLUMN "app_namespace"."name" IS 'namespace名字，注意，需要全局唯一';

COMMENT ON COLUMN "app_namespace"."app_id" IS 'app id';

COMMENT ON COLUMN "app_namespace"."format" IS 'namespace的format类型';

COMMENT ON COLUMN "app_namespace"."is_public" IS 'namespace是否为公共';

COMMENT ON COLUMN "app_namespace"."comment" IS '注释';

COMMENT ON COLUMN "app_namespace"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "app_namespace"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "app_namespace"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "app_namespace"."created_time" IS '创建时间';

COMMENT ON COLUMN "app_namespace"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "app_namespace"."last_modified_time" IS '最后修改时间';

CREATE TABLE "audit"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "entity_name"        VARCHAR(50)                 DEFAULT 'default' NOT NULL,
    "entity_id"          BIGSERIAL,
    "op_name"            VARCHAR(50)                 DEFAULT 'default' NOT NULL,
    "comment"            VARCHAR(500),
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_audit" PRIMARY KEY ("id")
);

COMMENT ON TABLE "audit" IS '日志审计表';

COMMENT ON COLUMN "audit"."id" IS '主键';

COMMENT ON COLUMN "audit"."entity_name" IS '表名';

COMMENT ON COLUMN "audit"."entity_id" IS '记录ID';

COMMENT ON COLUMN "audit"."op_name" IS '操作类型';

COMMENT ON COLUMN "audit"."comment" IS '备注';

COMMENT ON COLUMN "audit"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "audit"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "audit"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "audit"."created_time" IS '创建时间';

COMMENT ON COLUMN "audit"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "audit"."last_modified_time" IS '最后修改时间';

CREATE TABLE "audit_log"
(
    "id"                   BIGSERIAL                                       NOT NULL,
    "trace_id"             VARCHAR(32)                 DEFAULT ''          NOT NULL,
    "span_id"              VARCHAR(32)                 DEFAULT ''          NOT NULL,
    "parent_spend_id"      VARCHAR(32),
    "follows_from_span_id" VARCHAR(32),
    "operator"             VARCHAR(64)                 DEFAULT 'anonymous' NOT NULL,
    "op_type"              VARCHAR(50)                 DEFAULT 'default'   NOT NULL,
    "op_name"              VARCHAR(150)                DEFAULT 'default'   NOT NULL,
    "description"          VARCHAR(200),
    "is_deleted"           bool                        DEFAULT FALSE       NOT NULL,
    "deleted_at"           TIMESTAMP WITHOUT TIME ZONE,
    "created_by"           VARCHAR(64)                 DEFAULT 'default'   NOT NULL,
    "created_time"         TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()       NOT NULL,
    "last_modified_by"     VARCHAR(64)                 DEFAULT '',
    "last_modified_time"   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_audit_log" PRIMARY KEY ("id")
);

COMMENT ON TABLE "audit_log" IS '审计日志表';

COMMENT ON COLUMN "audit_log"."id" IS '主键';

COMMENT ON COLUMN "audit_log"."trace_id" IS '链路全局唯一ID';

COMMENT ON COLUMN "audit_log"."span_id" IS '跨度ID';

COMMENT ON COLUMN "audit_log"."parent_spend_id" IS '父跨度ID';

COMMENT ON COLUMN "audit_log"."follows_from_span_id" IS '上一个兄弟跨度ID';

COMMENT ON COLUMN "audit_log"."operator" IS '操作人';

COMMENT ON COLUMN "audit_log"."op_type" IS '操作类型';

COMMENT ON COLUMN "audit_log"."op_name" IS '操作名称';

COMMENT ON COLUMN "audit_log"."description" IS '备注';

COMMENT ON COLUMN "audit_log"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "audit_log"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "audit_log"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "audit_log"."created_time" IS '创建时间';

COMMENT ON COLUMN "audit_log"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "audit_log"."last_modified_time" IS '最后修改时间';

CREATE TABLE "audit_log_data_influence"
(
    "id"                    BIGSERIAL                                     NOT NULL,
    "span_id"               CHAR(32)                    DEFAULT ''        NOT NULL,
    "influence_entity_id"   VARCHAR(50)                 DEFAULT '0'       NOT NULL,
    "influence_entity_name" VARCHAR(50)                 DEFAULT 'default' NOT NULL,
    "field_name"            VARCHAR(50),
    "field_old_value"       VARCHAR(500),
    "field_new_value"       VARCHAR(500),
    "is_deleted"            bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"            TIMESTAMP WITHOUT TIME ZONE,
    "created_by"            VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"          TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"      VARCHAR(64)                 DEFAULT '',
    "last_modified_time"    TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_audit_log_data_influence" PRIMARY KEY ("id")
);

COMMENT ON TABLE "audit_log_data_influence" IS '审计日志数据变动表';

COMMENT ON COLUMN "audit_log_data_influence"."id" IS '主键';

COMMENT ON COLUMN "audit_log_data_influence"."span_id" IS '跨度ID';

COMMENT ON COLUMN "audit_log_data_influence"."influence_entity_id" IS '记录ID';

COMMENT ON COLUMN "audit_log_data_influence"."influence_entity_name" IS '表名';

COMMENT ON COLUMN "audit_log_data_influence"."field_name" IS '字段名称';

COMMENT ON COLUMN "audit_log_data_influence"."field_old_value" IS '字段旧值';

COMMENT ON COLUMN "audit_log_data_influence"."field_new_value" IS '字段新值';

COMMENT ON COLUMN "audit_log_data_influence"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "audit_log_data_influence"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "audit_log_data_influence"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "audit_log_data_influence"."created_time" IS '创建时间';

COMMENT ON COLUMN "audit_log_data_influence"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "audit_log_data_influence"."last_modified_time" IS '最后修改时间';

CREATE TABLE "cluster"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "name"               VARCHAR(32)                 DEFAULT ''        NOT NULL,
    "app_id"             VARCHAR(64)                 DEFAULT ''        NOT NULL,
    "parent_cluster_id"  BIGINT                      DEFAULT 0         NOT NULL,
    "comment"            VARCHAR(64),
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_cluster" PRIMARY KEY ("id")
);

COMMENT ON TABLE "cluster" IS '集群';

COMMENT ON COLUMN "cluster"."id" IS '自增主键';

COMMENT ON COLUMN "cluster"."name" IS '集群名字';

COMMENT ON COLUMN "cluster"."app_id" IS 'App id';

COMMENT ON COLUMN "cluster"."parent_cluster_id" IS '父cluster';

COMMENT ON COLUMN "cluster"."comment" IS '备注';

COMMENT ON COLUMN "cluster"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "cluster"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "cluster"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "cluster"."created_time" IS '创建时间';

COMMENT ON COLUMN "cluster"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "cluster"."last_modified_time" IS '最后修改时间';

CREATE TABLE "commit"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "change_sets"        TEXT                                          NOT NULL,
    "app_id"             VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "cluster_name"       VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "namespace_name"     VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "comment"            VARCHAR(500),
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_commit" PRIMARY KEY ("id")
);

COMMENT ON TABLE "commit" IS 'commit 历史表';

COMMENT ON COLUMN "commit"."id" IS '主键';

COMMENT ON COLUMN "commit"."change_sets" IS '修改变更集';

COMMENT ON COLUMN "commit"."app_id" IS 'AppID';

COMMENT ON COLUMN "commit"."cluster_name" IS 'ClusterName';

COMMENT ON COLUMN "commit"."namespace_name" IS 'namespaceName';

COMMENT ON COLUMN "commit"."comment" IS '备注';

COMMENT ON COLUMN "commit"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "commit"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "commit"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "commit"."created_time" IS '创建时间';

COMMENT ON COLUMN "commit"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "commit"."last_modified_time" IS '最后修改时间';

CREATE TABLE "gray_release_rule"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "app_id"             VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "cluster_name"       VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "namespace_name"     VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "branch_name"        VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "rules"              VARCHAR(16000)              DEFAULT '[]',
    "release_id"         BIGINT                      DEFAULT 0         NOT NULL,
    "branch_status"      SMALLINT                    DEFAULT 1,
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_gray_release_rule" PRIMARY KEY ("id")
);

COMMENT ON TABLE "gray_release_rule" IS '灰度规则表';

COMMENT ON COLUMN "gray_release_rule"."id" IS '主键';

COMMENT ON COLUMN "gray_release_rule"."app_id" IS 'AppID';

COMMENT ON COLUMN "gray_release_rule"."cluster_name" IS 'Cluster Name';

COMMENT ON COLUMN "gray_release_rule"."namespace_name" IS 'Namespace Name';

COMMENT ON COLUMN "gray_release_rule"."branch_name" IS 'branch name';

COMMENT ON COLUMN "gray_release_rule"."rules" IS '灰度规则';

COMMENT ON COLUMN "gray_release_rule"."release_id" IS '灰度对应的release';

COMMENT ON COLUMN "gray_release_rule"."branch_status" IS '灰度分支状态: 0:删除分支,1:正在使用的规则 2：全量发布';

COMMENT ON COLUMN "gray_release_rule"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "gray_release_rule"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "gray_release_rule"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "gray_release_rule"."created_time" IS '创建时间';

COMMENT ON COLUMN "gray_release_rule"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "gray_release_rule"."last_modified_time" IS '最后修改时间';

CREATE TABLE "instance"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "app_id"             VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "cluster_name"       VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "data_center"        VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "ip"                 VARCHAR(32)                 DEFAULT ''        NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    CONSTRAINT "PRIMARY_instance" PRIMARY KEY ("id")
);

COMMENT ON TABLE "instance" IS '使用配置的应用实例';

COMMENT ON COLUMN "instance"."id" IS '自增Id';

COMMENT ON COLUMN "instance"."app_id" IS 'AppID';

COMMENT ON COLUMN "instance"."cluster_name" IS 'ClusterName';

COMMENT ON COLUMN "instance"."data_center" IS 'Data Center Name';

COMMENT ON COLUMN "instance"."ip" IS 'instance ip';

COMMENT ON COLUMN "instance"."created_time" IS '创建时间';

COMMENT ON COLUMN "instance"."last_modified_time" IS '最后修改时间';

CREATE TABLE "instance_config"
(
    "id"                    BIGSERIAL                                     NOT NULL,
    "instance_id"           BIGINT,
    "config_app_id"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "config_cluster_name"   VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "config_namespace_name" VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "release_key"           VARCHAR(64)                 DEFAULT ''        NOT NULL,
    "release_delivery_time" TIMESTAMP WITHOUT TIME ZONE,
    "created_time"          TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_time"    TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    CONSTRAINT "PRIMARY_instance_config" PRIMARY KEY ("id")
);

COMMENT ON TABLE "instance_config" IS '应用实例的配置信息';

COMMENT ON COLUMN "instance_config"."id" IS '自增Id';

COMMENT ON COLUMN "instance_config"."instance_id" IS 'Instance Id';

COMMENT ON COLUMN "instance_config"."config_app_id" IS 'Config App Id';

COMMENT ON COLUMN "instance_config"."config_cluster_name" IS 'Config Cluster Name';

COMMENT ON COLUMN "instance_config"."config_namespace_name" IS 'Config Namespace Name';

COMMENT ON COLUMN "instance_config"."release_key" IS '发布的Key';

COMMENT ON COLUMN "instance_config"."release_delivery_time" IS '配置获取时间';

COMMENT ON COLUMN "instance_config"."created_time" IS '创建时间';

COMMENT ON COLUMN "instance_config"."last_modified_time" IS '最后修改时间';

CREATE TABLE "item"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "namespace_id"       BIGINT                      DEFAULT 0         NOT NULL,
    "key"                VARCHAR(128)                DEFAULT 'default' NOT NULL,
    "type"               SMALLINT                    DEFAULT 0         NOT NULL,
    "value"              TEXT                                          NOT NULL,
    "comment"            VARCHAR(1024)               DEFAULT '',
    "line_num"           BIGINT                      DEFAULT 0,
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_item" PRIMARY KEY ("id")
);

COMMENT ON TABLE "item" IS '配置项目';

COMMENT ON COLUMN "item"."id" IS '自增Id';

COMMENT ON COLUMN "item"."namespace_id" IS '集群NamespaceId';

COMMENT ON COLUMN "item"."key" IS '配置项Key';

COMMENT ON COLUMN "item"."type" IS '配置项类型，0: String，1: Number，2: Boolean，3: JSON';

COMMENT ON COLUMN "item"."value" IS '配置项值';

COMMENT ON COLUMN "item"."comment" IS '注释';

COMMENT ON COLUMN "item"."line_num" IS '行号';

COMMENT ON COLUMN "item"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "item"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "item"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "item"."created_time" IS '创建时间';

COMMENT ON COLUMN "item"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "item"."last_modified_time" IS '最后修改时间';

CREATE TABLE "namespace"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "app_id"             VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "cluster_name"       VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "namespace_name"     VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_namespace" PRIMARY KEY ("id")
);

COMMENT ON TABLE "namespace" IS '命名空间';

COMMENT ON COLUMN "namespace"."id" IS '自增主键';

COMMENT ON COLUMN "namespace"."app_id" IS 'AppID';

COMMENT ON COLUMN "namespace"."cluster_name" IS 'Cluster Name';

COMMENT ON COLUMN "namespace"."namespace_name" IS 'Namespace Name';

COMMENT ON COLUMN "namespace"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "namespace"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "namespace"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "namespace"."created_time" IS '创建时间';

COMMENT ON COLUMN "namespace"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "namespace"."last_modified_time" IS '最后修改时间';

CREATE TABLE "namespace_lock"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "namespace_id"       BIGINT                      DEFAULT 0         NOT NULL,
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_namespace_lock" PRIMARY KEY ("id")
);

COMMENT ON TABLE "namespace_lock" IS 'namespace的编辑锁';

COMMENT ON COLUMN "namespace_lock"."id" IS '自增id';

COMMENT ON COLUMN "namespace_lock"."namespace_id" IS '集群NamespaceId';

COMMENT ON COLUMN "namespace_lock"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "namespace_lock"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "namespace_lock"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "namespace_lock"."created_time" IS '创建时间';

COMMENT ON COLUMN "namespace_lock"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "namespace_lock"."last_modified_time" IS '最后修改时间';

CREATE TABLE "release"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "release_key"        VARCHAR(64)                 DEFAULT ''        NOT NULL,
    "name"               VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "comment"            VARCHAR(256),
    "app_id"             VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "cluster_name"       VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "namespace_name"     VARCHAR(500)                DEFAULT 'default' NOT NULL,
    "configurations"     TEXT                                          NOT NULL,
    "is_abandoned"       bool                        DEFAULT FALSE     NOT NULL,
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_release" PRIMARY KEY ("id")
);

COMMENT ON TABLE "release" IS '发布';

COMMENT ON COLUMN "release"."id" IS '自增主键';

COMMENT ON COLUMN "release"."release_key" IS '发布的Key';

COMMENT ON COLUMN "release"."name" IS '发布名字';

COMMENT ON COLUMN "release"."comment" IS '发布说明';

COMMENT ON COLUMN "release"."app_id" IS 'AppID';

COMMENT ON COLUMN "release"."cluster_name" IS 'ClusterName';

COMMENT ON COLUMN "release"."namespace_name" IS 'namespaceName';

COMMENT ON COLUMN "release"."configurations" IS '发布配置';

COMMENT ON COLUMN "release"."is_abandoned" IS '是否废弃';

COMMENT ON COLUMN "release"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "release"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "release"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "release"."created_time" IS '创建时间';

COMMENT ON COLUMN "release"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "release"."last_modified_time" IS '最后修改时间';

CREATE TABLE "release_history"
(
    "id"                  BIGSERIAL                                     NOT NULL,
    "app_id"              VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "cluster_name"        VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "namespace_name"      VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "branch_name"         VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "release_id"          BIGINT                      DEFAULT 0         NOT NULL,
    "previous_release_id" BIGINT                      DEFAULT 0         NOT NULL,
    "operation"           SMALLINT                    DEFAULT 0         NOT NULL,
    "operation_context"   TEXT                                          NOT NULL,
    "is_deleted"          bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"          TIMESTAMP WITHOUT TIME ZONE,
    "created_by"          VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"        TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"    VARCHAR(64)                 DEFAULT '',
    "last_modified_time"  TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_release_history" PRIMARY KEY ("id")
);

COMMENT ON TABLE "release_history" IS '发布历史';

COMMENT ON COLUMN "release_history"."id" IS '自增Id';

COMMENT ON COLUMN "release_history"."app_id" IS 'AppID';

COMMENT ON COLUMN "release_history"."cluster_name" IS 'ClusterName';

COMMENT ON COLUMN "release_history"."namespace_name" IS 'namespaceName';

COMMENT ON COLUMN "release_history"."branch_name" IS '发布分支名';

COMMENT ON COLUMN "release_history"."release_id" IS '关联的Release Id';

COMMENT ON COLUMN "release_history"."previous_release_id" IS '前一次发布的ReleaseId';

COMMENT ON COLUMN "release_history"."operation" IS '发布类型，0: 普通发布，1: 回滚，2: 灰度发布，3: 灰度规则更新，4: 灰度合并回主分支发布，5: 主分支发布灰度自动发布，6: 主分支回滚灰度自动发布，7: 放弃灰度';

COMMENT ON COLUMN "release_history"."operation_context" IS '发布上下文信息';

COMMENT ON COLUMN "release_history"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "release_history"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "release_history"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "release_history"."created_time" IS '创建时间';

COMMENT ON COLUMN "release_history"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "release_history"."last_modified_time" IS '最后修改时间';

CREATE TABLE "release_message"
(
    "id"                 BIGSERIAL                                 NOT NULL,
    "message"            VARCHAR(1024)               DEFAULT ''    NOT NULL,
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    CONSTRAINT "PRIMARY_release_message" PRIMARY KEY ("id")
);

COMMENT ON TABLE "release_message" IS '发布消息';

COMMENT ON COLUMN "release_message"."id" IS '自增主键';

COMMENT ON COLUMN "release_message"."message" IS '发布的消息内容';

COMMENT ON COLUMN "release_message"."last_modified_time" IS '最后修改时间';

CREATE TABLE "server_config"
(
    "id"                 BIGSERIAL                                     NOT NULL,
    "key"                VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "cluster"            VARCHAR(32)                 DEFAULT 'default' NOT NULL,
    "value"              VARCHAR(2048)               DEFAULT 'default' NOT NULL,
    "comment"            VARCHAR(1024)               DEFAULT '',
    "is_deleted"         bool                        DEFAULT FALSE     NOT NULL,
    "deleted_at"         TIMESTAMP WITHOUT TIME ZONE,
    "created_by"         VARCHAR(64)                 DEFAULT 'default' NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()     NOT NULL,
    "last_modified_by"   VARCHAR(64)                 DEFAULT '',
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT "PRIMARY_server_config" PRIMARY KEY ("id")
);

COMMENT ON TABLE "server_config" IS '配置服务自身配置';

COMMENT ON COLUMN "server_config"."id" IS '自增Id';

COMMENT ON COLUMN "server_config"."key" IS '配置项Key';

COMMENT ON COLUMN "server_config"."cluster" IS '配置对应的集群，default为不针对特定的集群';

COMMENT ON COLUMN "server_config"."value" IS '配置项值';

COMMENT ON COLUMN "server_config"."comment" IS '注释';

COMMENT ON COLUMN "server_config"."is_deleted" IS '1: deleted, 0: normal';

COMMENT ON COLUMN "server_config"."deleted_at" IS '删除实际';

COMMENT ON COLUMN "server_config"."created_by" IS '创建人邮箱前缀';

COMMENT ON COLUMN "server_config"."created_time" IS '创建时间';

COMMENT ON COLUMN "server_config"."last_modified_by" IS '最后修改人邮箱前缀';

COMMENT ON COLUMN "server_config"."last_modified_time" IS '最后修改时间';

CREATE TABLE "service_registry"
(
    "id"                 BIGSERIAL                                 NOT NULL,
    "service_name"       VARCHAR(64)                               NOT NULL,
    "uri"                VARCHAR(64)                               NOT NULL,
    "cluster"            VARCHAR(64)                               NOT NULL,
    "metadata"           VARCHAR(1024)               DEFAULT '{}'  NOT NULL,
    "created_time"       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    "last_modified_time" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    CONSTRAINT "PRIMARY_service_registry" PRIMARY KEY ("id")
);

COMMENT ON TABLE "service_registry" IS '注册中心';

COMMENT ON COLUMN "service_registry"."id" IS '自增Id';

COMMENT ON COLUMN "service_registry"."service_name" IS '服务名';

COMMENT ON COLUMN "service_registry"."uri" IS '服务地址';

COMMENT ON COLUMN "service_registry"."cluster" IS '集群，可以用来标识apollo.cluster或者网络分区';

COMMENT ON COLUMN "service_registry"."metadata" IS '元数据，key value结构的json object，为了方面后面扩展功能而不需要修改表结构';

COMMENT ON COLUMN "service_registry"."created_time" IS '创建时间';

COMMENT ON COLUMN "service_registry"."last_modified_time" IS '最后修改时间';

ALTER TABLE "instance"
    ADD CONSTRAINT "IX_UNIQUE_KEY_instance_1" UNIQUE ("app_id", "cluster_name", "ip", "data_center");

ALTER TABLE "instance_config"
    ADD CONSTRAINT "IX_UNIQUE_KEY_instance_2" UNIQUE ("instance_id", "config_app_id", "config_namespace_name");

ALTER TABLE "service_registry"
    ADD CONSTRAINT "IX_UNIQUE_KEY_instance_3" UNIQUE ("service_name", "uri");

ALTER TABLE "namespace"
    ADD CONSTRAINT "UK_AppId_ClusterName_NamespaceName_DeletedAt" UNIQUE ("app_id", "cluster_name", "namespace_name", "is_deleted");

ALTER TABLE "app_namespace"
    ADD CONSTRAINT "UK_namespace_AppId_Name_DeletedAt" UNIQUE ("app_id", "name", "is_deleted");

ALTER TABLE "cluster"
    ADD CONSTRAINT "UK_cluster_AppId_Name_DeletedAt" UNIQUE ("app_id", "name", "is_deleted");

ALTER TABLE "access_key"
    ADD CONSTRAINT "UK_access_key_AppId_Secret_DeletedAt" UNIQUE ("app_id", "secret", "is_deleted");

ALTER TABLE "server_config"
    ADD CONSTRAINT "UK_server_config_Key_Cluster_DeletedAt" UNIQUE ("key", "cluster", "is_deleted");

ALTER TABLE "namespace_lock"
    ADD CONSTRAINT "UK_namespace_lock_NamespaceId_DeletedAt" UNIQUE ("namespace_id", "is_deleted");

ALTER TABLE "release"
    ADD CONSTRAINT "UK_release_ReleaseKey_DeletedAt" UNIQUE ("release_key", "is_deleted");

ALTER TABLE "app"
    ADD CONSTRAINT "uk_app_app_id_deleted_at" UNIQUE ("app_id", "deleted_at");

