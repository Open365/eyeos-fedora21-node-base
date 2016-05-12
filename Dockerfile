FROM fedora:21

MAINTAINER eyeos

ENV InstallationDir /var/service/

RUN yum remove -y mlocate && yum install hostname git nodejs npm which make gcc gcc-c++ kernel-devel libjpeg-turbo-devel \
	cairo-devel systemd-devel pkgconfig libpng12-devel libpng12 liberation-sans-fonts unzip curl \
	nmap dnsmasq net-tools bind-utils -y && yum clean all

RUN npm install -g npm@2.14.4 && \
				npm config set registry "http://artifacts.eyeosbcn.com/nexus/content/groups/npm/" && \
				npm -g cache clean && \
				npm cache clean && \
				npm install -g grunt-cli istanbul bower && \
				npm install -g eyeos-run-server eyeos-tags-to-dns && \
				/bin/echo '{"allow-root":true}' > /root/.bowerrc && \
				echo 'email = systems@eyeos.com' >> /root/.npmrc && \
				echo '_auth = c2VydmljZXM6c3VwZXIxcTJ3M2U0cjIwMTUtLiE=' >> /root/.npmrc && \
				curl -L https://releases.hashicorp.com/serf/0.6.4/serf_0.6.4_linux_amd64.zip -o serf.zip && unzip serf.zip && mv serf /usr/bin/serf

RUN git config --global user.email "jenkins@eyeos.com" \
    && git config --global user.name "Jenkins"

RUN cp /usr/share/zoneinfo/Europe/Madrid /etc/localtime

COPY dnsmasq.conf /etc/dnsmasq.d/
COPY netrc /root/.netrc
COPY registerIntoBower.sh /root/
COPY publishIntoNpm.sh /root/
