FROM amazoncorretto:8

RUN yum update -y
RUN yum -y install openssl-libs-1:1.0.2k-24.amzn2.0.3.aarch64 vim-minimal-2:8.2.4857-1.amzn2.0.1.aarch64 vim-data-2:8.2.4857-1.amzn2.0.1.noarch \
        python-2.7.18-1.amzn2.0.5.aarch64 python-libs-2.7.18-1.amzn2.0.5.aarch64 curl-7.79.1-2.amzn2.0.1.aarch64 libcurl-7.79.1-2.amzn2.0.1.aarch64

RUN  mkdir $JAVA_HOME/lib/security && cd $JAVA_HOME/lib/security/ && \
    curl https://s3.amazonaws.com/rds-downloads/rds-ca-2019-root.pem -o $JAVA_HOME/lib/security/rds-ca-2019-root.pem  && \
                $JAVA_HOME/bin/keytool -importcert -file $JAVA_HOME/lib/security/rds-ca-2019-root.pem -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -noprompt -trustcacerts -alias centimerds


COPY dd-java-agent.jar  /usr/app/
