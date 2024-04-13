DROP TABLE IF EXISTS `app`;

CREATE TABLE `app`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `app_id`             varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'AppID',
    `name`               varchar(500)    NOT NULL DEFAULT 'default' COMMENT '应用名',
    `org_id`             varchar(32)     NOT NULL DEFAULT 'default' COMMENT '部门Id',
    `org_name`           varchar(64)     NOT NULL DEFAULT 'default' COMMENT '部门名字',
    `owner_name`         varchar(500)    NOT NULL DEFAULT 'default' COMMENT 'ownerName',
    `owner_email`        varchar(500)    NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_app_id_deleted_at` (`app_id`, `deleted_at`),
    KEY `data_change_last_time` (`last_modified_time`),
    KEY `idx_name` (`name`(191))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='应用表';



-- Dump of table appnamespace
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `app_namespace`;

CREATE TABLE `app_namespace`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `name`               varchar(32)     NOT NULL DEFAULT '' COMMENT 'namespace名字，注意，需要全局唯一',
    `app_id`             varchar(64)     NOT NULL DEFAULT '' COMMENT 'app id',
    `format`             varchar(32)     NOT NULL DEFAULT 'properties' COMMENT 'namespace的format类型',
    `is_public`          bit(1)          NOT NULL DEFAULT b'0' COMMENT 'namespace是否为公共',
    `comment`            varchar(64)     NOT NULL DEFAULT '' COMMENT '注释',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_AppId_Name_DeletedAt` (`app_id`, `name`, `is_deleted`),
    KEY `Name_AppId` (`name`, `app_id`),
    KEY `last_modified_time` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='应用namespace定义';



-- Dump of table audit
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `audit`;

CREATE TABLE `audit`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `entity_name`        varchar(50)     NOT NULL DEFAULT 'default' COMMENT '表名',
    `entity_id`          bigint unsigned          DEFAULT NULL COMMENT '记录ID',
    `op_name`            varchar(50)     NOT NULL DEFAULT 'default' COMMENT '操作类型',
    `comment`            varchar(500)             DEFAULT NULL COMMENT '备注',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    KEY `last_modified_time` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='日志审计表';



-- Dump of table cluster
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `cluster`;

CREATE TABLE `cluster`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `name`               varchar(32)     NOT NULL DEFAULT '' COMMENT '集群名字',
    `app_id`             varchar(64)     NOT NULL DEFAULT '' COMMENT 'App id',
    `parent_cluster_id`  bigint unsigned NOT NULL DEFAULT '0' COMMENT '父cluster',
    `comment`            varchar(64)              DEFAULT NULL COMMENT '备注',
    `IsDeleted`          bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_AppId_Name_DeletedAt` (`app_id`, `name`, `is_deleted`),
    KEY `IX_ParentClusterId` (`parent_cluster_id`),
    KEY `last_modified_time` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='集群';



-- Dump of table commit
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `commit`;

CREATE TABLE `commit`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `change_sets`        longtext        NOT NULL COMMENT '修改变更集',
    `app_id`             varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'AppID',
    `cluster_name`       varchar(500)    NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
    `namespace_name`     varchar(500)    NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
    `comment`            varchar(500)             DEFAULT NULL COMMENT '备注',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    KEY `last_modified_time` (`last_modified_time`),
    KEY `app_id` (`app_id`),
    KEY `cluster_name` (`cluster_name`(191)),
    KEY `namespace_name` (`namespace_name`(191))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='commit 历史表';

-- Dump of table grayreleaserule
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `gray_release_rule`;

CREATE TABLE `gray_release_rule`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `app_id`             varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'AppID',
    `cluster_name`       varchar(32)     NOT NULL DEFAULT 'default' COMMENT 'Cluster Name',
    `namespace_name`     varchar(32)     NOT NULL DEFAULT 'default' COMMENT 'Namespace Name',
    `branch_name`        varchar(32)     NOT NULL DEFAULT 'default' COMMENT 'branch name',
    `rules`              varchar(16000)           DEFAULT '[]' COMMENT '灰度规则',
    `release_id`         bigint unsigned NOT NULL DEFAULT '0' COMMENT '灰度对应的release',
    `branch_status`      tinyint(2)               DEFAULT '1' COMMENT '灰度分支状态: 0:删除分支,1:正在使用的规则 2：全量发布',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    KEY `last_modified_time` (`last_modified_time`),
    KEY `IX_Namespace` (`app_id`, `cluster_name`, `namespace_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='灰度规则表';


