FROM piraeus-client:v1.0.10 AS builder

RUN mkdir -vp /tmp/site

RUN cp -vr /usr/lib/python2.7/site-packages/*linstor* /tmp/site/

RUN cp -v /usr/bin/linstor /tmp/site/linstor-bin

RUN sed -i 's#/usr/bin/python#/usr/local/bin/python#g' /tmp/site/linstor-bin

FROM python:2-alpine

COPY --from=builder /tmp /tmp/

RUN set -x && \
    mv -v /tmp/site/linstor-bin /usr/local/bin/linstor && \
    mv -v /tmp/site/*linstor* /usr/local/lib/python2.7/site-packages/

ENTRYPOINT [linstor]
