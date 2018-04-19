FROM atlassian/default-image:2.02

ENV CLOUD_SDK_VERSION 198.0.0

RUN apt-get -qqy update && apt-get install -qqy \
        apt-transport-https \
&& export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
&& echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
&& apt-get update \
&& apt-get install -qqy google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
        kubectl\
&& gcloud config set core/disable_usage_reporting true \
&& gcloud config set component_manager/disable_update_check true \
&& gcloud config set metrics/environment github_docker_image \
&& rm -rf /var/lib/apt/lists/