-- Dump of table instance
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `instance`;

CREATE TABLE `instance`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
    `app_id`             varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'AppID',
    `cluster_name`       varchar(32)     NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
    `data_center`        varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'Data Center Name',
    `ip`                 varchar(32)     NOT NULL DEFAULT '' COMMENT 'instance ip',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_time` timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `IX_UNIQUE_KEY` (`app_id`, `cluster_name`, `ip`, `data_center`),
    KEY `IX_IP` (`ip`),
    KEY `IX_DataChange_LastTime` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='使用配置的应用实例';



-- Dump of table instanceconfig
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `instance_config`;

CREATE TABLE `instance_config`
(
    `id`                    bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
    `instance_id`           bigint unsigned          DEFAULT NULL COMMENT 'Instance Id',
    `config_app_id`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'Config App Id',
    `config_cluster_name`   varchar(32)     NOT NULL DEFAULT 'default' COMMENT 'Config Cluster Name',
    `config_namespace_name` varchar(32)     NOT NULL DEFAULT 'default' COMMENT 'Config Namespace Name',
    `release_key`           varchar(64)     NOT NULL DEFAULT '' COMMENT '发布的Key',
    `release_delivery_time` timestamp       NULL     DEFAULT NULL COMMENT '配置获取时间',
    `created_time`          timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_time`    timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `IX_UNIQUE_KEY` (`instance_id`, `config_app_id`, `config_namespace_name`),
    KEY `IX_ReleaseKey` (`release_key`),
    KEY `IX_DataChange_LastTime` (`last_modified_time`),
    KEY `IX_Valid_Namespace` (`config_app_id`, `config_cluster_name`, `config_namespace_name`, `last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='应用实例的配置信息';



-- Dump of table item
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item`
(
    `id`                 bigint unsigned     NOT NULL AUTO_INCREMENT COMMENT '自增Id',
    `namespace_id`       bigint unsigned     NOT NULL DEFAULT '0' COMMENT '集群NamespaceId',
    `key`                varchar(128)        NOT NULL DEFAULT 'default' COMMENT '配置项Key',
    `type`               tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置项类型，0: String，1: Number，2: Boolean，3: JSON',
    `value`              longtext            NOT NULL COMMENT '配置项值',
    `comment`            varchar(1024)                DEFAULT '' COMMENT '注释',
    `line_num`           bigint unsigned              DEFAULT '0' COMMENT '行号',
    `is_deleted`         bit(1)              NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp           NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)         NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp           NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)                  DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp           NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    KEY `IX_GroupId` (`namespace_id`),
    KEY `last_modified_time` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='配置项目';



-- Dump of table namespace
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `namespace`;

CREATE TABLE `namespace`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `app_id`             varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'AppID',
    `cluster_name`       varchar(500)    NOT NULL DEFAULT 'default' COMMENT 'Cluster Name',
    `namespace_name`     varchar(500)    NOT NULL DEFAULT 'default' COMMENT 'Namespace Name',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_AppId_ClusterName_NamespaceName_DeletedAt` (`app_id`, `cluster_name`(191), `namespace_name`(191), `is_deleted`),
    KEY `last_modified_time` (`last_modified_time`),
    KEY `IX_NamespaceName` (`namespace_name`(191))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='命名空间';



-- Dump of table namespacelock
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `namespace_lock`;

CREATE TABLE `namespace_lock`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `namespace_id`       bigint unsigned NOT NULL DEFAULT '0' COMMENT '集群NamespaceId',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_NamespaceId_DeletedAt` (`namespace_id`, `is_deleted`),
    KEY `last_modified_time` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='namespace的编辑锁';



-- Dump of table release
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `release`;

