FROM confluentinc/cp-server-connect:7.4.0 AS base

USER root

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-azure-blob-storage:1.6.15 \
    && confluent-hub install --no-prompt confluentinc/kafka-connect-azure-blob-storage-source:2.5.3

USER user