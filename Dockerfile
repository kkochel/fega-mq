FROM rabbitmq:3.12.1-management-alpine

ARG BUILD_DATE
ARG SOURCE_COMMIT

LABEL org.opencontainers.image.authors=""
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-url=""
LABEL org.label-schema.vcs-ref=$SOURCE_COMMIT

ENV RABBITMQ_CONFIG_FILE=/var/lib/rabbitmq/rabbitmq.conf

COPY *.json /etc/rabbitmq/

RUN rabbitmq-plugins enable --offline rabbitmq_federation rabbitmq_federation_management rabbitmq_shovel rabbitmq_shovel_management

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rabbitmq-server"]