CREATE TABLE `release`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `release_key`        varchar(64)     NOT NULL DEFAULT '' COMMENT '发布的Key',
    `name`               varchar(64)     NOT NULL DEFAULT 'default' COMMENT '发布名字',
    `comment`            varchar(256)             DEFAULT NULL COMMENT '发布说明',
    `app_id`             varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'AppID',
    `cluster_name`       varchar(500)    NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
    `namespace_name`     varchar(500)    NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
    `Configurations`     longtext        NOT NULL COMMENT '发布配置',
    `IsAbandoned`        bit(1)          NOT NULL DEFAULT b'0' COMMENT '是否废弃',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_ReleaseKey_DeletedAt` (`release_key`, `is_deleted`),
    KEY `AppId_ClusterName_GroupName` (`app_id`, `cluster_name`(191), `namespace_name`(191)),
    KEY `last_modified_time` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='发布';


-- Dump of table releasehistory
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `release_history`;

CREATE TABLE `release_history`
(
    `id`                 bigint unsigned     NOT NULL AUTO_INCREMENT COMMENT '自增Id',
    `app_id`             varchar(64)         NOT NULL DEFAULT 'default' COMMENT 'AppID',
    `cluster_name`       varchar(32)         NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
    `namespace_name`     varchar(32)         NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
    `branch_name`        varchar(32)         NOT NULL DEFAULT 'default' COMMENT '发布分支名',
    `release_id`         bigint unsigned     NOT NULL DEFAULT '0' COMMENT '关联的Release Id',
    `PreviousReleaseId`  bigint unsigned     NOT NULL DEFAULT '0' COMMENT '前一次发布的ReleaseId',
    `operation`          tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布类型，0: 普通发布，1: 回滚，2: 灰度发布，3: 灰度规则更新，4: 灰度合并回主分支发布，5: 主分支发布灰度自动发布，6: 主分支回滚灰度自动发布，7: 放弃灰度',
    `operation_context`  longtext            NOT NULL COMMENT '发布上下文信息',
    `is_deleted`         bit(1)              NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp           NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)         NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp           NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)                  DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp           NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    KEY `IX_Namespace` (`app_id`, `cluster_name`, `namespace_name`, `branch_name`),
    KEY `IX_ReleaseId` (`release_id`),
    KEY `IX_DataChange_LastTime` (`last_modified_time`),
    KEY `IX_PreviousReleaseId` (`PreviousReleaseId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='发布历史';


-- Dump of table releasemessage
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `release_message`;

CREATE TABLE `release_message`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `message`            varchar(1024)   NOT NULL DEFAULT '' COMMENT '发布的消息内容',
    `last_modified_time` timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    KEY `last_modified_time` (`last_modified_time`),
    KEY `IX_Message` (`Message`(191))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='发布消息';



-- Dump of table serverconfig
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `server_config`;

