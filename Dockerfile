 FROM piraeus-client:v1.0.10 AS builder

 FROM python:alpine

 COPY --from=builder /usr/lib/python2.7/site-packages/linstor* /usr/local/lib/python2.7/site-packages/

 RUN ls /usr/local/lib/python2.7/site-packages