CREATE TABLE `server_config`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
    `key`                varchar(64)     NOT NULL DEFAULT 'default' COMMENT '配置项Key',
    `cluster`            varchar(32)     NOT NULL DEFAULT 'default' COMMENT '配置对应的集群，default为不针对特定的集群',
    `value`              varchar(2048)   NOT NULL DEFAULT 'default' COMMENT '配置项值',
    `comment`            varchar(1024)            DEFAULT '' COMMENT '注释',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_Key_Cluster_DeletedAt` (`key`, `Cluster`, `is_deleted`),
    KEY `last_modified_time` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='配置服务自身配置';

-- Dump of table accesskey
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `access_key`;

CREATE TABLE `access_key`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `app_id`             varchar(64)     NOT NULL DEFAULT 'default' COMMENT 'AppID',
    `secret`             varchar(128)    NOT NULL DEFAULT '' COMMENT 'Secret',
    `is_enabled`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: enabled, 0: disabled',
    `is_deleted`         bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`         timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`         varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`       timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`   varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time` timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_AppId_Secret_DeletedAt` (`app_id`, `Secret`, `is_deleted`),
    KEY `last_modified_time` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='访问密钥';


-- Dump of table serviceregistry
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `service_registry`;

CREATE TABLE `service_registry`
(
    `id`                 bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
    `service_name`       VARCHAR(64)     NOT NULL COMMENT '服务名',
    `uri`                VARCHAR(64)     NOT NULL COMMENT '服务地址',
    `cluster`            VARCHAR(64)     NOT NULL COMMENT '集群，可以用来标识apollo.cluster或者网络分区',
    `metadata`           VARCHAR(1024)   NOT NULL DEFAULT '{}' COMMENT '元数据，key value结构的json object，为了方面后面扩展功能而不需要修改表结构',
    `created_time`       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_time` TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    UNIQUE INDEX `IX_UNIQUE_KEY` (`service_name`, `uri`),
    INDEX `IX_DataChange_LastTime` (`last_modified_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='注册中心';

-- Dump of table AuditLog
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `audit_log`;

CREATE TABLE `audit_log`
(
    `id`                   bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `trace_id`             varchar(32)     NOT NULL DEFAULT '' COMMENT '链路全局唯一ID',
    `span_id`              varchar(32)     NOT NULL DEFAULT '' COMMENT '跨度ID',
    `parent_spend_id`      varchar(32)              DEFAULT NULL COMMENT '父跨度ID',
    `follows_from_span_id` varchar(32)              DEFAULT NULL COMMENT '上一个兄弟跨度ID',
    `operator`             varchar(64)     NOT NULL DEFAULT 'anonymous' COMMENT '操作人',
    `op_type`              varchar(50)     NOT NULL DEFAULT 'default' COMMENT '操作类型',
    `op_name`              varchar(150)    NOT NULL DEFAULT 'default' COMMENT '操作名称',
    `description`          varchar(200)             DEFAULT NULL COMMENT '备注',
    `is_deleted`           bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`           timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`           varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`         timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`     varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time`   timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    KEY `IX_TraceId` (`trace_id`),
    KEY `IX_OpName` (`op_name`),
    KEY `IX_DataChange_CreatedTime` (`created_time`),
    KEY `IX_Operator` (`Operator`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='审计日志表';

-- Dump of table AuditLogDataInfluence
-- ------------------------------------------------------------

DROP TABLE IF EXISTS `audit_log_data_influence`;

CREATE TABLE `audit_log_data_influence`
(
    `id`                    bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `span_id`               char(32)        NOT NULL DEFAULT '' COMMENT '跨度ID',
    `influence_entity_id`   varchar(50)     NOT NULL DEFAULT '0' COMMENT '记录ID',
    `influence_entity_name` varchar(50)     NOT NULL DEFAULT 'default' COMMENT '表名',
    `field_name`            varchar(50)              DEFAULT NULL COMMENT '字段名称',
    `field_old_value`       varchar(500)             DEFAULT NULL COMMENT '字段旧值',
    `field_new_value`       varchar(500)             DEFAULT NULL COMMENT '字段新值',
    `is_deleted`            bit(1)          NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
    `deleted_at`            timestamp       NULL     DEFAULT NULL COMMENT '删除实际',
    `created_by`            varchar(64)     NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
    `created_time`          timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `last_modified_by`      varchar(64)              DEFAULT '' COMMENT '最后修改人邮箱前缀',
    `last_modified_time`    timestamp       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`id`),
    KEY `IX_SpanId` (`span_id`),
    KEY `IX_DataChange_CreatedTime` (`created_time`),
    KEY `IX_EntityId` (`influence_entity_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='审计日志数据变动表';

-- Config
-- ------------------------------------------------------------
INSERT INTO `server_config` (`key`, `cluster`, `value`, `comment`)
VALUES ('eureka.service.url', 'default', 'http://localhost:8080/eureka/', 'Eureka服务Url，多个service以英文逗号分隔'),
       ('namespace.lock.switch', 'default', 'false', '一次发布只能有一个人修改开关'),
       ('item.key.length.limit', 'default', '128', 'item key 最大长度限制'),
       ('item.value.length.limit', 'default', '20000', 'item value最大长度限制'),
       ('config-service.cache.enabled', 'default', 'false',
        'ConfigService是否开启缓存，开启后能提高性能，但是会增大内存消耗！');
